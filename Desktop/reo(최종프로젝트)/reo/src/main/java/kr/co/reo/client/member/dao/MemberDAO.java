package kr.co.reo.client.member.dao;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.SnsDTO;

public interface MemberDAO {
	public void insertMember(MemberDTO dto) throws Exception;

	public int updateMember(MemberDTO dto) throws Exception;

	public int updatePass(MemberDTO dto) throws Exception;

	public void deleteMember(String mem_email) throws Exception;

	public SnsDTO getLoginSns(SnsDTO dto) throws Exception;

	public String checkEmail(String mem_email) throws Exception;

	public MemberDTO checkLoginEmail(String mem_email) throws Exception;

	public int insertLoginLog(LoginLogDTO loginLogDTO) throws Exception;

	public MemberDTO qrScan(String mem_email) throws Exception;

	public int insertAuth(AuthorityDTO authorityDTO) throws Exception;

	public int deleteAuth(String mem_email) throws Exception;

	public void mongoEmailCheckInsert(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> mongoEmailCheck(Map<String, Object> map) throws Exception;

	public int mongoEmailCheckDelete(Map<String, Object> map) throws Exception;

}