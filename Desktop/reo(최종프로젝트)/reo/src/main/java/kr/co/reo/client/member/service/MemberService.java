package kr.co.reo.client.member.service;

import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.SnsDTO;

public interface MemberService {

	public void insertMember(MemberDTO dto) throws Exception;

	public int updateMember(MemberDTO dto) throws Exception;

	public int updatePass(MemberDTO dto) throws Exception;

	public void deleteMember(String mem_email) throws Exception;

	public String checkEmail(String mem_email) throws Exception;

	public MemberDTO checkLoginEmail(String mem_email) throws Exception;

	public SnsDTO getLoginSns(SnsDTO dto) throws Exception;

	public int insertLoginLog(LoginLogDTO loginLogDTO) throws Exception;

	public MemberDTO qrScan(String mem_email) throws Exception;

}
