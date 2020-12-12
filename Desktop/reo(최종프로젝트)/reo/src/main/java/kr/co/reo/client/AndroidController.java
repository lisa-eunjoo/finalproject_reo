package kr.co.reo.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.co.reo.admin.office.service.AdminOfficeService;
import kr.co.reo.client.member.service.MemberService;
import kr.co.reo.client.member.service.SessionListener;
import kr.co.reo.client.office.service.ClientOfficeService;
import kr.co.reo.client.pay.service.PayService;
import kr.co.reo.client.qna.service.QnaClientService;
import kr.co.reo.client.reservation.service.ReservationService;
import kr.co.reo.common.dto.AndroidSearchDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.PageMaker;
import kr.co.reo.common.dto.PayDTO;
import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.ReservationAndroidDTO;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Controller
public class AndroidController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private QnaClientService qnaService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	private ClientOfficeService clientOfficeService;
	@Autowired
	private AdminOfficeService adminOfficeService;
	@Autowired
	private PayService payService;

	@RequestMapping("androidQnaList.reo")
	public String getandQnaList(QnaDTO dto, Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception {

		List<QnaDTO> list = qnaService.getQnaList(scri);
		model.addAttribute("qnaList", list); // model 정보저장

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaService.getQnaListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);
		return "client/qna/androidQnaList"; // view 이름 리턴
	}

	@RequestMapping(value = "/android/qrscan.reo")
	public @ResponseBody int QRscan(@RequestParam String mem_email, Model model) {
		System.out.println(mem_email);
		ArrayList<MemberDTO> dto = new ArrayList<MemberDTO>();
		int res = 0;
		try {
			dto.add(memberService.qrScan(mem_email));
			if (!dto.isEmpty()) {
				res = 1;
			} else {
				return res;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@RequestMapping(value = "/androidmypage.reo", method = RequestMethod.GET)
	public String mypage(Model model, HttpSession session, @RequestParam String mem_email) throws Exception {
		System.out.println(mem_email);
		MemberDTO dto = memberService.checkLoginEmail(mem_email);
		model.addAttribute("member", dto);
		return "client/member/andMypage";
	}

	// 안드로이드 로그인
	@RequestMapping(value = "/android/login.reo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<MemberDTO> androidloginMember(Model model, MemberDTO dto, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mem_email = request.getParameter("mem_email");
		String mem_pw = request.getParameter("mem_pw");
		ArrayList<MemberDTO> lists = new ArrayList<MemberDTO>();

		try {
			HttpSession session = request.getSession(true);
			session.setAttribute("mem_email", mem_email);
			SessionListener.getInstance().printloginUsers();

			if (!SessionListener.getInstance().isUsing(mem_email)) {
				dto = memberService.checkLoginEmail(mem_email);
				System.out.println("안드로이드 접근 확인");
				System.out.println(mem_email);

				if (!bCryptPasswordEncoder.matches(mem_pw, dto.getMem_pw())) {
					System.out.println(lists.toString());
					return lists;
				}
				lists.add(dto);

			} else {
				System.out.println("이미 아이디가 접속중 입니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lists;
	}

	// 안드로이드 내 예약 리스트 확인 (지난 예약)
	@RequestMapping(value = "/android/reservCheck.reo")
	@ResponseBody
	public ArrayList<ReservationAndroidDTO> getMyResListAndroid(@ModelAttribute ReservationDTO dto,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo, Model model, HttpServletRequest request)
			throws IOException {
		dto.setDevice("Mobile");
		ArrayList<ReservationDTO> pasResList = (ArrayList<ReservationDTO>) reservationService.getResPastList(dto);
		System.out.println("지난 리스트 :" + pasResList.size());

		ArrayList<ReservationAndroidDTO> android = new ArrayList<ReservationAndroidDTO>();
		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (ReservationDTO list : pasResList) {
			String start = simple.format(list.getRes_startdatetime());
			String end = simple.format(list.getRes_enddatetime());
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					ReservationAndroidDTO tool = new ReservationAndroidDTO();
					tool.setRes_startdatetime(start);
					tool.setRes_enddatetime(end);
					tool.setMem_agentName(list.getMem_agentName());
					tool.setMem_email(list.getMem_email());
					tool.setMem_name(list.getMem_name());
					tool.setMem_tel(list.getMem_tel());
					tool.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					tool.setOff_name(list.getOff_name());
					tool.setOff_no(list.getOff_no());
					tool.setOff_stdAddr(list.getOff_stdAddr());
					tool.setOff_unit(list.getOff_unit());
					tool.setRes_memo(list.getRes_memo());
					tool.setRes_no(list.getRes_no());
					tool.setRes_people(list.getRes_people());
					tool.setRes_state(list.getRes_state());
					tool.setRoom_price(list.getRoom_price());
					android.add(tool);
				}
			} catch (NullPointerException e) {
				continue;
			}

		}

		return android;
	}

	// 안드로이드 내 예약 리스트 확인 (현재 예약 전부다)
	@RequestMapping(value = "/android/reservCheck2.reo")
	@ResponseBody
	public ArrayList<ReservationAndroidDTO> getMyResListAndroid2(@ModelAttribute ReservationDTO dto,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo, Model model, HttpServletRequest request)
			throws IOException {
		System.out.println(dto.getMem_email());
		dto.setDevice("Mobile");
		ArrayList<ReservationDTO> nowResList = (ArrayList<ReservationDTO>) reservationService.getMyResList(dto);
		System.out.println(nowResList.size());

		ArrayList<ReservationAndroidDTO> android = new ArrayList<ReservationAndroidDTO>();

		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (ReservationDTO list : nowResList) {
			String start = simple.format(list.getRes_startdatetime());
			String end = simple.format(list.getRes_enddatetime());
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					ReservationAndroidDTO tool = new ReservationAndroidDTO();
					tool.setRes_startdatetime(start);
					tool.setRes_enddatetime(end);
					tool.setMem_agentName(list.getMem_agentName());
					tool.setMem_email(list.getMem_email());
					tool.setMem_name(list.getMem_name());
					tool.setMem_tel(list.getMem_tel());
					tool.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					tool.setOff_name(list.getOff_name());
					tool.setOff_no(list.getOff_no());
					tool.setOff_stdAddr(list.getOff_stdAddr());
					tool.setOff_unit(list.getOff_unit());
					tool.setRes_memo(list.getRes_memo());
					tool.setRes_no(list.getRes_no());
					tool.setRes_people(list.getRes_people());
					tool.setRes_state(list.getRes_state());
					tool.setRoom_price(list.getRoom_price());
					android.add(tool);
				}
			} catch (NullPointerException e) {
				continue;
			}

		}

		return android;
	}

	// 안드로이드 예약추가//
	@RequestMapping(value = "/android/makeReserv.reo", method = RequestMethod.POST)
	@ResponseBody
	public int androidMakeReservation(ReservationDTO dto) throws IOException {

		ArrayList<ReservationDTO> resdate;
		if (dto.getOff_unit().equals("월")) {
			resdate = (ArrayList<ReservationDTO>) reservationService.getResMonth(dto);
		} else {
			resdate = (ArrayList<ReservationDTO>) reservationService.getResAddList(dto);
		}
		try {
			for (int i = 0; i <= resdate.size(); i++) {
				if ((dto.getRes_startdatetime().equals(resdate.get(i).getRes_startdatetime()))
						&& (dto.getRes_enddatetime().equals(resdate.get(i).getRes_enddatetime()))) {
					return 0;
				}
			}
		} catch (Exception e) {

		}
		reservationService.makeReservation(dto);
		int number = reservationService.getMaxResNo();
		return number;
	}

	// 안드로이드 시간 예약 리스트//
	@RequestMapping(value = "/android/reservAddList.reo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<String> AndroidReservAddList(@ModelAttribute ReservationDTO dto) throws IOException {
		System.out.println(dto.getOff_no());
		System.out.println(dto.getRes_datetime());
		ArrayList<ReservationDTO> resdate = (ArrayList<ReservationDTO>) reservationService.getResAddList(dto);
		ArrayList<String> datelist = new ArrayList<String>();

		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < resdate.size(); i++) {
			String start = simple.format(resdate.get(i).getRes_startdatetime());
			String end = simple.format(resdate.get(i).getRes_enddatetime());
			datelist.add(start);
			datelist.add(end);
			System.out.println(start);
			System.out.println(end);

		}
		return datelist;
	}

	// 안드로이드 월 예약 리스트//
	@RequestMapping(value = "/android/resMonth.reo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<String> AndroidResMonth(@ModelAttribute ReservationDTO dto) throws IOException {
		System.out.println(dto.getOff_no());
		ArrayList<ReservationDTO> resdate = (ArrayList<ReservationDTO>) reservationService.getResMonth(dto);
		ArrayList<String> datelist = new ArrayList<String>();

		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < resdate.size(); i++) {
			String start = simple.format(resdate.get(i).getRes_startdatetime());
			String end = simple.format(resdate.get(i).getRes_enddatetime());
			datelist.add(start);
			datelist.add(end);
		}
		return datelist;
	}

	// 안드로이드 type별 사무실
	@RequestMapping("/android/getOfficeListByType.reo")
	public @ResponseBody List<OfficeDTO> androidgetOfficeListByUnit(HttpServletRequest request,
			@RequestParam(value = "SORD", defaultValue = "desc", required = false) String sord,
			@RequestParam(value = "SIDX", defaultValue = "off_no", required = false) String sidx,
			@RequestParam(value = "offopt_name", required = false) List<String> options) {

		HashMap<String, Object> filterMap = new HashMap<String, Object>();

		filterMap.put("off_type", request.getParameter("off_type"));
		filterMap.put("offopt_name", options);

		filterMap.put("SORD", sord);
		filterMap.put("SIDX", sidx);

		int index = 0;
		List<OfficeDTO> sortList = new ArrayList<OfficeDTO>();

		sortList = clientOfficeService.getOfficeListByUnit(filterMap);

		System.out.println(sortList.get(0).getOff_name());
		for (OfficeDTO list : sortList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					sortList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		return sortList;

	}

	// 안드로이드 사무실 상세보기
	@RequestMapping("/android/getOffice.reo")
	@ResponseBody
	public ArrayList<OfficeDTO> androidgetOffice(OfficeDTO offDto, Model model, HttpServletRequest request) {

		OfficeDTO tmpOffDto = clientOfficeService.getOffice(offDto);
		ArrayList<OfficeDTO> relativeOffList = new ArrayList<OfficeDTO>();
		relativeOffList.add(tmpOffDto);

		int index = 0;

		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		for (OfficeDTO list : relativeOffList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					relativeOffList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		return relativeOffList;
	}

	// 안드로이드 사무실 옵션 상세보기
	@RequestMapping("/android/getOfficeOpt.reo")
	@ResponseBody
	public ArrayList<OffOptDTO> androidgetOfficeOpt(OfficeDTO offDto, Model model, HttpServletRequest request) {
		System.out.println(offDto.getOff_no());
		ArrayList<OffOptDTO> relativeOffoptList = (ArrayList<OffOptDTO>) adminOfficeService.getOffopts(offDto);
		return relativeOffoptList;
	}

	@RequestMapping("/android/getOfficeImgs.reo")
	@ResponseBody
	public ArrayList<OffImgsDTO> androidgetOfficeImgs(OfficeDTO offDto, Model model, HttpServletRequest request) {

		ArrayList<OffImgsDTO> relativeOffList = (ArrayList<OffImgsDTO>) clientOfficeService.getOffimgs(offDto);
		return relativeOffList;
	}

	// 안드로이드 사무실 전체리스트
	@RequestMapping("/android/getOfficeList.reo")
	@ResponseBody
	public ArrayList<OfficeDTO> getAndroidBoardList(Model model, HttpServletRequest request, OfficeDTO dto) {

		ArrayList<OfficeDTO> initialList = (ArrayList<OfficeDTO>) clientOfficeService.getOfficeAllList();
		int index = 0;
		for (OfficeDTO list : initialList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					initialList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		model.addAttribute("officeList", initialList);
		return initialList;
	}

	// 안드로이드 pay
	@RequestMapping(value = "/android/kPayReady/{offNo}/{resNo}/{price}/{mem_email}")
	public String kakaoPayReady(@PathVariable("mem_email") String mem_email, HttpServletRequest request,
			@PathVariable("offNo") int offNo, @PathVariable("resNo") int resNo, @PathVariable("price") String price,
			HttpSession session) {
		String host = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		Device currentDevice = DeviceUtils.getCurrentDevice(request);

		System.out.println(resNo);
		System.out.println(price);
		System.out.println(offNo);

		String device = "";
		if (currentDevice.isMobile()) {
			device = "Mobile";
		} else if (currentDevice.isTablet()) {
			device = "Tablet";
		} else {
			device = "Desktop";
		}
		session.setAttribute("mem_email", mem_email);
		System.out.println(session.getAttribute("mem_email"));
		String uri = payService.kakaoPayReady(mem_email, offNo, resNo, price, device, host);
		return uri;
	}

	@RequestMapping("/android/kPayApprove")
	public String kakaoPayApprove(HttpServletRequest request, String pg_token, RedirectAttributes redirect) {
		Device currentDevice = DeviceUtils.getCurrentDevice(request);
		String device = "";
		if (currentDevice.isMobile()) {
			device = "Mobile";
		} else if (currentDevice.isTablet()) {
			device = "Tablet";
		} else {
			device = "Desktop";
		}
		String uri = payService.kakaoPayApprove(request.getSession().getAttribute("mem_email").toString(), pg_token,
				device);

		return uri;
	}

	@RequestMapping("/android/kPay/{type}")
	public String kakaoPayAfter(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirect, @PathVariable("type") String type, Model model) {
		String mem_email = (String) session.getAttribute("mem_email");
		Device currentDevice = DeviceUtils.getCurrentDevice(request);
		String device = "";
		if (currentDevice.isMobile()) {
			device = "Mobile";
		} else if (currentDevice.isTablet()) {
			device = "Tablet";
		} else {
			device = "Desktop";
		}

		if (type.equals("Fail")) {
			payService.updatekPayType(mem_email, type);
		} else if (type.equals("CancelBefore")) {
			payService.updatekPayType(mem_email, type);
		}

		if (!device.equals("Desktop")) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter writer = response.getWriter();
				writer.print("<script type='text/javascript'>");
				writer.print("window.android.setMessage('" + type + "');");
				writer.print("window.close()");
				writer.print("</script>");
				writer.flush();
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	@RequestMapping(value = "/android/deleteReserv.reo", method = RequestMethod.GET)
	public void myResInfoDel(HttpServletRequest request, ReservationDTO dto, Model model) throws IOException {
		System.out.println(dto.getRes_no());
		reservationService.updateMyResInfoDel(dto);
	}

	@RequestMapping(value = "/android/{keyword}/search.reo", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<OfficeDTO> firstEnter(@PathVariable("keyword") String keyword) throws IOException {
		System.out.println(keyword);
		ArrayList<OfficeDTO> initialList = (ArrayList<OfficeDTO>) clientOfficeService
				.getOfficeByKeyword(keyword.trim());
		int index = 0;
		for (OfficeDTO list : initialList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					initialList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		return initialList;

	}

	@RequestMapping(value = "/android/getSearchList.reo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<AndroidSearchDTO> searchList() throws IOException {
		ArrayList<AndroidSearchDTO> and = (ArrayList<AndroidSearchDTO>) clientOfficeService.getOfficeByListSearch();
		System.out.println(and.get(0).getOff_stdAddr());
		return and;

	}

	@RequestMapping(value = "/android/kPayCancel/{mem_email}/{payNo}/{resNo}", method = RequestMethod.POST)
	@ResponseBody
	public void kakaoPayCancel(HttpSession session, @PathVariable("mem_email") String mem_email,
			@PathVariable("payNo") String payNo, @PathVariable("resNo") int resNo) {
		payService.kakaoPayCancel(mem_email.trim(), payNo, resNo);

	}

	@RequestMapping("/android/myPayList/{mem_email}")
	@ResponseBody
	public ArrayList<PayDTO> myPayList(HttpSession session, PayDTO payDTO,
			@PathVariable("mem_email") String mem_email) {
		payDTO.setMem_email(mem_email);
		System.out.println("payList: " + mem_email);
		ArrayList<PayDTO> list = (ArrayList<PayDTO>) payService.getMyPayList(payDTO);
		System.out.println(list.get(0).getPay_no() + list.get(0).getPay_state() + " " + list.get(0).getRes_no());
		for (PayDTO pay : list) {
			pay.setRes_startdatetime(new Timestamp(0L));
		}

		return list;
	}

	// 호스의 다른 공간 불러오기
	@RequestMapping("/android/getOfficehostList.reo")
	@ResponseBody
	public List<OfficeDTO> getOffice(OfficeDTO offDto, Model model, HttpServletRequest request)
			throws JsonProcessingException {

		System.out.println("호스트의 다른공간 : " + offDto.getOff_no());
		int index = 0;

		OfficeDTO tmpOffDto = adminOfficeService.getOffice(offDto);
		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		List<OfficeDTO> relativeOffList = adminOfficeService.getOfficeByemail(offDto);
		for (OfficeDTO list : relativeOffList) {
			try {
				if (adminOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(adminOfficeService.getOffimgOne(list).getOffimg_name());
					relativeOffList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		return relativeOffList;
	}

	@RequestMapping(value = "/android/reservDeatil.reo")
	@ResponseBody
	public ReservationAndroidDTO getMyReservDetail(@ModelAttribute ReservationDTO dto,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo, Model model, HttpServletRequest request)
			throws IOException {
		System.out.println(dto.getRes_no());
		ReservationDTO res = reservationService.getMyResInfo(dto);

		ArrayList<ReservationAndroidDTO> android = new ArrayList<ReservationAndroidDTO>();

		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String start = simple.format(res.getRes_startdatetime());
		String end = simple.format(res.getRes_enddatetime());
		ReservationAndroidDTO tool = new ReservationAndroidDTO();
		try {
			if (clientOfficeService.getOffimgOne(res).getOffimg_name() != null) {

				tool.setRes_startdatetime(start);
				tool.setRes_enddatetime(end);
				tool.setMem_agentName(res.getMem_agentName());
				tool.setMem_email(res.getMem_email());
				tool.setMem_name(res.getMem_name());
				tool.setMem_tel(res.getMem_tel());
				tool.setOff_image(clientOfficeService.getOffimgOne(res).getOffimg_name());
				tool.setOff_name(res.getOff_name());
				tool.setOff_no(res.getOff_no());
				tool.setOff_stdAddr(res.getOff_stdAddr());
				tool.setOff_unit(res.getOff_unit());
				tool.setRes_memo(res.getRes_memo());
				tool.setRes_no(res.getRes_no());
				tool.setRes_people(res.getRes_people());
				tool.setRes_state(res.getRes_state());
				tool.setRoom_price(res.getRoom_price());
				android.add(tool);
			}
		} catch (NullPointerException e) {

		}

		return tool;
	}

}