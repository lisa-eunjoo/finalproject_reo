package kr.co.reo.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {

	@RequestMapping(value = { "/404error", "/admin/404error" })
	public String page404() {
		return "error/page404";
	}

	@RequestMapping(value = { "/405error", "/admin/405error" })
	public String page405() {
		return "error/page405";
	}

	@RequestMapping(value = { "/500error", "/admin/500error" })
	public String page500() {
		return "error/page500";
	}
}