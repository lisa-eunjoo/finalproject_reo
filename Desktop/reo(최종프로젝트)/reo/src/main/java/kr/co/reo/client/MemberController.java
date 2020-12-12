package kr.co.reo.client;

import java.io.IOException;
import java.io.StringReader;
import java.net.URI;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.co.reo.client.member.AuthInfo;
import kr.co.reo.client.member.Kakao_restapi;
import kr.co.reo.client.member.service.MemberService;
import kr.co.reo.client.member.service.SessionListener;
import kr.co.reo.client.member.service.VerifyRecaptcha;
import kr.co.reo.client.office.service.ClientOfficeService;
import kr.co.reo.client.qna.service.QnaClientService;
import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.NaverLoginBO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.util.LogAop;

@Controller
public class MemberController {

	private NaverLoginBO naverLoginBO;
	@Autowired
	private MemberService memberService;
	@Autowired
	private QnaClientService qnaService;
	@Autowired
	private ClientOfficeService officeService;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Inject
	private AuthInfo authInfo;
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	@Autowired
	private UserDetailsService securityUserService;
	@Autowired
	private LogAop logAop;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@RequestMapping(value = "/mypage.reo", method = RequestMethod.GET)
	public String mypage(Model model, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		if (session.getAttribute("mem_email") == null) {
			return "client/member/login";
		}
		MemberDTO dto = memberService.checkLoginEmail(mem);
		model.addAttribute("member", dto);
		return "client/member/mypage";
	}

	@RequestMapping(value = "/mydeleteMember.reo", method = RequestMethod.GET)
	public String deleteMember(Model model, HttpSession session) throws Exception {

		String mem = (String) session.getAttribute("mem_email");
		MemberDTO dto = memberService.checkLoginEmail(mem);
		model.addAttribute("member", dto);
		return "client/member/mydeletemember";
	}

	@ResponseBody
	@RequestMapping(value = "/mydeleteMember.reo", method = RequestMethod.POST)
	public String deleteMember(Model model, String mem_pw, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		String rawPassword = mem_pw;
		if (mem != null) {
			MemberDTO dto = memberService.checkLoginEmail(mem);

			String encodedPassword = dto.getMem_pw();
			if (bCryptPasswordEncoder.matches(rawPassword, encodedPassword) == true) {
				memberService.deleteMember(mem);
				model.addAttribute("member", "true");
				return "true";
			} else {
				model.addAttribute("member", "false");
				return "false";
			}
		}
		return "false";
	}

	@RequestMapping(value = "/insertMember.reo", method = RequestMethod.GET)
	public String insertPage(@ModelAttribute("memberDTO") MemberDTO dto, Model model, String buisness,
			HttpServletRequest request) throws Exception {
		model.addAttribute("buisness", buisness);
		return "client/member/join";
	}

	@RequestMapping(value = "/insertMember.reo", method = RequestMethod.POST)
	public String insertMember(@Valid MemberDTO dto, BindingResult bindingResult) throws Exception {
		if (bindingResult.hasErrors()) {
			return "client/member/join";
		} else {
			String encPassword = bCryptPasswordEncoder.encode(dto.getMem_pw());
			dto.setMem_pw(encPassword);
			if (dto.getMem_buisnessNo() == null) {
				dto.setMem_sector("일반");
			} else {
				dto.setMem_sector("기업");
			}
			if (dto.getMem_role() == null) {
				dto.setMem_role("일반");
			}
			memberService.insertMember(dto);
			return "client/member/login";
		}
	}

	@RequestMapping(value = "/login.reo", method = RequestMethod.GET)
	public String loginMember(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// URL을 생성한다.
		String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);

		// 네이버
		model.addAttribute("url", naverAuthUrl);
		return "client/member/login";
	}

