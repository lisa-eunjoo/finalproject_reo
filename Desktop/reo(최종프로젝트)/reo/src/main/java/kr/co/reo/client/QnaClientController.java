package kr.co.reo.client;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.reo.client.member.service.MemberService;
import kr.co.reo.client.qna.service.QnaClientService;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.PageMaker;
import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Controller
@SessionAttributes("qna")
public class QnaClientController {

	@Inject
	private QnaClientService qnaService;
	@Inject
	private MemberService memberService;

	@RequestMapping("clientQnaList.reo")
	public String getQnaList(QnaDTO dto, Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception {

		List<QnaDTO> list = qnaService.getQnaList(scri);
		model.addAttribute("qnaList", list); // model 정보저장

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaService.getQnaListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);
		return "client/qna/clientQnaList"; // view 이름 리턴
	}

	@RequestMapping("clientQnaWrite.reo")
	public String clientQnaWrite(HttpSession session, Model model) throws Exception {
		String email = (String) session.getAttribute("mem_email");
		MemberDTO dto = memberService.checkLoginEmail(email);
		model.addAttribute("member", dto);
		return "client/qna/clientQnaWrite";
	}

	@RequestMapping(value = "insertQna.reo", method = RequestMethod.POST)
	public String insertQna(QnaDTO dto) throws Exception {
		String content = dto.getQna_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
				.replaceAll("\r\n", "<br>");
		String title = dto.getQna_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
				.replaceAll("\r\n", "<br>");
		dto.setQna_content(content);
		dto.setQna_title(title);
		qnaService.insertQna(dto);
		return "redirect:clientQnaList.reo";
	}

	@ResponseBody
	@RequestMapping(value = "qnaUpdate.reo", method = RequestMethod.POST)
	public String qnaUpdate(@RequestBody Map<String, String> qna) throws Exception {
		String title = qna.get("qna_title");
		String content = qna.get("qna_content");
		QnaDTO dto = new QnaDTO();
		dto.setqna_no(Integer.parseInt(qna.get("qna_no")));
		dto.setQna_title(title);
		dto.setQna_content(content);
		qnaService.updateQna(dto);
		return "true";
	}

	@RequestMapping(value = "qnaDelete.reo")
	public String qnaDelete(@RequestParam String qna_no) throws Exception {
		int no = Integer.parseInt(qna_no);
		qnaService.deleteQna(no);
		return "redirect:clientQnaList.reo";
	}

	@RequestMapping("qnaReport.reo")
	public String qnaReport(QnaDTO dto, HttpServletResponse response) throws Exception {

		if (qnaService.checkQnaReport(dto) != null) {
			System.out.println("게시물 중복신고");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter writer = response.getWriter();

			writer.println("<script>alert('이미 신고하신 글입니다.');history.go(-1);</script>");

			writer.flush();

			writer.close();

			return "redirect:qnaDetail.reo?qna_no=" + dto.getqna_no() + "";
		} else {
			System.out.println("게시물 신고 진행");
			qnaService.insertQnaReport(dto);
			return "redirect:qnaDetail.reo?qna_no=" + dto.getqna_no() + "";
		}
	}

	@ResponseBody
	@RequestMapping(value = "reportAnswer.reo", method = RequestMethod.POST)
	public String reportAnswer(HttpSession session, @RequestParam("qna_no") String qna_no) throws Exception {
		System.out.println(qna_no);
		QnaDTO dto = new QnaDTO();
		dto.setReport_email((String) session.getAttribute("mem_email"));
		dto.setqna_no(Integer.parseInt(qna_no));
		if (qnaService.checkQnaReport(dto) == null) {
			System.out.println("답변 신고 진행");
			qnaService.insertQnaReport(dto);
			qnaService.updateQnaReport(dto);
			return "true";
		} else {
			return "flase";
		}
	}

	@RequestMapping("clientNoAnswerList.reo")
	public String getNoAnswerList(Model model) throws Exception {

		model.addAttribute("qnaList", qnaService.getNoAnswerList()); // model 정보저장
		return "client/qna/clientQnaList"; // view 이름 리턴
	}

	@ResponseBody
	@RequestMapping(value = "/qnapassword.reo", method = RequestMethod.POST)
	public String qnapassword(HttpSession session, @RequestParam("qna_password") String qna_password,
			@RequestParam("qna_no") String qna_no) throws Exception {
		System.out.println(qna_password);
		System.out.println(session.getAttribute("mem_email"));
		return "";
	}
}
