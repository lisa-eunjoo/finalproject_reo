package kr.co.reo.common.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class AuthorityDTO implements UserDetails {
	private static final long serialVersionUID = 1L;

	private int mem_no;
	private String mem_email;
	private String mem_pw;
	private String mem_name;
	private String auth_role;
	private int auth_enabled;
	private int auth_member;
	private int auth_pay;
	private int auth_reservation;
	private int auth_office;
	private int auth_qna;
	private String log_ip;

	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (auth_role == null) {
			return null;
		}
		List<GrantedAuthority> auth = new ArrayList<>();
		auth.add(new SimpleGrantedAuthority(auth_role));

		return auth;
	}

	public String getPassword() {
		return mem_pw;
	}

	public String getUsername() {
		return mem_email;
	}

	public boolean isAccountNonExpired() {
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return (auth_enabled == 1 ? true : false);
	}
}