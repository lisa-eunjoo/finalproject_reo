package kr.co.reo.admin.pay.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.client.pay.dao.PayDAO;
import kr.co.reo.common.dto.PayDTO;

@Repository("adminPayDAO")
public class AdminPayDAOImpl implements AdminPayDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int getPayListCount(PayDTO payDTO) {
		AdminPayDAO mapper = sqlSessionTemplate.getMapper(AdminPayDAO.class);
		return mapper.getPayListCount(payDTO);
	}

	public List<PayDTO> getPayList(PayDTO payDTO) {
		AdminPayDAO mapper = sqlSessionTemplate.getMapper(AdminPayDAO.class);
		return mapper.getPayList(payDTO);
	}

	public PayDTO getPayInfo(PayDTO payDTO) {
		AdminPayDAO mapper = sqlSessionTemplate.getMapper(AdminPayDAO.class);
		return mapper.getPayInfo(payDTO);
	}

	public int updatekPayType(PayDTO payDTO) {
		AdminPayDAO mapper = sqlSessionTemplate.getMapper(AdminPayDAO.class);
		return mapper.updatekPayType(payDTO);
	}

	public Map<String, String> getContractMemberInfo(String mem_email) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getContractMemberInfo(mem_email);
	}

	public Map<String, String> getContractOfficeInfo(String pay_no) {
		PayDAO mapper = sqlSessionTemplate.getMapper(PayDAO.class);
		return mapper.getContractOfficeInfo(pay_no);
	}

}