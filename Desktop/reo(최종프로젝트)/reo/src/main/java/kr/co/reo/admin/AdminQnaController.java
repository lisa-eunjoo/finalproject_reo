package kr.co.reo.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.reo.admin.qna.service.QnaAdminService;
import kr.co.reo.common.dto.PageMaker;
import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Controller
@SessionAttributes("qna")
public class AdminQnaController {

	@Inject
	private QnaAdminService qnaService;

	@RequestMapping("/admin/adminQnaList.reo")
	public String getQnaList(QnaDTO dto, Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception {
		model.addAttribute("qnaList", qnaService.getQnaList(scri)); // model 정보저장

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaService.getQnaListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);

		return "admin/qna/adminQnaList"; // view 이름 리턴
	}

	@RequestMapping("/admin/adminQnaWrite.reo")
	public String adminQnaWrite() {
		return "admin/qna/adminQnaWrite";
	}

	@RequestMapping(value = "/admin/adminInsertQna.reo", method = RequestMethod.POST)
	public String adminInsertQna(QnaDTO dto) throws Exception {
		qnaService.insertQna(dto);

		return "redirect:adminQnaList.reo";
	}

	@ResponseBody
	@RequestMapping(value = "/admin/adminQnaUpdate.reo", method = RequestMethod.POST)
	public String qnaUpdate(@RequestBody Map<String, String> qna) throws Exception {
		System.out.println(qna.get("qna_no"));
		QnaDTO dto = new QnaDTO();
		dto.setqna_no(Integer.parseInt(qna.get("qna_no")));
		dto.setQna_title(qna.get("qna_title"));
		dto.setQna_content(qna.get("qna_content"));
		qnaService.updateQna(dto);

		return "true";
	}

	@RequestMapping(value = "/admin/adminQnaDelete.reo")
	public String qnaDelete(@RequestParam String qna_no) throws Exception {
		int no = Integer.parseInt(qna_no);
		qnaService.deleteQnaSingle(no);

		return "redirect:/admin/adminQnaList.reo";
	}

	@ResponseBody
	@RequestMapping("/admin/adminSetAnswer.reo")
	public String setAnswer(@RequestBody Map<String, String> qna) throws Exception {
		System.out.println(qna.get("qna_no"));
		QnaDTO dto = new QnaDTO();
		dto.setqna_no(Integer.parseInt(qna.get("qna_no")));
		dto.setAnswer_title(qna.get("answer_title"));
		dto.setAnswer_content(qna.get("answer_content"));
		qnaService.setAnswer(dto);

		return "true";
	}

	@ResponseBody
	@RequestMapping("/admin/adminUpdateAnswer.reo")
	public String updateAnswer(@RequestBody Map<String, String> qna) throws Exception {
		System.out.println(qna.get("qna_no"));
		QnaDTO dto = new QnaDTO();
		dto.setqna_no(Integer.parseInt(qna.get("qna_no")));
		dto.setAnswer_title(qna.get("answer_title"));
		dto.setAnswer_content(qna.get("answer_content"));
		qnaService.updateAnswer(dto);

		return "true";
	}

	@RequestMapping("/admin/adminDeleteAnswer.reo")
	public String deleteAnswer(QnaDTO qna) throws Exception {
		qnaService.deleteAnswer(qna);

		return "redirect:/admin/adminQnaList.reo";
	}

	@RequestMapping("/admin/adminNoAnswerList.reo")
	public String getNoAnswerList(QnaDTO dto, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {
		model.addAttribute("qnaList", qnaService.getNoAnswerList(scri)); // model 정보저장

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaService.getNoAnswerListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);

		return "admin/qna/adminNoAnswerList"; // view 이름 리턴
	}

	@RequestMapping("/admin/adminReportedList.reo")
	public String getReportedList(QnaDTO dto, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {
		model.addAttribute("qnaList", qnaService.getReportedList(scri)); // model 정보저장

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaService.getReportedListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);

		return "admin/qna/adminReportedList"; // view 이름 리턴
	}

	@RequestMapping("/admin/adminMultiDelete.reo")
	public String adminMultiDelete(@RequestParam(value = "chbox[]") List<String> chArr, QnaDTO dto) throws Exception {
		int qnaNum = 0;
		for (String i : chArr) {
			qnaNum = Integer.parseInt(i);
			dto.setqna_no(qnaNum);
			qnaService.deleteQna(dto);
		}

		return "redirect:/admin/adminQnaList.reo";
	}
}
