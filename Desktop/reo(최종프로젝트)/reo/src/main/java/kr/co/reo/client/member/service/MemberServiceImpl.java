package kr.co.reo.client.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.reo.client.member.dao.MemberDAO;
import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.SnsDTO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		memberDAO.insertMember(dto);
		AuthorityDTO authorityDTO = new AuthorityDTO();
		authorityDTO.setMem_email(dto.getMem_email());
		String auth_role = "ROLE_USER";
		if (dto.getMem_sector().equals("관리자")) {
			auth_role = "ROLE_ADMIN";
		} else if (dto.getMem_sector().equals("기업")) {
			auth_role = "ROLE_BIZ";
		}
		authorityDTO.setAuth_role(auth_role);
		authorityDTO.setAuth_enabled(1);
		memberDAO.insertAuth(authorityDTO);
	}

	@Override
	public int updateMember(MemberDTO dto) throws Exception {
		return memberDAO.updateMember(dto);
	}

	@Override
	public void deleteMember(String mem_email) throws Exception {
		memberDAO.deleteMember(mem_email);
		memberDAO.deleteAuth(mem_email);
	}

	@Override
	public String checkEmail(String mem_email) throws Exception {
		return memberDAO.checkEmail(mem_email);
	}

	public MemberDTO checkLoginEmail(String mem_email) throws Exception {
		return memberDAO.checkLoginEmail(mem_email);
	}

	@Override
	public SnsDTO getLoginSns(SnsDTO dto) throws Exception {
		return memberDAO.getLoginSns(dto);
	}

	@Override
	public int updatePass(MemberDTO dto) throws Exception {
		return memberDAO.updatePass(dto);
	}

	@Override
	public int insertLoginLog(LoginLogDTO loginLogDTO) throws Exception {
		return memberDAO.insertLoginLog(loginLogDTO);
	}

	@Override
	public MemberDTO qrScan(String mem_email) throws Exception {
		return memberDAO.qrScan(mem_email);
	}
}