package kr.co.reo.client.pay.service;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.PayDTO;

public interface PayService {

	public int getPayListCount(PayDTO payDTO);

	public List<PayDTO> getMyPayList(PayDTO payDTO);

	public PayDTO getPayInfo(PayDTO payDTO);

	public String kakaoPayReady(String mem_email, int off_no, int res_no, String pay_price, String device, String host);

	public String kakaoPayApprove(String mem_email, String pg_token, String device);

	public String kakaoPayCancel(String mem_email, String pay_no, int res_no);

	public String updatekPayType(String mem_email, String type);

	public String getOffName(int off_no);

	public void contractMint(String pay_no);

	public ContractDTO contractInfo(String pay_no);

	public Map<String, String> getContractMemberInfo(String id);

	public Map<String, String> getContractOfficeInfo(String pay_no);
}