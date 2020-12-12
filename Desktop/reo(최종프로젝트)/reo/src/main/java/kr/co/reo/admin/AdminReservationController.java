package kr.co.reo.admin;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.reo.client.reservation.service.ReservationService;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
@SessionAttributes("AllresList")
public class AdminReservationController {
	
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private PageUtil pageUtil;
	
	//관리자 예약 리스트 
	@RequestMapping(value="/admin/resList.reo")
	public String AllResList(@ModelAttribute ReservationDTO dto, @RequestParam(value="pageNo", defaultValue="1") int pageNo, Model model, HttpServletRequest request) throws IOException {
		if(dto.getPageNo() < 1) {
			dto.setPageNo(1);
		}
		HttpSession session = request.getSession();
		session.setAttribute("mem_email", "admin");
		dto.setMem_email(session.getAttribute("mem_email").toString());
		
		int resCount = reservationService.getResCount(dto);
		String paging = pageUtil.paging(dto.getPageNo(), resCount, "resList.reo", "");
		
		model.addAttribute("AllResList", reservationService.getAllResList(dto));
		model.addAttribute("resCount", reservationService.getResCount(dto));
		model.addAttribute("paging", paging);
		
		return "admin/reservation/resList";
	}

	
	//관리자 예약 내역 상세 확인 
	@RequestMapping(value="/admin/resView.reo")
	public String getMyResInfo(@ModelAttribute ReservationDTO dto, Model model, HttpServletRequest request) throws IOException {
			HttpSession session = request.getSession();
			session.setAttribute("mem_email", "admin");
			dto.setMem_email(session.getAttribute("mem_email").toString());
			model.addAttribute("rescheck", reservationService.getMyResInfo(dto));
			return "admin/reservation/resView";
	}

	//관리자 예약 취소 
	@RequestMapping(value="/admin/resDelete.reo", method=RequestMethod.GET)
	public String adResDel(HttpServletRequest request, ReservationDTO dto, @RequestParam("pageNo") int pageNo, Model model) throws IOException{
			reservationService.updateAdResDel(dto);
			model.addAttribute(pageNo);
			return "redirect:/admin/resList.reo?pageNo="+pageNo;
	}
}