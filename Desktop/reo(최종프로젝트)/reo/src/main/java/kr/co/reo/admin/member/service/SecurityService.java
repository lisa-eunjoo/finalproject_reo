package kr.co.reo.admin.member.service;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import kr.co.reo.admin.member.dao.AdminMemberDAO;
import kr.co.reo.client.member.service.SessionListener;
import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.util.LogAop;

@Component("securityService")
public class SecurityService implements AuthenticationProvider, AuthenticationSuccessHandler {

	@Autowired
	private AdminMemberDAO adminMemberDAO;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	private LogAop logAop;
	private SessionListener sessionListener = SessionListener.getInstance();
	@Autowired
	private UserDetailsService securityUserService;

	// AuthenticationProvider
	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		String mem_email = (String) auth.getPrincipal();
		String mem_pw = (String) auth.getCredentials();
		AuthorityDTO authorityDTO = (AuthorityDTO) securityUserService.loadUserByUsername(mem_email);

		if (authorityDTO == null || !bCryptPasswordEncoder.matches(mem_pw, authorityDTO.getMem_pw())) {
			throw new BadCredentialsException(mem_email);
		}

		if (authorityDTO.getAuthorities() == null) {
			authorityDTO.setAuth_role("ROLE_USER");
		}

		return new UsernamePasswordAuthenticationToken(mem_email, mem_pw, authorityDTO.getAuthorities());
	}

	public boolean supports(Class<?> auth) {
		return auth.equals(UsernamePasswordAuthenticationToken.class);
	}

	// AuthenticationSuccessHandler
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		String mem_email = (String) auth.getPrincipal();
		String mem_sector = "";
		if (auth.getAuthorities().toString().contains("ROLE_ADMIN")) {
			mem_sector = "관리자";
		} else if (auth.getAuthorities().toString().contains("ROLE_BIZ")) {
			mem_sector = "기업";
		} else {
			mem_sector = "일반";
		}
		HttpSession session = request.getSession();

		if (sessionListener.isUsing(mem_email) && (mem_sector.equals("일반"))) {
			logAop.log("중복로그인 시도", request);
			response.sendRedirect(request.getContextPath() + "/login.reo?error=2");
			return;
		}

		String log_ip = request.getRemoteAddr();
		LoginLogDTO loginLogDTO = new LoginLogDTO();
		loginLogDTO.setMem_email(mem_email);
		loginLogDTO.setLog_ip(log_ip); // -Djava.net.preferIPv4Stack=true
		adminMemberDAO.insertLoginLog(loginLogDTO);

		Map<String, Object> map = adminMemberDAO.getMemberNamenNo(mem_email);
		session.setAttribute("mem_name", map.get("mem_name").toString());
		session.setAttribute("mem_email", mem_email);
		session.setAttribute("mem_sector", mem_sector);
		sessionListener.setSession(session, mem_email);

		logAop.log("로그인", request);

		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = "/reo/admin/index.reo";
		if (savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();
			String contextPath = request.getContextPath(); // /reo
			String path = targetUrl.substring(0, targetUrl.indexOf(contextPath)); // http://localhost:8090
			String uri = targetUrl.substring(path.length()); // /reo/index.reo
			String shortURI = uri.substring(contextPath.length()); // /admin/index.reo
			if (shortURI.equals("/admin") || shortURI.equals("/admin/")) {
				targetUrl = path + contextPath + "/admin/index.reo";
			}
		}

		response.sendRedirect(targetUrl);
	}
}