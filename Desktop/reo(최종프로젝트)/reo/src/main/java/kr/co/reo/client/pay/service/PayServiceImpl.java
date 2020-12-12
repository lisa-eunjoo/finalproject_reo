package kr.co.reo.client.pay.service;

import java.sql.Timestamp;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.reo.admin.pay.service.Web3jMethods;
import kr.co.reo.client.pay.dao.PayDAO;
import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.KakaoPayDTO;
import kr.co.reo.common.dto.PayDTO;
import kr.co.reo.common.util.PageUtil;

@Service("payService")
public class PayServiceImpl implements PayService {

	@Autowired
	private PayDAO payDAO;
	@Autowired(required = false)
	private Web3jMethods web3j;
	@Autowired
	private PageUtil pageUtil;

	private final String cid = "TC0ONETIME"; // 가맹점 코드
	private final String kPayAdminKey = "de99e94501ece787f36994a71d1830e6"; // Admin Key

	public int getPayListCount(PayDTO payDTO) {
		return payDAO.getPayListCount(payDTO);
	}

	public List<PayDTO> getMyPayList(PayDTO payDTO) {
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

		if (payDTO.getSearch() == null) {
			payDTO.setSearch("");
		}

		int totalRows = getPayListCount(payDTO);
		payDTO.setPageNo(pageUtil.ablePageNo(payDTO.getPageNo(), totalRows));

		payDTO.setLIMIT(pageUtil.getLimit());
		payDTO.setOFFSET(pageUtil.getOffset(payDTO.getPageNo()));

		return payDAO.getMyPayList(payDTO);
	}

	public PayDTO getPayInfo(PayDTO payDTO) {
		return payDAO.getPayInfo(payDTO);
	}

	// 결제 준비
	public String kakaoPayReady(String mem_email, int off_no, int res_no, String pay_price, String device,
			String host) {
		String off_name = getOffName(off_no);
		String pay_no = "RPN" + Long.toString(System.currentTimeMillis(), 36).toUpperCase();
		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + kPayAdminKey);
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // application/x-www-form-urlencoded;charset=UTF-8

		// 서버로 요청할 Body, 헤더에 담아 파라미터 값들과 함께 post로 요청 
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("cid", cid); // 가맹점 코드, 10자
		params.add("partner_order_id", pay_no); // 가맹점 주문번호, 최대 100자
		params.add("partner_user_id", mem_email); // 가맹점 회원 id, 최대 100자
		params.add("item_name", off_name); // 상품명, 최대 100자
		params.add("item_code", String.valueOf(off_no)); // 상품코드, 최대 100자
		params.add("quantity", "1"); // 상품 수량
		params.add("total_amount", pay_price); // 상품 총액
		params.add("tax_free_amount", "0"); // 상품 비과세 금액
		if (device.equals("Desktop")) {
			params.add("approval_url", host + "/reo/kPayApprove.reo"); // 결제 성공 시 redirect url, 최대 255자
			params.add("cancel_url", host + "/reo/kPay/CancelBefore.reo"); // 결제 취소 시 redirect url, 최대 255자
			params.add("fail_url", host + "/reo/kPay/Fail.reo"); // 결제 실패 시 redirect url, 최대 255자
		} else {
			params.add("approval_url", host + "/reo/android/kPayApprove.reo"); // 결제 성공 시 redirect url, 최대 255자
			params.add("cancel_url", host + "/reo/android/kPay/CancelBefore.reo"); // 안드로이드 결제 취소 시 redirect url, 최대 255자
			params.add("fail_url", host + "/reo/android/kPay/Fail.reo"); // 안드로이드 결제 실패 시 redirect url, 최대 255자
		}

		// header + body
		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		String result = new RestTemplate().postForObject("https://kapi.kakao.com/v1/payment/ready", httpEntity,
				String.class);
		try {
			KakaoPayDTO kPayDTO = new ObjectMapper().readValue(result, KakaoPayDTO.class);

			if (kPayDTO.getNext_redirect_pc_url() != null) {
				PayDTO payDTO = new PayDTO();
				payDTO.setPay_no(pay_no);
				payDTO.setRes_no(res_no);
				payDTO.setMem_email(mem_email);
				payDTO.setOff_no(off_no);
				payDTO.setPay_price(Integer.parseInt(pay_price));
//				payDTO.setPay_beforedate(new Timestamp(kPayDTO.getCreated_at().getTime()));
				payDTO.setPay_beforedate(new Timestamp(System.currentTimeMillis()));
				payDTO.setPay_date(payDTO.getPay_beforedate());
				payDTO.setPay_tid(kPayDTO.getTid());

				int insertCount = payDAO.insertReadykPay(payDTO);
				if (insertCount == 1) {
					if (device.equals("Desktop")) {
						return "redirect:" + kPayDTO.getNext_redirect_pc_url();
					} else {
						return "redirect:" + kPayDTO.getNext_redirect_mobile_url();
					}
				}
			}
		} catch (Exception e) {
			System.out.println("/kakaoPayReady 오류 : " + e);
		}

