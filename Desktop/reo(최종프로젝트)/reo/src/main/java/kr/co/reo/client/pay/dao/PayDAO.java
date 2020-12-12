package kr.co.reo.client.pay.dao;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.PayDTO;

public interface PayDAO {

	public int getPayListCount(PayDTO payDTO);

	public List<PayDTO> getMyPayList(PayDTO payDTO);

	public PayDTO getPayInfo(PayDTO payDTO);

	public int insertReadykPay(PayDTO payDTO);

	public PayDTO getReadykPayInfo(PayDTO payDTO);

	public int updateApprovekPay(PayDTO payDTO);

	public int updatekPayType(PayDTO payDTO);

	public String getOffName(int off_no);

	public Map<String, String> getContractMintInfo(String pay_no);

	public Map<String, String> getContractMemberInfo(String mem_email);

	public Map<String, String> getContractOfficeInfo(String pay_no);

	public int updateResSuccess(String pay_no);

	public int updateResCancel(PayDTO payDTO);
}