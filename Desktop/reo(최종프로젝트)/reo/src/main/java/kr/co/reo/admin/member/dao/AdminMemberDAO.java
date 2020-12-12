package kr.co.reo.admin.member.dao;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.ChartDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;

public interface AdminMemberDAO {

	AuthorityDTO login(AuthorityDTO authorityDTO);

	List<ChartDTO> getAgeData();

	List<ChartDTO> getTopPayData();

	List<LoginLogDTO> getLoginLog(LoginLogDTO loginLogDTO);

	int getLoginLogListCount(LoginLogDTO loginLogDTO);

	List<ChartDTO> getLoginDateCount(int difDate);

	int insertMember(MemberDTO memberDTO);

	int updateMember(MemberDTO memberDTO);

	int deleteMember(int mem_no);

	int initPassword(MemberDTO memberDTO);

	List<MemberDTO> getMemberList(Map<String, String> params);

	int getMemberListCount(Map<String, String> params);

	MemberDTO getMemberInfo(int mem_no);

	int getMemberIdCheck(String mem_email);

	int deleteMemberMulti(List<Integer> mem_noList);

	Map<String, Object> getMemberNamenNo(String mem_email);

	int insertLoginLog(LoginLogDTO loginLogDTO);

	AuthorityDTO getAuthInfo(String mem_email);

	int insertAuth(AuthorityDTO authorityDTO);

	int updateAuth(AuthorityDTO authorityDTO);

	int deleteAuth(int mem_no);

	int deleteAuthMulti(List<Integer> mem_noList);
}