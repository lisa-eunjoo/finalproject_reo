package kr.co.reo.admin.pay.dao;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.PayDTO;

public interface AdminPayDAO {
	public int getPayListCount(PayDTO payDTO);

	public List<PayDTO> getPayList(PayDTO payDTO);

	public PayDTO getPayInfo(PayDTO payDTO);

	public int updatekPayType(PayDTO payDTO);

	public Map<String, String> getContractMemberInfo(String mem_email);

	public Map<String, String> getContractOfficeInfo(String pay_no);
}