package kr.co.reo.admin.member.service;

import java.util.List;
import java.util.Map;

import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.ChartDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;

public interface AdminMemberService {

	AuthorityDTO login(AuthorityDTO authorityDTO);

	List<ChartDTO> getAgeData();

	List<ChartDTO> getTopPayData();

	List<LoginLogDTO> getLoginLog(LoginLogDTO loginLogDTO);

	int getLoginLogListCount(LoginLogDTO loginLogDTO);

	List<ChartDTO> getLoginDateCount(int difDate);

	String wordCloud();

	int insertMember(MemberDTO memberDTO);

	int updateMember(MemberDTO memberDTO);

	int deleteMember(int mem_no);

	int initPassword(int mem_no);

	List<MemberDTO> getMemberList(Map<String, String> params);

	int getMemberListCount(Map<String, String> params);

	MemberDTO getMemberInfo(int mem_no);

	int getMemberIdCheck(String mem_email);

	int deleteMemberMulti(String[] mem_noArray);

	Map<String, Object> getMemberNamenNo(String mem_email);

	int insertLoginLog(LoginLogDTO loginLogDTO);

	AuthorityDTO getAuthInfo(String mem_email);

	int updateAuth(AuthorityDTO authorityDTO);

	int getUserCount();

	boolean isUsing(String mem_email);
}