package kr.co.reo.client;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.reo.client.pay.service.PayService;
import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.PayDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
public class PayController {

	@Autowired
	private PayService payService;
	@Autowired
	private PageUtil pageUtil;

	@RequestMapping("/myPayList")
	public String myPayList(HttpSession session, PayDTO payDTO, Model model) {
		payDTO.setMem_email((String) session.getAttribute("mem_email"));
		List<PayDTO> list = payService.getMyPayList(payDTO);

		String paging = pageUtil.paging(payDTO.getPageNo(), payService.getPayListCount(payDTO), "myPayList.reo",
				"fromDate=" + payDTO.getFromDate() + "&toDate=" + payDTO.getToDate() + "&search=" + payDTO.getSearch());
		model.addAttribute("payList", list);
		model.addAttribute("paging", paging);

		return "client/pay/myPayList";
	}
	//결제 정보
	@RequestMapping("/myPayInfo")
	public String payInfo(HttpServletRequest request, String pageNo, String payNo, Model model) {
		String mem_email = (String) request.getSession().getAttribute("mem_email");
		PayDTO payDTO = new PayDTO();
		payDTO.setMem_email(mem_email);
		payDTO.setPay_no(payNo);
		payDTO = payService.getPayInfo(payDTO);

		String referer = request.getHeader("Referer");
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		String path = url.substring(0, url.indexOf(uri));
		if (referer.contains("myreservDetail.reo")) {
			String prev = referer.substring(path.length());
			model.addAttribute("prev", prev);
		}

		model.addAttribute("payDTO", payDTO);

		return "client/pay/myPayInfo";
	}
	//결제 준비 
	@RequestMapping(value = "/kPayReady/{offNo}/{resNo}/{price}")
	public String kakaoPayReady(HttpServletRequest request, @PathVariable("offNo") int offNo,
			@PathVariable("resNo") int resNo, @PathVariable("price") String price) {
		String host = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		Device currentDevice = DeviceUtils.getCurrentDevice(request);
		String device = "";
		if (currentDevice.isMobile()) {
			device = "Mobile";
		} else if (currentDevice.isTablet()) {
			device = "Tablet";
		} else {
			device = "Desktop";
		}

		String uri = payService.kakaoPayReady((String) request.getSession().getAttribute("mem_email"), offNo, resNo,
				price, device, host);

		return uri;
	}
	//결제 승인 
	@RequestMapping("/kPayApprove")
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
	//결제 취소 
	@ResponseBody
	@RequestMapping(value = "/kPayCancel", method = RequestMethod.POST)
	public String kakaoPayCancel(HttpSession session, @RequestBody Map<String, String> params) {
		String str = payService.kakaoPayCancel((String) session.getAttribute("mem_email"), params.get("payNo"), 0);

		return str;
	}
	//결제 한 후 바로 redirect로 mybooking 페이지로 
	@RequestMapping("/kPay/{type}")
	public String kakaoPayAfter(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,
			@PathVariable("type") String type) {
		String mem_email = (String) request.getSession().getAttribute("mem_email");

		String uri = "redirect:/mybooking.reo";
		if (type.equals("Success")) {
			redirect.addFlashAttribute("message", "Success");
		} else if (type.equals("Fail")) {
			uri = payService.updatekPayType(mem_email, type);
			redirect.addFlashAttribute("message", "Fail");
		} else if (type.equals("CancelBefore")) {
			uri = payService.updatekPayType(mem_email, type);
		}

		return uri;
	}

	@RequestMapping(value = "/contractInfo", method = RequestMethod.POST)
	public String contractInfo(String pay_no, Model model) {
		model.addAttribute("pay_no", pay_no);

		return "client/pay/contractInfo";
	}

	@RequestMapping(value = "/contractIframe", method = RequestMethod.POST)
	public String contractIframe(String pay_no, Model model) {
		ContractDTO contractDTO = payService.contractInfo(pay_no);

		Map<String, String> member = payService.getContractMemberInfo(contractDTO.getId());
		Map<String, String> office = payService.getContractOfficeInfo(pay_no);

		long day = 24 * 60 * 60 * 1000;
		long diffDay = (contractDTO.getEnddate() - contractDTO.getStartdate()) / day;
		model.addAttribute("contractDTO", contractDTO);
		model.addAttribute("diffDay", diffDay);
		model.addAttribute("diffMonth", Math.round(diffDay / 30));
		model.addAttribute("member", member);
		model.addAttribute("office", office);

		return "client/pay/contractIframe";
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "client/test";
	}
}