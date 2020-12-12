package kr.co.reo.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component("logAop")
public class LogAop {

	private static final Logger logger = LoggerFactory.getLogger(LogAop.class);

	@Before("execution(* kr.co.reo.admin.*.*(..)) or execution(* kr.co.reo.client.*.*(..))")
	public void beforeLog(JoinPoint jp) {
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getResponse();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.addHeader("Cache-Control", "No-store");
		response.setDateHeader("Expires", 1L);

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		String ip = request.getRemoteAddr(); // -Djava.net.preferIPv4Stack=true
		String mem_email = (String) request.getSession().getAttribute("mem_email");
		String email = (mem_email == null) ? "null" : mem_email;
		String uri = request.getRequestURI();
		String method = (request.getMethod() != null ? "(".concat(request.getMethod()).concat(")") : "");
		String controller = jp.getSignature().toShortString();
		String log = "ip: ".concat(ip).concat(", email: ").concat(email).concat(", uri: ").concat(uri).concat(method)
				.concat(" / ").concat(controller);
		logger.info(log);
	}

	@AfterThrowing("execution(* kr.co.reo..*.*(..))")
	public void afterThrowingLog(JoinPoint jp) {
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getResponse();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.addHeader("Cache-Control", "No-store");
		response.setDateHeader("Expires", 1L);

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		String ip = request.getRemoteAddr(); // -Djava.net.preferIPv4Stack=true
		String mem_email = (String) request.getSession().getAttribute("mem_email");
		String email = (mem_email == null) ? "null" : mem_email;
		String uri = request.getRequestURI();
		String method = (request.getMethod() != null ? "(".concat(request.getMethod()).concat(")") : "");
		String controller = jp.getSignature().toShortString();
		String log = "ip: ".concat(ip).concat(", email: ").concat(email).concat(", uri: ").concat(uri).concat(method)
				.concat(" / ").concat(controller);
		logger.error(log);
	}

	public void log(String message, HttpServletRequest request) {
		String ip = request.getRemoteAddr(); // -Djava.net.preferIPv4Stack=true
		String mem_email = (String) request.getSession().getAttribute("mem_email");
		String email = (mem_email == null) ? "null" : mem_email;
		String log = "ip: ".concat(ip).concat(", email: ").concat(email).concat(", message: ").concat(message);
		logger.info(log);
	}
}