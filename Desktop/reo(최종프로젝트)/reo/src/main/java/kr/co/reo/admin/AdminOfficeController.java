package kr.co.reo.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.reo.admin.map.service.MapService;
import kr.co.reo.admin.office.service.AdminOfficeService;
import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
public class AdminOfficeController {
	private static final String RESULT_EXCEED_SIZE = "-2";
	private static final String RESULT_UNACCEPTED_EXTENSION = "-1";
	private static final String RESULT_SUCCESS = "1";
	private static final long LIMIT_SIZE = 10 * 1024 * 1024;
	private static final String UPLOAD_PATH = "./resources/upload/";

	@Autowired
	private AdminOfficeService adminOfficeService;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private MapService mapService;

	@RequestMapping("/admin/getOfficeList.reo")
	public String getOfficeListByUnit(HttpSession session, HttpServletRequest request, Model model, OfficeDTO offDTO,
			@RequestParam(value = "off_type", defaultValue = "전체", required = false) String off_type,
			@RequestParam(value = "off_unit", defaultValue = "전체", required = false) String off_unit,
			@RequestParam(value = "min_price", defaultValue = "0", required = false) String min_price,
			@RequestParam(value = "max_price", defaultValue = "0", required = false) String max_price,
			@RequestParam(value = "off_maxNum", defaultValue = "0", required = false) String off_maxNum,
			@RequestParam(value = "SORD", defaultValue = "desc", required = false) String sord,
			@RequestParam(value = "SIDX", defaultValue = "off_no", required = false) String sidx,
			@RequestParam(value = "offopt_name", required = false) List<String> options,
			@RequestParam(value = "keyword", defaultValue = "", required = false) String keyword) {

		HashMap<String, Object> filterMap = new HashMap<String, Object>();
		int index = 0;
		filterMap.put("pageNo", request.getParameter("pageNo"));
		if (filterMap.get("pageNo") == null || Integer.parseInt(filterMap.get("pageNo").toString()) < 1) {
			filterMap.put("pageNo", 1);
		}

		filterMap.put("off_type", off_type);
		filterMap.put("off_unit", off_unit);
		filterMap.put("min_price", min_price);
		filterMap.put("max_price", max_price);
		filterMap.put("off_maxNum", off_maxNum);
		if (options != null) {
			filterMap.put("offopt_name", options);
		}

		try {
			if (options.get(0).equals("null")) {
				filterMap.put("offopt_name", null);
			}
			;
		} catch (NullPointerException e) {
			filterMap.put("offopt_name", null);
		}
		filterMap.put("keyword", keyword);
		filterMap.put("SORD", sord);
		filterMap.put("SIDX", sidx);

		List<OfficeDTO> sortList = new ArrayList<OfficeDTO>();
		sortList = adminOfficeService.getOfficeListByUnit(filterMap);
		for (OfficeDTO list : sortList) {
			try {
				if (adminOfficeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(adminOfficeService.getOffimgOne(list).getOffimg_name());
					sortList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		model.addAttribute("officeList", sortList);
		model.addAttribute("keyword", keyword);
		int totalRows = adminOfficeService.getOffFilterListCount(filterMap); // Integer.parseInt(filterMap.get("pageNo").toString())
		try {
			String temp = filterMap.get("offopt_name").toString();
			temp = temp.replaceAll("\\[", "");
			temp = temp.replaceAll("\\]", "");
			filterMap.put("offopt_name", temp);
		} catch (Exception e) {
		}
		String paging = pageUtil.paging(Integer.parseInt(filterMap.get("pageNo").toString()), totalRows,
				"getOfficeList.reo",
				"off_type=" + filterMap.get("off_type") + "&off_unit=" + filterMap.get("off_unit") + "&min_price="
						+ filterMap.get("min_price") + "&max_price=" + filterMap.get("max_price") + "&off_maxNum="
						+ filterMap.get("off_maxNum") + "&offopt_name=" + filterMap.get("offopt_name") + "&SIDX="
						+ filterMap.get("SIDX") + "&SORD=" + filterMap.get("SORD") + "&keyword="
						+ filterMap.get("keyword"));
		model.addAttribute("paging", paging);

		return "/admin/office/getOfficeList";
	}

	// 사무실 상세
	@RequestMapping("/admin/detailOffice.reo")
	public String detailOffice(OfficeDTO offDto, Model model) {
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

	// 사무실 수정
	@RequestMapping("/admin/getOffice.reo")
	public String getOffice(OfficeDTO offDto, Model model) {
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

	// 해당 사무실 이미지파일들 반환
	@RequestMapping("/admin/getOffImage.reo")
	public @ResponseBody List<OffImgsDTO> getOffImage(OfficeDTO offDto, Model model) {

		return adminOfficeService.getOffimgs(offDto);
	}

	// 사무실 등록 페이지 이동
	@RequestMapping("/admin/insertOfficeView.reo")
	public String insertOfficeView() {
		return "/admin/office/insertOffice";
	}

	// 사무실 등록
	@ResponseBody
	@RequestMapping(value = "/admin/insertOffice.reo", method = RequestMethod.POST)
	public String insertOffice(HttpServletRequest request, OfficeDTO offDto, MemberDTO memDto, OffImgsDTO offimgDto, OffOptDTO offoptDto,
			MapDTO mapDto, MultipartHttpServletRequest multi,
			@RequestParam(value = "addCount", defaultValue = "1") int addCount,
			@RequestParam("offopt_name") List<String> options, @RequestParam("files") List<MultipartFile> images)
			throws IOException {

		// 멤버테이블에 중개인 이메일 검색
		memDto = adminOfficeService.getAgentNameTel(offDto);

		mapDto.setMap_address(offDto.getOff_stdAddr());
		mapDto.setMem_email(offDto.getMem_email());
		// 이메일 존재하면
		boolean isTransimg = false;
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
	@RequestMapping(value = "/admin/updateOffice.reo", method = RequestMethod.POST)
	public String updateOffice(OfficeDTO offDto, OffImgsDTO offimgDto, OffOptDTO offoptDto,
			MultipartHttpServletRequest request, @RequestParam("offopt_name") List<String> options,
			@RequestParam("files") List<MultipartFile> images, @RequestParam("delFiles") List<String> delImages)
			throws IOException {
		// 파일 외의 정보들 수정
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
					return RESULT_UNACCEPTED_EXTENSION;
				}

				for (int j = 0; j < exam.length - 1; j++) {
					swiching = swiching + exam[j];
				}
				originalName = StringReplace(swiching) + "." + exam[exam.length - 1];

				// 용량 검사
				sizeSum += image.getSize();
				if (sizeSum >= LIMIT_SIZE) {

					// 용량 초과시 사무실 정보들은 update되고 파일들은 insert안된다.
					return RESULT_EXCEED_SIZE;
				}

				// db 저장
				offimgDto.setOffimg_name(originalName);
				image.transferTo(new File(uploadPath + originalName));
				adminOfficeService.insertOffimgs(offimgDto);
			}
		}
		return RESULT_SUCCESS;
	}

	// 사무실 삭제
	@RequestMapping(value = "/admin/deleteOffice.reo")
	public String deleteOffice(HttpServletRequest request, OfficeDTO dto,
			@RequestParam("delOff_no") List<String> delOff_no) {
		int result = 0;

		if (delOff_no != null) {
			for (int i = 0; i < delOff_no.size(); i++) {
				int offNo = Integer.parseInt(delOff_no.get(i));
				dto.setOff_no(offNo);
				result = adminOfficeService.deleteOffice(dto);
				if (result < 1) {
				}
			}
		}
		return "redirect:/admin/getOfficeList.reo?pageNo=" + request.getParameter("pageNo");
	}

	// 사무실 위시리스트 조회
	@RequestMapping("/admin/searchWish.reo")
	public @ResponseBody String searchWish(@RequestParam(value = "off_no") int off_no, HttpServletRequest request,
			Model model) {
		HashMap<String, Object> wishmap = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		int result = 0;

		wishmap.put("off_no", off_no);
		wishmap.put("mem_email", session.getAttribute("mem_email"));

		int isWished = adminOfficeService.getSearchWish(wishmap); // 위시리스트 조회, 이미 찜을 했는지 검사
		if (isWished > 0) { // 이미 찜을 했다면
			result = adminOfficeService.deleteWish(wishmap); // 삭제

			if (result != 1) {
				return "del0";
			} else {
				return "del1";
			}
		} else {
			result = adminOfficeService.insertWish(wishmap); // 위시리스트에 추가

			if (result != 1) {
				return "add0";
			} else {
				return "add1";
			}
		}
	}
}