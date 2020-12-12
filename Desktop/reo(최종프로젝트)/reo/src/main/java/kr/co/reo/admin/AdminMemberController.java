package kr.co.reo.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.reo.admin.member.service.AdminMemberService;
import kr.co.reo.common.dto.ChartDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
@SessionAttributes("admin")
@RequestMapping("/admin")
public class AdminMemberController {

	@Autowired
	private AdminMemberService adminMemberService;
	@Autowired
	private PageUtil pageUtil;

	@RequestMapping(value = "/login.reo", method = RequestMethod.GET)
	public String login(@RequestParam(value = "error", required = false) String error, HttpServletRequest request,
			Model model) {
		if (error != null) {
			model.addAttribute("error", error);
		}

		return "admin/member/adminLogin";
	}

//	@RequestMapping("/logout.reo")
//	public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException {
//		String url = "redirect:/index.reo";
//		if (request.isUserInRole("ROLE_ADMIN")) {
//			url = "redirect:/admin/login.reo";
//		}
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		if (auth != null) {
//			new SecurityContextLogoutHandler().logout(request, response, auth);
//		}
//
//		return url;
//	}

	@RequestMapping(".reo")
	public String goIndex(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.addHeader("Cache-Control", "No-store");
		response.setDateHeader("Expires", 1L);

		try {
			PrintWriter writer = response.getWriter();
			writer.print("<script type='text/javascript'>");
			if (request.isUserInRole("ROLE_ADMIN")) {
				writer.print("location.href = '/reo/admin/index.reo';");
			} else {
				writer.print("location.href = '/reo/index.reo';");
			}
			writer.print("</script>");
			writer.flush();
			writer.close();
		} catch (IOException e) {
			System.out.println("goIndex 오류 : " + e);
		}

		return null;
	}

	@RequestMapping("/index.reo")
	public String index(Model model) {
		LoginLogDTO loginLogDTO = new LoginLogDTO();
		loginLogDTO.setLIMIT(7);
		List<ChartDTO> ageData = adminMemberService.getAgeData();
		List<ChartDTO> topPayData = adminMemberService.getTopPayData();
		List<ChartDTO> dateCount = adminMemberService.getLoginDateCount(14);
		List<LoginLogDTO> loginLog = adminMemberService.getLoginLog(loginLogDTO);
		String wordcloudURL = adminMemberService.wordCloud();
		int userCount = adminMemberService.getUserCount();

		model.addAttribute("ageData", ageData);
		model.addAttribute("topPayData", topPayData);
		model.addAttribute("dateCount", dateCount);
		model.addAttribute("loginLog", loginLog);
		model.addAttribute("wordcloudURL", wordcloudURL);
		model.addAttribute("userCount", userCount);

		return "admin/index";
	}

	@RequestMapping(value = "/insertMember.reo", method = RequestMethod.GET)
	public String insertMember() {
		return "admin/member/memberInfo";
	}

	@RequestMapping(value = "/insertMember.reo", method = RequestMethod.POST)
	public String insertMember(MemberDTO memberDTO) throws IOException {
		int insertCount = adminMemberService.insertMember(memberDTO);
		if (insertCount != 1) {
			return "redirect:500error.reo";
		}

		return "redirect:memberList.reo";
	}

	@RequestMapping(value = "/updateMember.reo", method = RequestMethod.POST)
	public String updateMember(MemberDTO memberDTO, @RequestParam Map<String, String> params, Model model) {
		int updateCount = adminMemberService.updateMember(memberDTO);
		if (updateCount != 1) {
			return "redirect:500error.reo";
		}
		model.addAttribute("memNo", params.get("memNo"));
		model.addAttribute("pageNo", params.get("pageNo"));
		model.addAttribute("searchType", params.get("searchType"));
		model.addAttribute("searchKeyword", params.get("searchKeyword"));

		return "redirect:memberInfo.reo";
	}

	@RequestMapping(value = "/deleteMember.reo", method = RequestMethod.GET)
	public String deleteMember(@RequestParam("memNo") int mem_no) {
		int deleteCount = adminMemberService.deleteMember(mem_no);
		if (deleteCount != 1) {
			return "redirect:500error.reo";
		}

		return "redirect:memberList.reo";
	}

	@ResponseBody
	@RequestMapping(value = "/initPassword.reo", method = RequestMethod.POST)
	public String initPassword(@RequestBody Map<String, String> params) {
		int updateCount = adminMemberService.initPassword(Integer.parseInt(params.get("mem_no")));

		return String.valueOf(updateCount);
	}

	@RequestMapping("/memberList.reo")
	public String memberList(@RequestParam Map<String, String> params, Model model) {
		List<MemberDTO> memberDTOList = adminMemberService.getMemberList(params);
		model.addAttribute("memberList", memberDTOList);
		Map<Integer, Boolean> memberMap = new HashMap<>();
		for (MemberDTO memberDTO : memberDTOList) {
			memberMap.put(memberDTO.getMem_no(), adminMemberService.isUsing(memberDTO.getMem_email()));
		}
		model.addAttribute("memberMap", memberMap);

		String query = "searchType=" + params.get("searchType") + "&searchKeyword=" + params.get("searchKeyword");
		String paging = pageUtil.paging(Integer.parseInt(params.get("pageNo")),
				adminMemberService.getMemberListCount(params), "memberList.reo", query);
		model.addAttribute("paging", paging);

		model.addAttribute("query", "pageNo=" + params.get("pageNo") + "&" + query);
		model.addAttribute("searchType", params.get("searchType"));
		model.addAttribute("searchKeyword", params.get("searchKeyword"));

		return "admin/member/memberList";
	}

	@RequestMapping(value = "/memberInfo.reo")
	public String memberInfo(@RequestParam Map<String, String> params, Model model) {
		int mem_no = 0;
		try {
			mem_no = Integer.valueOf(params.get("memNo"));
		} catch (Exception e) {
			return "redirect:memberList.reo";
		}
		MemberDTO memberDTO = adminMemberService.getMemberInfo(mem_no);
		if (memberDTO == null) {
			return "redirect:memberList.reo";
		}
		model.addAttribute("member", memberDTO);
		model.addAttribute("query", "pageNo=" + params.get("pageNo") + "&searchType=" + params.get("searchType")
				+ "&searchKeyword=" + params.get("searchKeyword"));

		return "admin/member/memberInfo";
	}

	@ResponseBody
	@RequestMapping(value = "/idCheck.reo", method = RequestMethod.GET)
	public int memberIdCheck(@RequestParam String mem_email) {
		return adminMemberService.getMemberIdCheck(mem_email);
	}

	@RequestMapping("/memberMultiDelete.reo")
	public String deleteMemberMulti(String[] rowCheck, @RequestParam Map<String, String> params, Model model) {
		int deleteCount = adminMemberService.deleteMemberMulti(rowCheck);
		if (rowCheck.length != deleteCount) {
			return "redirect:500error.reo";
		}

		model.addAttribute("pageNo", params.get("pageNo"));
		model.addAttribute("searchType", params.get("searchType"));
		model.addAttribute("searchKeyword", params.get("searchKeyword"));

		return "redirect:memberList.reo";
	}

	@RequestMapping(value = "/loginLogList.reo", method = RequestMethod.GET)
	public String loginLogList(LoginLogDTO loginLogDTO, Model model) {
		List<LoginLogDTO> loginLogList = adminMemberService.getLoginLog(loginLogDTO);
		String paging = pageUtil.paging(loginLogDTO.getPageNo(), adminMemberService.getLoginLogListCount(loginLogDTO),
				"", "");
		paging = paging.replace("?pageNo=", "");
		model.addAttribute("loginLogList", loginLogList);
		model.addAttribute("paging", paging);

		return "admin/member/loginLogList";
	}

	@ResponseBody
	@RequestMapping(value = "/loginLogList.reo", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String loginLogList(LoginLogDTO loginLogDTO) {
		List<LoginLogDTO> loginLogList = adminMemberService.getLoginLog(loginLogDTO);
		String paging = pageUtil.paging(loginLogDTO.getPageNo(), adminMemberService.getLoginLogListCount(loginLogDTO),
				"", "");
		if (paging == null) {
			paging = "";
		} else {
			paging = paging.replace("?pageNo=", ""); // .replaceAll("'[0-9]'", "''")
		}

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String table = "<tbody>";
		for (LoginLogDTO log : loginLogList) {
			table += "<tr class='row'><td class='col-md-2 d-none d-md-table-cell'>" + log.getLog_no() + "</td>";
			table += "<td class='col-md-4 col-sm-4 col-4'>" + log.getMem_email() + "</td>";
			table += "<td class='col-md-3 col-sm-4 col-4'>" + date.format(log.getLog_date()) + "</td>";
			table += "<td class='col-md-3 col-sm-4 col-4'>" + log.getLog_ip() + "</td></tr>";
		}
		table += "</tbody><tfoot>";
		if (loginLogList.isEmpty()) {
			table += "<tr class='row'><td class='col-sm-12'>검색 결과가 없습니다.</td></tr>";
		} else {
			table += "<tr class='row'><td class='col-lg-12 col-sm-12 col-12'>" + paging + "</td></tr>";
		}
		table += "</tfoot>";

		return table;
	}
}