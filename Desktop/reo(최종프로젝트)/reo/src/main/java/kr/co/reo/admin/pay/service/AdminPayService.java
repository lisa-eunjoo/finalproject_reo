package kr.co.reo.admin.pay.service;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.ContractDTO;
import kr.co.reo.common.dto.PayDTO;

public interface AdminPayService {
	public int getPayListCount(PayDTO payDTO);

	public List<PayDTO> getPayList(PayDTO payDTO);

	public PayDTO getPayInfo(PayDTO payDTO);

	public String kakaoPayCancel(String pay_no, int res_no, String full);

	public String getBalance();

	public String getDefaultAddress();

	public List<ContractDTO> contractList(int pageNo);

	public ContractDTO contractInfo(String pay_no);

	public Map<String, String> getContractMemberInfo(String id);

	public Map<String, String> getContractOfficeInfo(String pay_no);
}