//	@RequestMapping(value = "/login.reo", method = RequestMethod.POST)
//	public String loginMember(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String mem_email = request.getParameter("mem_email");
//		MemberDTO dto = memberService.checkLoginEmail(mem_email);
//		try {
//			HttpSession session = request.getSession(true);
//			// 이미 접속한 아이디인지 체크
//			// 현재 접속자들 보여주기
//			SessionListener.getInstance().printloginUsers();
//
//			if (SessionListener.getInstance().isUsing(dto.getMem_email())) {
//				System.out.println("중복 로그인 감지.");
//				return "client/member/login";
//			}
//			// 접속 하고자 하는 아이디의 세션을 담는다
//			session.setAttribute("mem_email", dto.getMem_email());
//			session.setAttribute("mem_name", dto.getMem_name());
//			session.setAttribute("mem_sector", dto.getMem_sector());
//			String log_ip = request.getRemoteAddr();
//			LoginLogDTO loginLogDTO = new LoginLogDTO();
//			loginLogDTO.setMem_email(mem_email);
//			loginLogDTO.setLog_ip(log_ip); // -Djava.net.preferIPv4Stack=true
//			memberService.insertLoginLog(loginLogDTO);
//
//			SessionListener.getInstance().setSession(session, dto.getMem_email());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "client/index";
//	}

	// 네이버
	@RequestMapping(value = "/callback.reo", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, MemberDTO dto,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(true);
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBO.getUserProfile(oauthToken);

		model.addAttribute("result", apiResult);

		JSONObject jobj = null;
		try {
			jobj = (JSONObject) new JSONParser().parse(apiResult);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jobj1 = (JSONObject) jobj.get("response");
		if (dto.getMem_buisnessNo() == null) {
			dto.setMem_sector("일반");
		} else {
			dto.setMem_sector("기업");
		}
		String mem_email = (String) jobj1.get("id");
		AuthorityDTO authorityDTO = null;
		try {
			authorityDTO = (AuthorityDTO) securityUserService.loadUserByUsername(mem_email);
		} catch (Exception e) {
		}
		if (authorityDTO == null) {
			dto.setMem_role("네이버");
			dto.setMem_name((String) jobj1.get("name"));
			return "client/member/join";
		}

		if (authorityDTO.getAuthorities() == null) {
			authorityDTO.setAuth_role("ROLE_USER");
		}
		Authentication auth = new UsernamePasswordAuthenticationToken(authorityDTO.getMem_email(),
				authorityDTO.getMem_pw(), authorityDTO.getAuthorities());
		SecurityContext securityContext = SecurityContextHolder.getContext();
		securityContext.setAuthentication(auth);
		session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

		String mem_sector = "";
		if (auth.getAuthorities().toString().contains("ROLE_ADMIN")) {
			mem_sector = "관리자";
		} else if (auth.getAuthorities().toString().contains("ROLE_BIZ")) {
			mem_sector = "기업";
		} else {
			mem_sector = "일반";
		}

		String log_ip = request.getRemoteAddr();
		LoginLogDTO loginLogDTO = new LoginLogDTO();
		loginLogDTO.setMem_email(authorityDTO.getMem_email());
		loginLogDTO.setLog_ip(log_ip); // -Djava.net.preferIPv4Stack=true
		memberService.insertLoginLog(loginLogDTO);

		session.setAttribute("mem_name", authorityDTO.getMem_name());
		session.setAttribute("mem_email", authorityDTO.getMem_email());
		session.setAttribute("mem_sector", mem_sector);
		SessionListener.getInstance().setSession(session, authorityDTO.getMem_email());
		logAop.log("로그인", request);

		// 네이버 로그인 성공 페이지 View 호출
		return "client/member/login";
	}

	@RequestMapping(value = "/index.reo", method = RequestMethod.GET)
	public String index() throws Exception {
		return "client/index";
	}

	@RequestMapping(value = "/myinfo.reo", method = RequestMethod.GET)
	public String myinfo(Model model, HttpSession session) throws Exception {

		String mem = (String) session.getAttribute("mem_email");

		MemberDTO dto = memberService.checkLoginEmail(mem);
		model.addAttribute("member", dto);
		return "client/member/myinfo";
	}

	@RequestMapping(value = "/myinfomodify.reo", method = RequestMethod.GET)
	public String myinfomodify(Model model, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		MemberDTO dto = memberService.checkLoginEmail(mem);
		dto.setMem_pw(null);
		model.addAttribute("memberDTO", dto);

		return "client/member/myinfomodify";
	}

	@RequestMapping(value = "/myQnaList.reo", method = RequestMethod.GET)
	public String myQnaList(HttpSession session, Model model) throws Exception {
		String qna_email = (String) session.getAttribute("mem_email");
		model.addAttribute("mylist", qnaService.getMyQnaList(qna_email));
		return "client/member/myQnaList";
	}

	@RequestMapping(value = "/myupdateMember.reo", method = RequestMethod.POST)
	public String updateMember(@Valid MemberDTO dto, BindingResult bindingResult) throws Exception {
		if (dto.getMem_pw() == "" || dto.getMem_pw() == null) {
			dto.setMem_pw("");
		} else {
			if (bindingResult.hasErrors()) {
				return "client/member/myinfomodify";
			} else {
				String encPassword = bCryptPasswordEncoder.encode(dto.getMem_pw());
				dto.setMem_pw(encPassword);
				memberService.updateMember(dto);
			}
		}
		memberService.updateMember(dto);

		return "client/member/mybooking";
	}

	@RequestMapping(value = "/myfavorite.reo", method = RequestMethod.GET)
	public String myfavorite(HttpSession session, Model model) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		int index = 0;
		List<OfficeDTO> wishlist = officeService.getWishList(mem);
		for (OfficeDTO list : wishlist) {
			try {
				if (officeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(officeService.getOffimgOne(list).getOffimg_name());
					wishlist.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		model.addAttribute("mywishlist", wishlist);
		return "client/member/myfavorite";
	}

	@RequestMapping(value = "/agreement.reo", method = RequestMethod.GET)
	public String agreement(HttpServletRequest request) throws Exception {
		String buisness = request.getParameter("buisness");
		request.setAttribute("buisness", buisness);
		return "/client/member/agreement";
	}

	@ResponseBody
	@RequestMapping(value = "/emailChk.reo", produces = "application/text; charset=utf-8")
	public String emailChk(@RequestParam("mem_email") String mem_email) throws Exception {
		return memberService.checkEmail(mem_email);
	}

	@ResponseBody
	@RequestMapping(value = "/pwinsert.reo", method = RequestMethod.POST)
	public String pwinsert(MemberDTO dto, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		String encPassword = bCryptPasswordEncoder.encode(dto.getMem_pw());
		dto.setMem_email(mem);
		dto.setMem_pw(encPassword);
		int check = memberService.updatePass(dto);

		if (check == 0) {
			return "false";
		}

		return "true";
	}

	@ResponseBody
	@RequestMapping(value = "/pwChk.reo", method = RequestMethod.POST)
	public boolean loginChk(@RequestParam("mem_email") String mem_email, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		boolean encodepw = false;
		if (mem == null) {
			String email = mem_email.substring(0, mem_email.indexOf(","));
			String rawPassword = mem_email.substring(mem_email.indexOf("=") + 1, mem_email.length());
			MemberDTO dto = memberService.checkLoginEmail(email);

			String encodedPassword = dto.getMem_pw();
			encodepw = bCryptPasswordEncoder.matches(rawPassword, encodedPassword);

			return encodepw;
		}
		String rawPassword = mem_email;

		MemberDTO dto = memberService.checkLoginEmail(mem);

		String encodedPassword = dto.getMem_pw();
		encodepw = bCryptPasswordEncoder.matches(rawPassword, encodedPassword);

		return encodepw;
	}

	@ResponseBody
	@RequestMapping(value = "/pwCheck.reo", method = RequestMethod.POST)
	public boolean pwChk(@RequestParam("mem_pw") String mem_pw, HttpSession session) throws Exception {
		String mem = (String) session.getAttribute("mem_email");
		boolean encodepw = false;
		String rawPassword = mem_pw;

		MemberDTO dto = memberService.checkLoginEmail(mem);

		String encodedPassword = dto.getMem_pw();
		encodepw = bCryptPasswordEncoder.matches(rawPassword, encodedPassword);

		return encodepw;
	}

	@RequestMapping(value = "/passchange.reo", method = RequestMethod.GET)
	public String passchange(@ModelAttribute("memberDTO") MemberDTO dto, Model model) throws Exception {
		return "/client/member/passchange";
	}

	@RequestMapping(value = "/passchange.reo", method = RequestMethod.POST)
	public String passchange(MemberDTO dto) throws Exception {
		String encPassword = bCryptPasswordEncoder.encode(dto.getMem_pw());
		dto.setMem_pw(encPassword);
		int check = memberService.updatePass(dto);

		if (check == 0) {
			return "client/member/passchange";
		}

		return "client/member/login";
	}

	@ResponseBody
	@RequestMapping(value = "/buisnessNo.reo", method = RequestMethod.GET)
	public String buisnessNo(String mem_buisnessNo) throws Exception {
		// num ex = 3051577349, 1021551153, 0123456789 -> 10글자
		RestTemplate restTemplate = new RestTemplate();

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Accept", "application/xml; charset=UTF-8");
		headers.add("Content-Type", "application/xml; charset=UTF-8");

		// 서버로 요청할 Body
		String body = "<map id=\"ATTABZAA001R08\"><pubcUserNo/><mobYn>N</mobYn><inqrTrgtClCd>1</inqrTrgtClCd><txprDscmNo>"
				+ mem_buisnessNo
				+ "</txprDscmNo><dongCode>15</dongCode><psbSearch>Y</psbSearch><map id=\"userReqInfoVO\"/></map>";

		HttpEntity<String> http = new HttpEntity<>(body, headers);

		try {
			String result = restTemplate.postForObject(new URI(
					"https://teht.hometax.go.kr/wqAction.do?actionId=ATTABZAA001R08&screenId=UTEABAAA13&popupYn=false&realScreenId="),
					http, String.class);
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			InputSource source = new InputSource();
			source.setCharacterStream(new StringReader(result));
			Document document = builder.parse(source);
			NodeList nodeList = document.getElementsByTagName("smpcBmanTrtCntn");
			Node node = nodeList.item(0);
			String smpcBmanTrtCntn = node.getFirstChild().getNodeValue();
			String trtCntn = document.getElementsByTagName("trtCntn").item(0).getFirstChild().getNodeValue();
			if (smpcBmanTrtCntn.startsWith("등록되어 있는")) {
				return "0";
			} else {
				return "1";
			}

		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/sendMail")
	public String mailSending(HttpSession session, HttpServletRequest request, String mem_email,
			HttpServletResponse response_email) throws Exception {
		Random r = new Random();
		String cerString = ""; // 이메일로 받는 인증코드 부분 (난수)
		for (int i = 0; i < 6; i++) {
			int rNum = r.nextInt(3);
			switch (rNum) {
			case 0:
				cerString += ((char) (r.nextInt(26) + 97)); // a-z
				break;
			case 1:
				cerString += ((char) (r.nextInt(26) + 65)); // A-Z
				break;
			case 2:
				cerString += (r.nextInt(10)); // 0-9
				break;
			}
		}
		cerString = cerString.toUpperCase();
		session.setAttribute("email_injeung", cerString);
		String setfrom = "ljw921110@gmail.com";
		String tomail = request.getParameter("mem_email"); // 받는 사람 이메일
		String title = "REO 이메일 인증 안내"; // 제목
		String content = System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
				System.getProperty("line.separator") + "안녕하세요 회원님 저희 REO를 찾아주셔서 감사합니다"
				+ System.getProperty("line.separator") + System.getProperty("line.separator") + " 인증번호는 " + cerString
				+ " 입니다. " + System.getProperty("line.separator") + System.getProperty("line.separator")
				+ "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용
			mailSender.send(message);

		} catch (Exception e) {
			System.out.println("sendEmail : " + e);
			e.printStackTrace();
		}

		return "/client/member/join";
	}

	@ResponseBody
	@RequestMapping(value = "/join_injeung.reo", method = RequestMethod.POST)
	public String join_injeung(@RequestBody String json, HttpServletResponse response_equals, HttpSession session)
			throws IOException {
		json = URLDecoder.decode(json, "UTF-8");
		json = json.substring(0, json.lastIndexOf("="));
		JSONObject jobj = null;
		try {
			jobj = (JSONObject) new JSONParser().parse(json);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String email_injeung = (String) session.getAttribute("email_injeung");
		String cerString = (String) jobj.get("cerNum");

		String data = "1";

		if (email_injeung.equals(cerString)) {
			data = "0";
		}

		return data;
	}

	@RequestMapping(value = "/oauth.reo", produces = "application/json")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) {
		Kakao_restapi kr = new Kakao_restapi();
		// 결과값을 node에 담아줌
		JsonNode node = kr.getAccessToken(code);
		// 결과값 출력
		// 노드 안에 있는 access_token값을 꺼내 문자열로 변환
		String token = node.get("access_token").toString();
		// 세션에 담아준다.
		session.setAttribute("token", token);

		return "client/index";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/googleCallback.reo")
	public String doSessionAssignActionPage(Model model, HttpServletRequest request, HttpServletResponse response, MemberDTO dto, HttpSession session)
			throws Exception {
		String code = request.getParameter("code");

		// RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
		parameters.add("code", code);
		parameters.add("client_id", authInfo.getClientId());
		parameters.add("client_secret", authInfo.getClientSecret());
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(
				parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token",
				HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();

		// id_token 라는 키에 사용자가 정보가 존재한다.
		// 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두
		// 번째는 우리가 필요한 내용이 존재한다.
		// 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
		// Base 64로 인코딩 되어 있으므로 디코딩한다.

		String[] tokens = ((String) responseMap.get("id_token")).split("\\.");

		String str = new String(Base64.decodeBase64(tokens[1]), "utf-8");
		JSONObject jobj = (JSONObject) new JSONParser().parse(str);
		String mem_email = jobj.get("email").toString();
		String name = jobj.get("name").toString();

		AuthorityDTO authorityDTO = null;
		try {
			authorityDTO = (AuthorityDTO) securityUserService.loadUserByUsername(mem_email);
		} catch (Exception e) {
		}
		if (authorityDTO == null) {
			dto.setMem_role("구글");
			dto.setMem_name(name);
			dto.setMem_email(mem_email);
			model.addAttribute("memberDTO", dto);
		} else {
			if (authorityDTO.getAuthorities() == null) {
				authorityDTO.setAuth_role("ROLE_USER");
			}
			Authentication auth = new UsernamePasswordAuthenticationToken(authorityDTO.getMem_email(),
					authorityDTO.getMem_pw(), authorityDTO.getAuthorities());
			SecurityContext securityContext = SecurityContextHolder.getContext();
			securityContext.setAuthentication(auth);
			session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

			String mem_sector = "";
			if (auth.getAuthorities().toString().contains("ROLE_ADMIN")) {
				mem_sector = "관리자";
			} else if (auth.getAuthorities().toString().contains("ROLE_BIZ")) {
				mem_sector = "기업";
			} else {
				mem_sector = "일반";
			}

			String log_ip = request.getRemoteAddr();
			LoginLogDTO loginLogDTO = new LoginLogDTO();
			loginLogDTO.setMem_email(authorityDTO.getMem_email());
			loginLogDTO.setLog_ip(log_ip); // -Djava.net.preferIPv4Stack=true
			memberService.insertLoginLog(loginLogDTO);

			session.setAttribute("mem_name", authorityDTO.getMem_name());
			session.setAttribute("mem_email", authorityDTO.getMem_email());
			session.setAttribute("mem_sector", mem_sector);
			SessionListener.getInstance().setSession(session, authorityDTO.getMem_email());
			logAop.log("로그인", request);

			RequestCache requestCache = new HttpSessionRequestCache();
			SavedRequest savedRequest = requestCache.getRequest(request, response);
			String targetUrl = "/admin/index.reo";
			if (savedRequest != null) {
				targetUrl = savedRequest.getRedirectUrl();
				String contextPath = request.getContextPath();
				String path = targetUrl.substring(0, targetUrl.indexOf(contextPath));
				String fulluri = targetUrl.substring(path.length());
				String uri = fulluri.substring(contextPath.length());
				if (uri.equals("/admin") || uri.equals("/admin/")) {
					targetUrl = path + contextPath + "/admin/index.reo";
				}
			}

			return "redirect:" + targetUrl;
		}

		return "client/member/join";
	}

	@ResponseBody
	@RequestMapping(value = "/VerifyRecaptcha.reo", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6Lepb7UZAAAAAJHafPVsC3QhOyQnbDoiUNH9LqDh");
		String gRecaptchaResponse = request.getParameter("recaptcha");
		try {
			if (VerifyRecaptcha.verify(gRecaptchaResponse)) {
				return 0; // 성공
			} else {
				return 1; // 실패
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
			return -1; // 에러
		}
	}
}
