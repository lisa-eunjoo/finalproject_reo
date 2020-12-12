package kr.co.reo.client;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.reo.client.office.service.ClientOfficeService;
import kr.co.reo.client.pay.service.PayService;
import kr.co.reo.client.reservation.service.ReservationService;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
@SessionAttributes("myresList")
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private ClientOfficeService clientOfficeService;
	@Autowired
	private PayService payService;
	//예약 신청 
	@RequestMapping(value = "/mybooking.reo", method = RequestMethod.POST)
	public String getMyResList(ReservationDTO dto, HttpSession session, Model model,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo) throws IOException {
		String mem_email = (String) session.getAttribute("mem_email"); //회원로그인 후 세션에 로그인 정보 저장 
		String mem_name = (String) session.getAttribute("mem_name");
		dto.setMem_email(mem_email);
		dto.setMem_name(mem_name);
		reservationService.makeReservation(dto); //예약진행(insert 쿼리 사용)
		reservationService.getMaxResNo(); 
		if (dto.getPageNo() < 1) { 
			dto.setPageNo(1);
		}
		int resNowCount = reservationService.getResNowCount(dto); // 현재 예약 페이징 처리
		int resPastCount = reservationService.getResPastCount(dto); //지난 예약 페이징 처리
		String pagingnow = pageUtil.paging(dto.getPageNo(), resNowCount, "mybooking.reo", "");
		String pagingpast = pageUtil.paging(dto.getPageNo(), resPastCount, "mybooking.reo", "");
		model.addAttribute("myresList", reservationService.getMyResList(dto));
		model.addAttribute("myPastList", reservationService.getResPastList(dto));
		model.addAttribute("pagingnow", pagingnow);
		model.addAttribute("pagingpast", pagingpast);
		return "redirect:/mybooking.reo?pageNo=" + pageNo;
	}
	//시간 단위 예약 시, 시간 선택 시 예약되어 있는 예약시간 조회
	@RequestMapping(value = "/reservAddList.reo", method = RequestMethod.POST)
	@ResponseBody // json객체만 리턴
	public List<ReservationDTO> reservAddList(@ModelAttribute ReservationDTO dto) throws IOException {
		List<ReservationDTO> resdate = reservationService.getResAddList(dto);
		return resdate;
	}
	// 월 단위 예약 시, 달력 선택 할 때 예약되어 있는 날짜 조회
	@RequestMapping(value = "/resMonth.reo", method = RequestMethod.GET)
	@ResponseBody // json객체로 view 리턴
	public List<ReservationDTO> resMonth(String off_no) throws IOException {
		ReservationDTO dto = new ReservationDTO();
		dto.setOff_no(Integer.parseInt(off_no));
		List<ReservationDTO> resdate = reservationService.getResMonth(dto);
		return resdate;
	}
	// 내 예약 리스트 확인 (지난 예약, 현재 예약 리스트)
	@RequestMapping(value = "/mybooking.reo", method = RequestMethod.GET)
	public String getMyResList(@ModelAttribute ReservationDTO dto,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo, Model model, HttpServletRequest request)
			throws IOException {
		if (dto.getPageNo() < 1) {
			dto.setPageNo(1);
		}
		HttpSession session = request.getSession();
		dto.setMem_email(session.getAttribute("mem_email").toString());
		dto.setMem_sector(session.getAttribute("mem_sector").toString());
		int resNowCount = reservationService.getResNowCount(dto);
		int resPastCount = reservationService.getResPastCount(dto);
		String pagingnow = pageUtil.paging(dto.getPageNo(), resNowCount, "mybooking.reo", "");
		String pagingpast = pageUtil.paging(dto.getPageNo(), resPastCount, "mybooking.reo", "");

		model.addAttribute("myresList", reservationService.getMyResList(dto));
		model.addAttribute("myPastList", reservationService.getResPastList(dto));
		model.addAttribute("pagingnow", pagingnow);
		model.addAttribute("pagingpast", pagingpast);
		model.addAttribute("pageNo", pageNo);
		return "client/member/mybooking";
	}

	// 내 예약 내역 상세 확인
	@RequestMapping(value = "/myreservDetail.reo")
	public String getMyResInfo(@ModelAttribute ReservationDTO dto, Model model, HttpServletRequest request,
			OfficeDTO officedto) throws IOException {
		HttpSession session = request.getSession();
		dto.setMem_email(session.getAttribute("mem_email").toString());
		ReservationDTO reservationDTO = reservationService.getMyResInfo(dto);
		model.addAttribute("rescheck", reservationDTO);
		officedto.setOff_no(reservationDTO.getOff_no());
		model.addAttribute("off_images", clientOfficeService.getOffimgs(officedto));
		return "client/reservation/reservDetail";
	}

	@RequestMapping(value = "/reservModify.reo", method = RequestMethod.POST)
	public String myResInfoUpdate(ReservationDTO dto, Model model, HttpServletRequest request,
			@RequestParam("pageNo") int pageNo, HttpSession session) throws IOException {
		String mem = (String) session.getAttribute("mem_email");
		dto.setMem_email(mem);
		reservationService.updateMyResInfoUpdate(dto);
		dto.setMem_email(session.getAttribute("mem_email").toString());
		model.addAttribute("myresList", reservationService.getMyResList(dto));
		model.addAttribute(pageNo);
		return "redirect:/mybooking.reo?pageNo=" + pageNo;
	}

	// 내 예약 취소 및 환불
	@RequestMapping(value = "/deleteReserv.reo", method = RequestMethod.GET)
	public String myResInfoDel(HttpServletRequest request, ReservationDTO dto, @RequestParam("pageNo") int pageNo,
			Model model) throws IOException {
		HttpSession session = request.getSession();
		int res = (Integer) dto.getRes_no();
		String email = (String) session.getAttribute("mem_email");
		reservationService.updateMyResInfoDel(dto);
		payService.kakaoPayCancel(email, null, res);
		model.addAttribute(pageNo);
		return "redirect:/mybooking.reo";
	}

	// 내 예약 취소 및 환불
	@RequestMapping(value = "/reservCancel.reo", method = RequestMethod.GET)
	public String reservCancel(HttpServletRequest request, ReservationDTO dto, @RequestParam("pageNo") int pageNo,
			Model model) throws IOException {
		reservationService.updateMyResInfoDel(dto);
		model.addAttribute(pageNo);
		return "redirect:/mybooking.reo";
	}
}