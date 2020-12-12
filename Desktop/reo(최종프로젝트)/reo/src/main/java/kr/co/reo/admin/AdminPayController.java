package kr.co.reo.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.reo.admin.pay.service.AdminPayService;
import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.PayDTO;
import kr.co.reo.common.util.PageUtil;

@Controller
@RequestMapping("/admin")
public class AdminPayController {

	@Autowired
	private AdminPayService adminPayService;
	@Autowired
	private PageUtil pageUtil;

	@RequestMapping("/payList")
	public String payList(PayDTO payDTO, Model model) {
		List<PayDTO> list = adminPayService.getPayList(payDTO);
		model.addAttribute("payList", list);
		String paging = pageUtil.paging(payDTO.getPageNo(), adminPayService.getPayListCount(payDTO), "payList.reo",
				"fromDate=" + payDTO.getFromDate() + "&toDate=" + payDTO.getToDate() + "&searchType="
						+ payDTO.getSearchType() + "&search=" + payDTO.getSearch());
		model.addAttribute("paging", paging);

		return "admin/pay/payList";
	}

	@RequestMapping("/payInfo")
	public String payInfo(HttpServletRequest request, String pageNo, String payNo, Model model) {
		PayDTO payDTO = new PayDTO();
		payDTO.setPay_no(payNo);
		payDTO = adminPayService.getPayInfo(payDTO);

		String referer = request.getHeader("Referer");
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		String path = url.substring(0, url.indexOf(uri));
		if (referer.contains("resView.reo")) {
			String prev = referer.substring(path.length());
			model.addAttribute("prev", prev);
		}

		model.addAttribute("payDTO", payDTO);

		return "admin/pay/payInfo";
	}

	@ResponseBody
	@RequestMapping(value = "/kPayCancel", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String kakaoPayCancel(@RequestBody Map<String, String> params) {
		String str = adminPayService.kakaoPayCancel(params.get("payNo"), 0, params.get("full"));

		return str;
	}

	@RequestMapping(value = "/contractInfo", method = RequestMethod.POST)
	public String contractInfo(String pay_no, Model model) {
		model.addAttribute("pay_no", pay_no);

		return "admin/pay/contractInfo";
	}

	@RequestMapping(value = "/contractIframe", method = RequestMethod.POST)
	public String contractIframe(String pay_no, Model model) {
		ContractDTO contractDTO = adminPayService.contractInfo(pay_no);

		Map<String, String> member = adminPayService.getContractMemberInfo(contractDTO.getId());
		Map<String, String> office = adminPayService.getContractOfficeInfo(pay_no);

		long day = 24 * 60 * 60 * 1000;
		long diffDay = (contractDTO.getEnddate() - contractDTO.getStartdate()) / day;
		model.addAttribute("contractDTO", contractDTO);
		model.addAttribute("diffDay", diffDay);
		model.addAttribute("diffMonth", Math.round(diffDay / 30));
		model.addAttribute("member", member);
		model.addAttribute("office", office);

		return "admin/pay/contractIframe";
	}

	@RequestMapping("/contractList")
	public String contractList(@RequestParam int pageNo, Model model) {
		List<ContractDTO> list = adminPayService.contractList(pageNo);
		model.addAttribute("contractList", list);

		return "admin/pay/contractList";
	}

	@ResponseBody
	@RequestMapping(value = "/contract", method = RequestMethod.POST)
	public String contract() {
		String address = adminPayService.getDefaultAddress();
		String balance = adminPayService.getBalance();
		String returnData = "주소 : " + address + " / 잔액 : " + balance;

		return returnData;
	}

}