		if (!device.equals("Desktop")) {
			return "redirect:/android/kPay/Fail.reo";
		}
		return "redirect:/kPay/Fail.reo";
	}

	// 결제 승인
	@SuppressWarnings("unchecked")
	public String kakaoPayApprove(String mem_email, String pg_token, String device) {
		PayDTO dto = new PayDTO();
		dto.setMem_email(mem_email);
		dto.setPay_state("결제대기");
		dto = payDAO.getReadykPayInfo(dto);

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + kPayAdminKey);
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // application/x-www-form-urlencoded;charset=UTF-8

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("cid", cid); // 가맹점 코드, 10자
		params.add("tid", dto.getPay_tid()); // 결제 고유번호, 결제 준비 API 응답에 포함
		params.add("partner_order_id", dto.getPay_no()); // 가맹점 주문번호, 결제 준비 API 요청과 일치해야 함
		params.add("partner_user_id", mem_email); // 가맹점 회원 id, 결제 준비 API 요청과 일치해야 함
		params.add("pg_token", pg_token); // 결제승인 요청을 인증하는 토큰 사용자 결제 수단 선택 완료 시,
		// approval_url로 redirection해줄 때 pg_token을 query string으로 전달

		// header + body
		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		Map<String, Object> kPayMap = new RestTemplate().postForObject("https://kapi.kakao.com/v1/payment/approve",
				httpEntity, Map.class);
		try {
			PayDTO payDTO = new PayDTO();
			payDTO.setPay_no((String) kPayMap.get("partner_order_id"));
			payDTO.setMem_email((String) kPayMap.get("partner_user_id"));
			String[] date = ((String) kPayMap.get("approved_at")).split("T");
			Timestamp datetime = Timestamp.valueOf(date[0] + " " + date[1]);
			payDTO.setPay_date(datetime);
			payDTO.setPay_type((String) kPayMap.get("payment_method_type"));
			if (payDTO.getPay_type() != null && payDTO.getPay_type().equals("CARD")) {
				Map<String, String> card_infoMap = (Map<String, String>) kPayMap.get("card_info");
				String bin = card_infoMap.get("bin");
				bin = bin.substring(0, 4) + "-" + bin.substring(4, bin.length()) + "**-****-****";
				payDTO.setPay_bin(bin);
				payDTO.setPay_card(card_infoMap.get("issuer_corp"));
			}
			payDTO.setPay_state("결제완료");

			int updateCount = payDAO.updateApprovekPay(payDTO);
			if (updateCount == 1) {
				if (!dto.getOff_unit().equals("시간")) {
					contractMint(payDTO.getPay_no());
				}
				payDAO.updateResSuccess(payDTO.getPay_no());

				if (!device.equals("Desktop")) {
					return "redirect:/android/kPay/Success.reo";
				} else {
					return "redirect:/kPay/Success.reo";
				}
			} else {
				// 결제 취소 추가?
			}
		} catch (Exception e) {
			System.out.println("/kakaoPayApprove 오류 : " + e);
			e.printStackTrace();
		}

		if (!device.equals("Desktop")) {
			return "redirect:/android/kPay/Fail.reo";
		}
		return "redirect:/kPay/Fail.reo";
	}

	// 결제 취소
	public String kakaoPayCancel(String mem_email, String pay_no, int res_no) {
		PayDTO payDTO = new PayDTO();
		payDTO.setMem_email(mem_email);
		if (pay_no == null || pay_no.equals("")) {
			payDTO.setRes_no(res_no);
		} else {
			payDTO.setPay_no(pay_no);
		}
		payDTO = payDAO.getPayInfo(payDTO);
		if (payDTO == null || (!payDTO.getPay_state().equals("결제완료") && payDTO.getPay_remark() != null)) {
			return "Fail";
		}
		Long now = new Date().getTime();
		Long start = payDTO.getRes_startdatetime().getTime();
		int diff = (int) Math.ceil((double) (start - now) / (double) (1000 * 60 * 60));
		if (diff <= 1) {
			payDTO.setPay_price((int) (payDTO.getPay_price() * 0.1));
			payDTO.setPay_remark("10퍼 취소");
		} else if (diff <= 3) {
			payDTO.setPay_price((int) (payDTO.getPay_price() * 0.5));
			payDTO.setPay_remark("50퍼 취소");
		} else if (diff <= 6) {
			payDTO.setPay_price((int) (payDTO.getPay_price() * 0.7));
			payDTO.setPay_remark("70퍼 취소");
		} else if (diff <= 12) {
			payDTO.setPay_price((int) (payDTO.getPay_price() * 0.9));
			payDTO.setPay_remark("90퍼 취소");
		} else {
			payDTO.setPay_state("결제취소");
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
			payDTO.setMem_email((String) kPayMap.get("partner_user_id"));

			int updateCount = payDAO.updatekPayType(payDTO);
			if (updateCount == 1) {
				payDAO.updateResCancel(payDTO);
				return "Success";
			}
		} catch (Exception e) {
			System.out.println("/kakaoPayCancel 오류 : " + e);
			e.printStackTrace();
		}

		return "Fail";
	}

	// 결제 변경
	public String updatekPayType(String mem_email, String type) {
		PayDTO payDTO = new PayDTO();
		payDTO.setMem_email(mem_email);
		if (type.equals("Fail")) {
			payDTO.setPay_state("결제실패"); // 바꿀 값
			payDTO.setPay_type("결제대기"); // WHERE절 pay_state로 쓰임 / 조건 값
		} else if (type.equals("CancelBefore")) {
			payDTO.setPay_state("결제전취소");
			payDTO.setPay_type("결제대기"); // WHERE절 pay_state로 쓰임
		}

		int updateCount = payDAO.updatekPayType(payDTO);
		if (updateCount != 1) {
			return "redirect:/500error.reo";
		}

		return "redirect:/mybooking.reo";
	}

	public String getOffName(int off_no) {
		return payDAO.getOffName(off_no);
	}

	public void contractMint(String pay_no) {
		Map<String, String> contractInfoMap = payDAO.getContractMintInfo(pay_no);
		ContractDTO contractDTO = new ContractDTO();
		long tokenId = Long.valueOf(contractInfoMap.get("pay_no").substring(3), 36);
		contractDTO.setTokenId(tokenId);
		contractDTO.setName(contractInfoMap.get("mem_name"));
		contractDTO.setId(contractInfoMap.get("mem_email"));
		String location = contractInfoMap.get("off_stdAddr") + " " + contractInfoMap.get("off_extraAddr").trim() + " "
				+ contractInfoMap.get("off_detailAddr").trim();
		contractDTO.setLocation(location);
		String priceArray[] = contractInfoMap.get("room_price").split(",");
		String priceS = "";
		for (String num : priceArray) {
			priceS += num;
		}
		long price = Long.valueOf(priceS);
		contractDTO.setPrice(price);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			String pay_date = sdf.format(contractInfoMap.get("pay_date"));
			contractDTO.setPayday(sdf.parse(pay_date).getTime());
			String res_startdatetime = sdf.format(contractInfoMap.get("res_startdatetime"));
			contractDTO.setStartdate(sdf.parse(res_startdatetime).getTime());
			String res_enddatetime = sdf.format(contractInfoMap.get("res_enddatetime"));
			contractDTO.setEnddate(sdf.parse(res_enddatetime).getTime());
		} catch (Exception e) {
			System.out.println("contractMint 에러 : " + e);
		}
		if (!web3j.mint(contractDTO)) {
			System.out.println("계약서 생성 실패");
		}
	}

	public ContractDTO contractInfo(String pay_no) {
		pay_no = pay_no.substring(3);

		return web3j.reoContract(Long.valueOf(pay_no, 36));
	}

	public Map<String, String> getContractMemberInfo(String mem_email) {
		return payDAO.getContractMemberInfo(mem_email);
	}

	public Map<String, String> getContractOfficeInfo(String pay_no) {
		Map<String, String> map = payDAO.getContractOfficeInfo(pay_no);
		String first = map.get("mem_buisnessNo").substring(0, 2);
		String second = map.get("mem_buisnessNo").substring(3, 4);
		String third = map.get("mem_buisnessNo").substring(5);
		String number = first + "-" + second + "-" + third;
		map.put("mem_buisnessNo", number);

		return map;
	}
}