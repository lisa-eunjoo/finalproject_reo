package kr.co.reo.admin.pay.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.web3j.protocol.core.methods.response.EthGetBalance;

import kr.co.reo.admin.pay.dao.AdminPayDAO;
import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.PayDTO;
import kr.co.reo.common.util.PageUtil;

@Service("adminPayService")
public class AdminPayServiceImpl implements AdminPayService {

	@Autowired
	private AdminPayDAO adminPayDAO;
	@Autowired(required = false)
	private Web3jMethods web3j;
	@Autowired
	private PageUtil pageUtil;

	private final String cid = "TC0ONETIME"; // 가맹점 코드
	private final String kPayAdminKey = "de99e94501ece787f36994a71d1830e6"; // Admin Key

	public int getPayListCount(PayDTO payDTO) {
		return adminPayDAO.getPayListCount(payDTO);
	}

	public List<PayDTO> getPayList(PayDTO payDTO) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today = sdf.format(date);
		try {
			sdf.parse(payDTO.getFromDate());
		} catch (Exception e) {
			payDTO.setFromDate("2010-01-01");
		}
		try {
			sdf.parse(payDTO.getToDate());
		} catch (Exception e) {
			payDTO.setToDate(today);
		}

		if (payDTO.getSearchType() == null) {
			payDTO.setSearchType("off_name");
		} else if (!payDTO.getSearchType().equals("off_name") && !payDTO.getSearchType().equals("mem_email")) {
			payDTO.setSearchType("off_name");
		}

		if (payDTO.getSearch() == null) {
			payDTO.setSearch("");
		}

		int totalRows = getPayListCount(payDTO);
		payDTO.setPageNo(pageUtil.ablePageNo(payDTO.getPageNo(), totalRows));

		payDTO.setLIMIT(pageUtil.getLimit());
		payDTO.setOFFSET(pageUtil.getOffset(payDTO.getPageNo()));

		return adminPayDAO.getPayList(payDTO);
	}

	public PayDTO getPayInfo(PayDTO payDTO) {
		return adminPayDAO.getPayInfo(payDTO);
	}

	public String kakaoPayCancel(String pay_no, int res_no, String full) {
		PayDTO payDTO = new PayDTO();
		if (pay_no == null || pay_no.equals("")) {
			payDTO.setRes_no(res_no);
		} else {
			payDTO.setPay_no(pay_no);
		}
		payDTO = adminPayDAO.getPayInfo(payDTO);
		if (payDTO == null || payDTO.getPay_state().equals("결제취소")) {
			return "Fail";
		}

		if (payDTO.getPay_remark() != null) {
			int remark = 100;
			try {
				remark = Integer.parseInt(payDTO.getPay_remark().substring(0, 2));
			} catch (Exception e) {
				System.out.println("kakaoPayCancel parseInt에러 : " + e);
				return "Fail";
			}
			double per = 1.0 - ((double) remark / 100.0);
			payDTO.setPay_price((int) (payDTO.getPay_price() * per));
			payDTO.setPay_remark(null);
			payDTO.setPay_state("결제취소");
		} else {
			if (full.equals("true")) {
				payDTO.setPay_state("결제취소");
			} else {
				Long now = new Date().getTime();
				Long start = payDTO.getRes_startdatetime().getTime();
				int diff = (int) Math.ceil((double) (start - now) / (double) (1000 * 60 * 60));
				if (diff <= 1) {
					payDTO.setPay_price((int) (payDTO.getPay_price() * 0.1));
					payDTO.setPay_remark("10% 취소");
				} else if (diff <= 3) {
					payDTO.setPay_price((int) (payDTO.getPay_price() * 0.5));
					payDTO.setPay_remark("50% 취소");
				} else if (diff <= 6) {
					payDTO.setPay_price((int) (payDTO.getPay_price() * 0.7));
					payDTO.setPay_remark("70% 취소");
				} else if (diff <= 12) {
					payDTO.setPay_price((int) (payDTO.getPay_price() * 0.9));
					payDTO.setPay_remark("90% 취소");
				} else {
					payDTO.setPay_state("결제취소");
				}
			}
		}

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + kPayAdminKey);
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // application/x-www-form-urlencoded;charset=UTF-8

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("cid", cid); // 가맹점 코드, 10자
		params.add("tid", payDTO.getPay_tid()); // 결제 고유번호
		params.add("cancel_amount", String.valueOf(payDTO.getPay_price())); // 취소 금액
		params.add("cancel_tax_free_amount", "0"); // 취소 비과세 금액

		// header + body
		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		@SuppressWarnings("unchecked")
		Map<String, Object> kPayMap = new RestTemplate().postForObject("https://kapi.kakao.com/v1/payment/cancel",
				httpEntity, Map.class);
		try {
			payDTO.setPay_no((String) kPayMap.get("partner_order_id"));

			int updateCount = adminPayDAO.updatekPayType(payDTO);
			if (updateCount == 1) {
				if (payDTO.getPay_remark() == null) {
					return "Success";
				} else {
					return payDTO.getPay_remark();
				}
			}
		} catch (Exception e) {
			System.out.println("/kakaoPayCancel 오류 : " + e);
			e.printStackTrace();
		}

		return "Fail";
	}

	public String getBalance() {
		EthGetBalance balance = web3j.getEthBalance("");

		return balance.getBalance().toString();
	}

	public String getDefaultAddress() {
		return web3j.getDefaultAddress();
	}

	public List<ContractDTO> contractList(int pageNo) {
		int count = (int) web3j.getCount();
		pageNo = pageUtil.ablePageNo(pageNo, count);
		int limit = pageUtil.getLimit();
		int offset = pageUtil.getOffset(pageNo);
		List<ContractDTO> contractDTOlist = web3j.reoContractList(limit, offset, count);
		for(ContractDTO contractDTO : contractDTOlist) {
			contractDTO.setPay_no("RPN" + Long.toString(contractDTO.getTokenId(), 36).toUpperCase());
		}

		return contractDTOlist;
	}

	public ContractDTO contractInfo(String pay_no) {
		pay_no = pay_no.substring(3);
		long tokenIdL = Long.valueOf(pay_no, 36);

		return web3j.reoContract(tokenIdL);
	}

	public Map<String, String> getContractMemberInfo(String mem_email) {
		return adminPayDAO.getContractMemberInfo(mem_email);
	}

	public Map<String, String> getContractOfficeInfo(String pay_no) {
		Map<String, String> map = adminPayDAO.getContractOfficeInfo(pay_no);
		String first = map.get("mem_buisnessNo").substring(0, 2);
		String second = map.get("mem_buisnessNo").substring(3, 4);
		String third = map.get("mem_buisnessNo").substring(5);
		String number = first + "-" + second + "-" + third;
		map.put("mem_buisnessNo", number);

		return map;
	}

}