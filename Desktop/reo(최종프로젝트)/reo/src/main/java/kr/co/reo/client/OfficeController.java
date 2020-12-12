package kr.co.reo.client;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.reo.admin.map.service.MapService;
import kr.co.reo.admin.office.service.AdminOfficeService;
import kr.co.reo.client.office.service.ClientOfficeService;
import kr.co.reo.client.reservation.service.ReservationService;
import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
public class OfficeController {
	private static final String RESULT_EXCEED_SIZE = "-2";
	private static final String RESULT_UNACCEPTED_EXTENSION = "-1";
	private static final String RESULT_SUCCESS = "1";
	private static final long LIMIT_SIZE = 10 * 1024 * 1024;
	private static final String UPLOAD_PATH = "./resources/upload/";

	@Autowired
	private ClientOfficeService clientOfficeService;
	@Autowired
	private AdminOfficeService adminOfficeService;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private MapService mapService;

	// 사무실 전체리스트
	@RequestMapping(value = "/getOfficeList.reo", method = RequestMethod.GET)
	public String getOfficeList(Model model, HttpServletRequest request, String pageNo, OfficeDTO dto)
			throws JsonProcessingException {
		if (pageNo == null || Integer.parseInt(pageNo) < 1) {
			pageNo = "1";
		}

		if (dto.getKeyword() == null) {
			dto.setKeyword("");
		}

		OfficeDTO offDTO = new OfficeDTO();
		offDTO.setOff_type("전체");
		int index = 0;

		List<OfficeDTO> recomdList = clientOfficeService.getRecomdList(offDTO);
		for (OfficeDTO list : recomdList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					recomdList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		model.addAttribute("recomdList", recomdList);

		index = 0;
		List<OfficeDTO> initialList = clientOfficeService.getOfficeList(dto);
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

//		int totalRows = clientOfficeService.getCount();

		int totalRows = 1001;

		String paging = pageUtil.paging(Integer.parseInt(pageNo), totalRows, "getOfficeList.reo", "");

		index = 0;
		model.addAttribute("keyword", dto.getKeyword());
		// 추가부분 끝

		model.addAttribute("officeList", initialList);
		model.addAttribute("paging", paging);

		return "/client/office/getOfficeList";
	}

	@RequestMapping(value = "/getOfficeList.reo", method = RequestMethod.POST)
	public String getOfficeListPost(Model model, HttpServletRequest request, String pageNo, OfficeDTO dto)
			throws JsonProcessingException {
		if (pageNo == null || Integer.parseInt(pageNo) < 1) {
			pageNo = "1";
		}
		String keyword = request.getParameter("keyword");
		keyword = keyword.replaceAll(",", "");
		dto.setKeyword(keyword);

		OfficeDTO offDTO = new OfficeDTO();
		offDTO.setOff_type("전체");
		int index = 0;

		List<OfficeDTO> recomdList = clientOfficeService.getRecomdList(offDTO);
		for (OfficeDTO list : recomdList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					recomdList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		model.addAttribute("recomdList", recomdList);

		index = 0;
		List<OfficeDTO> initialList = clientOfficeService.getOfficeList(dto);
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
		int totalRows = 1001;
		String paging = pageUtil.paging(Integer.parseInt(pageNo), totalRows, "getOfficeList.reo", "");
		// 추가부분

		index = 0;
		// 추가부분 끝
		model.addAttribute("keyword", keyword);
		model.addAttribute("officeList", initialList);
		model.addAttribute("paging", paging);
		if (!dto.getKeyword().equals("")) {
			try {
				new RestTemplate().postForLocation("http://localhost:8000/reo/search/" + dto.getKeyword() + "/"
						+ request.getSession().getAttribute("mem_email"), "");
			} catch (Exception e) {
				new RestTemplate().postForLocation("http://218.50.121.249:8000/reo/search/" + dto.getKeyword() + "/"
						+ request.getSession().getAttribute("mem_email"), "");
			}
		}

		return "/client/office/getOfficeList";
	}

	@RequestMapping("/getOfficeListByUnit.reo")
	public @ResponseBody List<OfficeDTO> getOfficeListByUnit(HttpServletRequest request, Model model,
			@RequestParam(value = "SORD", defaultValue = "desc", required = false) String sord,
			@RequestParam(value = "SIDX", defaultValue = "off_no", required = false) String sidx,
			@RequestParam(value = "offopt_name", required = false) List<String> options) {

		HashMap<String, Object> filterMap = new HashMap<String, Object>();
		OfficeDTO offDTO = new OfficeDTO();
		offDTO.setOff_type(request.getParameter("off_type"));
		int index = 0;

		List<OfficeDTO> recomdList = clientOfficeService.getRecomdList(offDTO);
		for (OfficeDTO list : recomdList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					recomdList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		model.addAttribute("recomdList", recomdList);

		filterMap.put("off_type", request.getParameter("off_type"));
		filterMap.put("off_unit", request.getParameter("off_unit"));
		filterMap.put("min_price", request.getParameter("min_price"));
		filterMap.put("max_price", request.getParameter("max_price"));
		filterMap.put("off_maxNum", request.getParameter("off_maxNum"));
		filterMap.put("keyword", request.getParameter("keyword"));
		filterMap.put("offopt_name", options);

		filterMap.put("SORD", sord);
		filterMap.put("SIDX", sidx);
		filterMap.put("limit", Integer.parseInt(request.getParameter("limit")));
		filterMap.put("offset", Integer.parseInt(request.getParameter("offset")));

		List<OfficeDTO> sortList = new ArrayList<OfficeDTO>();
		sortList = clientOfficeService.getOfficeListByUnit(filterMap);
		index = 0;
		OfficeDTO tempList = new OfficeDTO();
		for (OfficeDTO list : sortList) {
			try {
				if (clientOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(clientOfficeService.getOffimgOne(list).getOffimg_name());
					tempList = mapService.getMapOne(list.getOff_no());
					list.setMap_dong(tempList.getMap_dong());
					list.setMap_gu(tempList.getMap_gu());
					list.setMap_la(tempList.getMap_la());
					list.setMap_ln(tempList.getMap_ln());
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

	// 사업자의 마이 매물 리스트 조회
	@RequestMapping("/myOfficeList.reo")
	public String getMyOfficeList(HttpSession session, HttpServletRequest request, Model model, OfficeDTO offDTO,
			@RequestParam(value = "SORD", defaultValue = "desc", required = false) String sord,
			@RequestParam(value = "SIDX", defaultValue = "off_no", required = false) String sidx) {

		HashMap<String, Object> officeMap = new HashMap<String, Object>();
		int index = 0;
		officeMap.put("pageNo", request.getParameter("pageNo"));
		if (officeMap.get("pageNo") == null || Integer.parseInt(officeMap.get("pageNo").toString()) < 1) {
			officeMap.put("pageNo", 1);
		}

		officeMap.put("SORD", sord);
		officeMap.put("SIDX", sidx);
		officeMap.put("mem_email", session.getAttribute("mem_email"));

		List<OfficeDTO> sortList = new ArrayList<OfficeDTO>();
		sortList = clientOfficeService.getOffListByemail(officeMap);
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

		model.addAttribute("myOfficeList", sortList);
		int totalRows = clientOfficeService.getMyOfficeListCount(officeMap);
		String paging = pageUtil.paging(Integer.parseInt(officeMap.get("pageNo").toString()), totalRows,
				"myOfficeList.reo", "&SIDX=" + officeMap.get("SIDX") + "&SORD=" + officeMap.get("SORD"));
		model.addAttribute("paging", paging);

		return "/client/member/getMyOfficeList";
	}

	// 사업자 사무실 상세
	@RequestMapping("/detailOffice.reo")
	public String detailMyOffice(OfficeDTO offDto, Model model) {
		int index = 0;

		OfficeDTO tmpOffDto = adminOfficeService.getOffice(offDto);
		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		String[] typeArr = tmpOffDto.getOff_type().split(",");

		model.addAttribute("office", tmpOffDto);
		model.addAttribute("off_types", typeArr);
		model.addAttribute("off_images", adminOfficeService.getOffimgs(offDto));
		model.addAttribute("off_options", adminOfficeService.getOffopts(offDto));

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

		model.addAttribute("relativeOffice", relativeOffList);

		return "/admin/office/detailOffice";
	}

	// 사업자 사무실 수정
	@RequestMapping("/getMyOffice.reo")
	public String getMyOffice(OfficeDTO offDto, Model model) {
		int index = 0;

		OfficeDTO tmpOffDto = adminOfficeService.getOffice(offDto);
		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		String[] typeArr = tmpOffDto.getOff_type().split(",");

		model.addAttribute("office", tmpOffDto);
		model.addAttribute("off_types", typeArr);
		model.addAttribute("off_images", adminOfficeService.getOffimgs(offDto));
		model.addAttribute("off_options", adminOfficeService.getOffopts(offDto));

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

		model.addAttribute("relativeOffice", relativeOffList);

		return "/admin/office/getOffice";
	}

	// 사무실 상세보기
	@RequestMapping("/getOffice.reo")
	public String getOffice(OfficeDTO offDto, Model model, HttpServletRequest request) throws JsonProcessingException {
		HashMap<String, Object> wishmap = new HashMap<String, Object>();
		int index = 0;
		HttpSession session = request.getSession();

		wishmap.put("off_no", offDto.getOff_no());
		wishmap.put("mem_email", session.getAttribute("mem_email"));

		OfficeDTO tmpOffDto = clientOfficeService.getOffice(offDto);
		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		String[] typeArr = tmpOffDto.getOff_type().split(",");

		model.addAttribute("office", tmpOffDto);
		model.addAttribute("off_types", typeArr);
		model.addAttribute("off_images", clientOfficeService.getOffimgs(offDto));
		model.addAttribute("off_options", clientOfficeService.getOffopts(offDto));
		model.addAttribute("isWish", clientOfficeService.getSearchWish(wishmap));
		model.addAttribute("isLike", clientOfficeService.getSearchLike(wishmap));
		model.addAttribute("countLike", clientOfficeService.getCountLike(offDto));

		List<OfficeDTO> relativeOffList = clientOfficeService.getOfficeByemail(offDto);

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
		//
		OfficeDTO listone = mapService.getMapOne(offDto.getOff_no());
		ObjectMapper mapper = new ObjectMapper();
		String mapText = mapper.writeValueAsString(listone);
		model.addAttribute("maplist", mapText);
		model.addAttribute("relativeOffice", relativeOffList);

		return "/client/office/getOffice";
	}

	// 해당 사무실 이미지파일들 반환
	@RequestMapping("/getOffImage.reo")
	public @ResponseBody List<OffImgsDTO> getOffImage(OfficeDTO offDto, Model model) {

		return clientOfficeService.getOffimgs(offDto);
	}

	// 사무실 등록 페이지 이동
	@RequestMapping("/insertOfficeView.reo")
	public String insertOfficeView() {
		return "/admin/office/insertOffice";
	}

	// 사무실 등록
	@ResponseBody
	@RequestMapping(value = "/insertOffice.reo", method = RequestMethod.POST)
	public String insertOffice(HttpServletRequest request, HttpSession session, OfficeDTO offDto, MemberDTO memDto, OffImgsDTO offimgDto,
			OffOptDTO offoptDto, MapDTO mapDto, MultipartHttpServletRequest multi,
			@RequestParam(value = "addCount", defaultValue = "1") int addCount,
			@RequestParam("offopt_name") List<String> options, @RequestParam("files") List<MultipartFile> images)
			throws IOException {

		String mem_email = session.getAttribute("mem_email").toString();
		offDto.setMem_email(mem_email);

		// 멤버테이블에 중개인 이메일 검색
		memDto = adminOfficeService.getAgentNameTel(offDto);

		mapDto.setMap_address(offDto.getOff_stdAddr());
		mapDto.setMem_email(mem_email);
		boolean isTransimg = false;
		// 이메일 존재하면
		if (memDto != null) {
			for (int i = 0; i < addCount; i++) {
				if (i >= 1) {
					isTransimg = true;
				}

				// 파일 외의 office form요소들 처리
				offDto.setMem_agentName(memDto.getMem_agentName());
				offDto.setMem_agentTel(memDto.getMem_tel());

				adminOfficeService.insertOffice(offDto);
				long sizeSum = 0;
				int latest_offno = adminOfficeService.getLatestOffno(offDto);

				String filePath = request.getSession().getServletContext().getRealPath("./resources/qrimg/"); // System.getProperty("user.home") + "/Reo/qrimg/"
				String url = request.getRequestURL().toString(); // Full URL
				String contextPath = request.getContextPath(); // /reo
				String path = url.substring(0, url.indexOf(contextPath)); // http://localhost:8090
				adminOfficeService.createQRCode(filePath, path + contextPath, latest_offno);

				mapDto.setOff_no(latest_offno);
				mapService.insertMap(mapDto);
				// office 옵션들 처리
				if (!options.isEmpty()) {
					for (String option : options) {
						offoptDto.setOff_no(latest_offno);
						if (!option.equals("")) {
							offoptDto.setOffopt_name(option);
							adminOfficeService.insertOffopt(offoptDto);
						}
					}
				}

				// office 이미지 파일 처리
				offimgDto.setOff_no(latest_offno);
				offimgDto.setMem_email(offDto.getMem_email());

				for (MultipartFile image : images) {
					if (!image.isEmpty()) {
						String uploadPath = (String) multi.getSession().getServletContext().getRealPath(UPLOAD_PATH);
						String originalName = image.getOriginalFilename();
						String[] exam = originalName.split("\\.");
						String swiching = "";
						// 확장자 검사
						if (!isValidExtension(originalName)) {
							return RESULT_UNACCEPTED_EXTENSION;
						}

						for (int j = 0; j < exam.length - 1; j++) {
							swiching = swiching + exam[j];
						}
						originalName = StringReplace(swiching) + "." + exam[exam.length - 1];

						// 용량 검사
						sizeSum += image.getSize();
						if (sizeSum >= LIMIT_SIZE) {

							// 용량 초과시 이전에 insertOffice()한 latest_offno 사무실번호
							// 내역은 삭제해야한다.
							offDto.setOff_no(latest_offno);
							int result1 = adminOfficeService.deleteOffice(offDto);
							if (result1 != 1) {
							}
							// 옵션 테이블의 데이터도 삭제
							offoptDto.setOff_no(latest_offno);
							int result2 = adminOfficeService.deleteOffopts(offoptDto);
							if (result2 != 1) {
							}

							return RESULT_EXCEED_SIZE;
						}

						// db 저장
						offimgDto.setOffimg_name(originalName);
						offimgDto.setMem_email(mem_email);

						if (!isTransimg) {
							image.transferTo(new File(uploadPath + originalName));
						}
						adminOfficeService.insertOffimgs(offimgDto);
					}
				}
			}
			return RESULT_SUCCESS;
		} else {
			// 이메일 존재하지 않으면 해당이메일 반환
			return offDto.getMem_email();
		}
	}

	public String StringReplace(String str) {
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		str = str.replaceAll(match, "");
		return str;
	}

	// switch(String) 비교시 jdk1.7로 변경
	private boolean isValidExtension(String originalName) {
		String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1);
		switch (originalNameExtension) {
		case "jpg":
		case "jpeg":
		case "png":
		case "gif":
		case "bmp":
			return true;
		}
		return false;
	}

	// 사무실 수정 & 파일도 같이
	@ResponseBody
	@RequestMapping(value = "/updateOffice.reo", method = RequestMethod.POST)
	public String updateOffice(HttpSession session, OfficeDTO offDto, OffImgsDTO offimgDto, OffOptDTO offoptDto,
			MultipartHttpServletRequest request, @RequestParam("offopt_name") List<String> options,
			@RequestParam("files") List<MultipartFile> images, @RequestParam("delFiles") List<String> delImages)
			throws IOException {
		// 파일 외의 정보들 수정
		String mem_email = session.getAttribute("mem_email").toString();
		offDto.setMem_email(mem_email);

		adminOfficeService.updateOffice(offDto);
		adminOfficeService.deleteOffopts(offoptDto); // 기존에 있던 옵션들 삭제하고 새로 추가

		if (!options.isEmpty()) {
			for (String option : options) {
				if (!option.equals("")) {
					offoptDto.setOffopt_name(option);
					adminOfficeService.insertOffopt(offoptDto);
				}
			}
		}

		// office 이미지 파일들 처리
		long sizeSum = 0;
		// 기존에 있던 파일들 중 삭제할 게 있다면 삭제
		if (delImages.size() != 0) {
			for (String delImage : delImages) {
				offimgDto.setOffimg_name(delImage);
				int result = adminOfficeService.deleteOffimgs(offimgDto);
				if (result == 0) {
					System.out.println("client 사무실 파일 수정 컨트롤러 에러");
				}
			}
		}

		// 새로 첨부한 이미지들은 등록
		for (MultipartFile image : images) {
			if (!image.isEmpty()) {
				String uploadPath = (String) request.getSession().getServletContext().getRealPath(UPLOAD_PATH);
				String originalName = image.getOriginalFilename();
				String[] exam = originalName.split("\\.");
				String swiching = "";
				// 확장자 검사
				if (!isValidExtension(originalName)) {
					System.out.println("수정 확장자 검사");
					return RESULT_UNACCEPTED_EXTENSION;
				}

				for (int j = 0; j < exam.length - 1; j++) {
					swiching = swiching + exam[j];
				}
				originalName = StringReplace(swiching) + "." + exam[exam.length - 1];

				// 용량 검사
				sizeSum += image.getSize();
				if (sizeSum >= LIMIT_SIZE) {
					System.out.println("수정 용량 제한");

					// 용량 초과시 사무실 정보들은 update되고 파일들은 insert안된다.
					return RESULT_EXCEED_SIZE;
				}

				// db 저장
				offimgDto.setOffimg_name(originalName);
				offimgDto.setMem_email(mem_email);
				image.transferTo(new File(uploadPath + originalName));
				adminOfficeService.insertOffimgs(offimgDto);
			}
		}
		return RESULT_SUCCESS;
	}

	// 사무실 삭제
	@RequestMapping(value = "/deleteOffice.reo")
	public String deleteOffice(HttpServletRequest request, OfficeDTO dto,
			@RequestParam("delOff_no") List<String> delOff_no) {
		int result = 0;
		// String[] offNoArr = request.getParameterValues("delOff_no");

		if (delOff_no != null) {
			for (int i = 0; i < delOff_no.size(); i++) {
				int offNo = Integer.parseInt(delOff_no.get(i));
				dto.setOff_no(offNo);
				result = adminOfficeService.deleteOffice(dto);
				if (result < 1) {
					System.out.println("client 매물 삭제 에러!");
				}
			}
		}
		return "redirect:/myOfficeList.reo?pageNo=" + request.getParameter("pageNo");
	}

	// 사무실 위시리스트 조회
	@RequestMapping("/searchWish.reo")
	public @ResponseBody String searchWish(@RequestParam(value = "off_no") int off_no, HttpServletRequest request,
			Model model) {
		HashMap<String, Object> wishmap = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		int result = 0;

		// System.out.println(mem_email);
		wishmap.put("off_no", off_no);
		wishmap.put("mem_email", session.getAttribute("mem_email"));

		int isWished = clientOfficeService.getSearchWish(wishmap); // 위시리스트 조회, 이미 찜을 했는지 검사
		if (isWished > 0) { // 이미 찜을 했다면
			result = clientOfficeService.deleteWish(wishmap); // 삭제
			System.out.println("위시 삭제:" + result);

			if (result != 1) {
				System.out.println("위시 삭제 에러!!");
				return "del0";
			} else {
				// model.addAttribute("isDel", result);
				return "del1";
			}
		} else {
			result = clientOfficeService.insertWish(wishmap); // 위시리스트에 추가
			System.out.println("위시 추가:" + result);

			if (result != 1) {
				System.out.println("위시 추가 에러!!");
				return "add0";
			} else {
				// model.addAttribute("isAdd", result);
				return "add1";
			}
		}
	}

	// 사무실 좋아요 리스트 조회
	@RequestMapping("/searchLike.reo")
	public @ResponseBody HashMap<String, Object> searchLike(@RequestParam(value = "off_no") int off_no,
			HttpServletRequest request, Model model, OfficeDTO offDto) {
		HashMap<String, Object> likemap = new HashMap<String, Object>();
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		int likelistRst = 0;
		int officeRst = 0;

		likemap.put("off_no", off_no);
		likemap.put("mem_email", session.getAttribute("mem_email"));
		offDto.setOff_no(off_no);

		int isLiked = clientOfficeService.getSearchLike(likemap); // 좋아요 리스트 조회, 이미 좋아요를 했는지 검사
		if (isLiked > 0) { // 이미 좋아요를 했다면
			likelistRst = clientOfficeService.deleteLike(likemap); // likelist 테이블에서 삭제
			officeRst = clientOfficeService.updateMinusLike(offDto); // office 테이블에서 update -1

			if (likelistRst != 1 || officeRst != 1) {
				System.out.println("좋아요 삭제 에러!!");
				resultmap.put("queryRst", "del0");
			} else {
				resultmap.put("queryRst", "del1");
			}
		} else {
			likelistRst = clientOfficeService.insertLike(likemap); // likelist 테이블에서 추가
			officeRst = clientOfficeService.updatePlusLike(offDto); // office 테이블에서 update +1

			if (likelistRst != 1 || officeRst != 1) {
				System.out.println("좋아요 추가 에러!!");
				resultmap.put("queryRst", "add0");
			} else {
				resultmap.put("queryRst", "add1");
			}
		}

		resultmap.put("countLike", clientOfficeService.getCountLike(offDto));
		return resultmap;
	}

	// 예약 - 수정하기
	@RequestMapping("/getOfficeUpdate.reo")
	public String getOfficeUpdate(OfficeDTO offDto, Model model, HttpServletRequest request,
			@RequestParam("res_no") int res_no, @RequestParam("pageNo") int pageNo, RedirectAttributes redirect)
			throws JsonProcessingException {
		ReservationDTO resDto = new ReservationDTO();
		HashMap<String, Object> wishmap = new HashMap<String, Object>();
		int index = 0;
		HttpSession session = request.getSession();

		wishmap.put("off_no", offDto.getOff_no());
		wishmap.put("mem_email", session.getAttribute("mem_email"));
		int off_no = offDto.getOff_no();

		OfficeDTO tmpOffDto = clientOfficeService.getOffice(offDto);
		offDto.setMem_email(tmpOffDto.getMem_email());
		offDto.setOff_no(tmpOffDto.getOff_no());

		String[] typeArr = tmpOffDto.getOff_type().split(",");

		model.addAttribute("office", tmpOffDto);
		model.addAttribute("off_types", typeArr);
		model.addAttribute("off_images", clientOfficeService.getOffimgs(offDto));
		model.addAttribute("off_options", clientOfficeService.getOffopts(offDto));
		model.addAttribute("isWish", clientOfficeService.getSearchWish(wishmap));
		model.addAttribute("isLike", clientOfficeService.getSearchLike(wishmap));
		model.addAttribute("countLike", clientOfficeService.getCountLike(offDto));

		List<OfficeDTO> relativeOffList = clientOfficeService.getOfficeByemail(offDto);

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
		if (pageNo == 0) {
			pageNo = 1;
		}

		OfficeDTO listone = mapService.getMapOne(offDto.getOff_no());
		ObjectMapper mapper = new ObjectMapper();
		String mapText = mapper.writeValueAsString(listone);
		model.addAttribute("maplist", mapText);
		model.addAttribute("relativeOffice", relativeOffList);
		model.addAttribute(pageNo);
		model.addAttribute(res_no);
		resDto.setMem_email((String) session.getAttribute("mem_email"));
		resDto.setOff_no(off_no);
		resDto.setRes_no(res_no);
		resDto.setRes_startdatetime(reservationService.getResUpdateSel(resDto).getRes_startdatetime());
		Long now = new Date().getTime();
		long start = resDto.getRes_startdatetime().getTime();
		int diff = (int) Math.ceil((double) (start - now) / (double) (1000 * 60 * 60));

		if (diff >= 48) {
			return "client/office/getOfficeUpdate";
		}
		redirect.addFlashAttribute("modal", "true");
		return "redirect:getOfficeUpdate.reo";
	}
}
