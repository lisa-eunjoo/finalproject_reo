package kr.co.reo.admin.member.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.ChartDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;

@Repository("adminMemberDAO")
public class AdminMemberDAOImpl implements AdminMemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public AuthorityDTO login(AuthorityDTO authorityDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.login(authorityDTO);
	}

	public List<ChartDTO> getAgeData() {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getAgeData();
	}

	public List<ChartDTO> getTopPayData() {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getTopPayData();
	}

	public List<LoginLogDTO> getLoginLog(LoginLogDTO loginLogDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getLoginLog(loginLogDTO);
	}

	public int getLoginLogListCount(LoginLogDTO loginLogDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getLoginLogListCount(loginLogDTO);
	}

	public List<ChartDTO> getLoginDateCount(int difDate) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getLoginDateCount(difDate);
	}

	public int insertMember(MemberDTO memberDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.insertMember(memberDTO);
	}

	public int updateMember(MemberDTO memberDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.updateMember(memberDTO);
	}

	public int deleteMember(int mem_no) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.deleteMember(mem_no);
	}

	public int initPassword(MemberDTO memberDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.initPassword(memberDTO);
	}

	public List<MemberDTO> getMemberList(Map<String, String> params) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getMemberList(params);
	}

	public int getMemberListCount(Map<String, String> params) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getMemberListCount(params);
	}

	public MemberDTO getMemberInfo(int mem_no) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getMemberInfo(mem_no);
	}

	public int getMemberIdCheck(String mem_email) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getMemberIdCheck(mem_email);
	}

	public int deleteMemberMulti(List<Integer> mem_noList) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.deleteMemberMulti(mem_noList);
	}

	public Map<String, Object> getMemberNamenNo(String mem_email) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getMemberNamenNo(mem_email);
	}

	public int insertLoginLog(LoginLogDTO loginLogDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.insertLoginLog(loginLogDTO);
	}

	public AuthorityDTO getAuthInfo(String mem_email) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.getAuthInfo(mem_email);
	}

	public int insertAuth(AuthorityDTO authorityDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.insertAuth(authorityDTO);
	}

	public int updateAuth(AuthorityDTO authorityDTO) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.updateAuth(authorityDTO);
	}

	public int deleteAuth(int mem_no) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.deleteAuth(mem_no);
	}

	public int deleteAuthMulti(List<Integer> mem_noList) {
		AdminMemberDAO mapper = sqlSessionTemplate.getMapper(AdminMemberDAO.class);
		return mapper.deleteAuthMulti(mem_noList);
	}
}