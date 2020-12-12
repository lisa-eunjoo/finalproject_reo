package kr.co.reo.client.pay.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.PayDTO;

@Repository("payDAO")
public class PayDAOImpl implements PayDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int getPayListCount(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getPayListCount(payDTO);
	}

	public List<PayDTO> getMyPayList(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getMyPayList(payDTO);
	}

	public PayDTO getPayInfo(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getPayInfo(payDTO);
	}

	public int insertReadykPay(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.insertReadykPay(payDTO);
	}

	public PayDTO getReadykPayInfo(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getReadykPayInfo(payDTO);
	}

	public int updateApprovekPay(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.updateApprovekPay(payDTO);
	}

	public int updatekPayType(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.updatekPayType(payDTO);
	}

	public String getOffName(int off_no) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getOffName(off_no);
	}

	public Map<String, String> getContractMintInfo(String pay_no) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getContractMintInfo(pay_no);
	}

	public Map<String, String> getContractMemberInfo(String mem_email) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getContractMemberInfo(mem_email);
	}

	public Map<String, String> getContractOfficeInfo(String pay_no) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getContractOfficeInfo(pay_no);
	}

	public int updateResSuccess(String pay_no) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.updateResSuccess(pay_no);
	}

	public int updateResCancel(PayDTO payDTO) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.updateResCancel(payDTO);
	}

}