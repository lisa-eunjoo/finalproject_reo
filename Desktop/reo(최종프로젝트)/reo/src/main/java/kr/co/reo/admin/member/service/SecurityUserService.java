package kr.co.reo.admin.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import kr.co.reo.admin.member.dao.AdminMemberDAO;
import kr.co.reo.common.dto.AuthorityDTO;

@Component("securityUserService")
public class SecurityUserService implements UserDetailsService {

	@Autowired
	private AdminMemberDAO adminMemberDAO;

	// UserDetailsService
	public UserDetails loadUserByUsername(String mem_email) throws UsernameNotFoundException {
		AuthorityDTO authorityDTO = new AuthorityDTO();
		authorityDTO.setMem_email(mem_email);
		authorityDTO = adminMemberDAO.login(authorityDTO);
		if (authorityDTO == null) {
			throw new UsernameNotFoundException(mem_email);
		}

		return authorityDTO;
	}
}