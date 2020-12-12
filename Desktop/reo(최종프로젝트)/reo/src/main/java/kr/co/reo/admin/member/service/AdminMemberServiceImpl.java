package kr.co.reo.admin.member.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.co.reo.admin.member.dao.AdminMemberDAO;
import kr.co.reo.client.member.service.SessionListener;
import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.ChartDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.util.PageUtil;

@Service("adminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDAO adminMemberDAO;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	private SessionListener sessionListener = SessionListener.getInstance();

	public AuthorityDTO login(AuthorityDTO authorityDTO) {
		String password = authorityDTO.getMem_pw();
		authorityDTO = adminMemberDAO.login(authorityDTO);
		if (authorityDTO == null || !bCryptPasswordEncoder.matches(password, authorityDTO.getMem_pw())) {
			return null;
		}

		return authorityDTO;
	}

	public List<ChartDTO> getAgeData() {
		List<ChartDTO> ageData = adminMemberDAO.getAgeData();
		List<ChartDTO> chartDTOList = new ArrayList<>();
		int counts = 0;
		for (ChartDTO dto : ageData) {
			if (Integer.parseInt(dto.getAge()) > 5) {
				counts += dto.getCounts();
			}
		}

		for (int i = 1; i < 7; i++) {
			ChartDTO chartDTO = new ChartDTO();
			chartDTO.setAge(i + "0대");
			if (i == 6) {
				chartDTO.setAge("60대 이상");
				chartDTO.setCounts(counts);
				chartDTOList.add(chartDTO);
				break;
			}
			for (int j = 0; j < ageData.size(); j++) {
				if (Integer.parseInt(ageData.get(j).getAge()) == i) {
					chartDTO.setCounts(ageData.get(j).getCounts());
					chartDTOList.add(chartDTO);
					break;
				}
				if (j == ageData.size() - 1) {
					chartDTO.setCounts(0);
					chartDTOList.add(chartDTO);
				}
			}
		}

		return chartDTOList;
	}

	public List<ChartDTO> getTopPayData() {
		return adminMemberDAO.getTopPayData();
	}

	public List<LoginLogDTO> getLoginLog(LoginLogDTO loginLogDTO) {
		if (loginLogDTO.getPageNo() == 0) {
			loginLogDTO.setPageNo(1);
		}

		if (loginLogDTO.getLIMIT() == 0) {
			loginLogDTO.setLIMIT(pageUtil.getLimit());
			loginLogDTO.setOFFSET(pageUtil.getOffset(loginLogDTO.getPageNo()));
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today = sdf.format(date);
		try {
			sdf.parse(loginLogDTO.getFromDate());
		} catch (Exception e) {
			loginLogDTO.setFromDate("2010-01-01");
		}
		try {
			sdf.parse(loginLogDTO.getToDate());
		} catch (Exception e) {
			loginLogDTO.setToDate(today);
		}

		if (loginLogDTO.getSearchType() == null) {
			loginLogDTO.setSearchType("mem_email");
		} else if (!loginLogDTO.getSearchType().equals("mem_email") && !loginLogDTO.getSearchType().equals("log_ip")) {
			loginLogDTO.setSearchType("mem_email");
		}

		if (loginLogDTO.getSearch() == null) {
			loginLogDTO.setSearch("");
		}

		int totalRows = getLoginLogListCount(loginLogDTO);
		loginLogDTO.setPageNo(pageUtil.ablePageNo(loginLogDTO.getPageNo(), totalRows));

		return adminMemberDAO.getLoginLog(loginLogDTO);
	}

	public int getLoginLogListCount(LoginLogDTO loginLogDTO) {
		return adminMemberDAO.getLoginLogListCount(loginLogDTO);
	}

	public List<ChartDTO> getLoginDateCount(int difDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<ChartDTO> chartDTOList = adminMemberDAO.getLoginDateCount(difDate);
		Map<String, Integer> map = new HashMap<>();
		for (ChartDTO chartDTO : chartDTOList) {
			map.put(chartDTO.getDates().toString(), chartDTO.getCounts());
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE, -difDate);

		for (int i = 0; i < difDate; i++) {
			String beforeDate = sdf.format(calendar.getTime());
			if (map.get(beforeDate) == null) {
				ChartDTO chartDTO = new ChartDTO();
				chartDTO.setDates(new java.sql.Date(calendar.getTimeInMillis()));
				chartDTO.setCounts(0);
				chartDTOList.add(chartDTO);
			}
			calendar.add(Calendar.DATE, 1);
		}

		Collections.sort(chartDTOList, new Comparator<ChartDTO>() {
			public int compare(ChartDTO c1, ChartDTO c2) {
				return c1.getDates().compareTo(c2.getDates());
			}
		});

		return chartDTOList;
	}

	public String wordCloud() {
		String url = "http://218.50.121.249:8000";
		try {
			new RestTemplate().postForLocation(url + "/reo/wordcloud", "");
		} catch (Exception e) {
			System.out.println(url + "서버 닫힘 getWordCloud" + e);
			try {
				new RestTemplate().postForLocation("http://218.50.121.249:8000/reo/wordcloud", "");
				url = "http://localhost:8000";
			} catch (Exception e1) {
				System.out.println("http://218.50.121.249:8000/reo서버 닫힘 getWordCloud" + e1);
			}
		}

		return url + "/static/wordcloud.png";
	}

	public int insertMember(MemberDTO memberDTO) {
		int insertCount = adminMemberDAO.insertMember(memberDTO);
		if (insertCount == 1) {
			AuthorityDTO authorityDTO = new AuthorityDTO();
			authorityDTO.setMem_email(memberDTO.getMem_email());
			String auth_role = "ROLE_USER";
			if (memberDTO.getMem_sector().equals("관리자")) {
				auth_role = "ROLE_ADMIN";
			} else if (memberDTO.getMem_sector().equals("기업")) {
				auth_role = "ROLE_BIZ";
			}
			authorityDTO.setAuth_role(auth_role);
			authorityDTO.setAuth_enabled(1);
			adminMemberDAO.insertAuth(authorityDTO);
		}
		return insertCount;
	}

	public int updateMember(MemberDTO memberDTO) {
		return adminMemberDAO.updateMember(memberDTO);
	}

	public int deleteMember(int mem_no) {
		int deleteCount = adminMemberDAO.deleteMember(mem_no);
		if (deleteCount == 1) {
			adminMemberDAO.deleteAuth(mem_no);
		}
		return deleteCount;
	}

	public int initPassword(int mem_no) {
		String pw = "reo123456!";
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMem_no(mem_no);
		memberDTO.setMem_pw(bCryptPasswordEncoder.encode(pw));
		return adminMemberDAO.initPassword(memberDTO);
	}

	public List<MemberDTO> getMemberList(Map<String, String> params) {
		if (params.get("searchType") == null) {
			params.put("searchType", "mem_email");
		}
		if (params.get("searchKeyword") == null) {
			params.put("searchKeyword", "");
		}
		if (params.get("pageNo") == null) {
			params.put("pageNo", "1");
		}

		int totalRows = getMemberListCount(params);
		params.put("pageNo", String.valueOf(pageUtil.ablePageNo(Integer.valueOf(params.get("pageNo")), totalRows)));
		params.put("LIMIT", String.valueOf(pageUtil.getLimit()));
		params.put("OFFSET", String.valueOf(pageUtil.getOffset(Integer.valueOf(params.get("pageNo")))));

		return adminMemberDAO.getMemberList(params);
	}

	public int getMemberListCount(Map<String, String> params) {
		return adminMemberDAO.getMemberListCount(params);
	}

	public MemberDTO getMemberInfo(int mem_no) {
		return adminMemberDAO.getMemberInfo(mem_no);
	}

	public int getMemberIdCheck(String mem_email) {
		return adminMemberDAO.getMemberIdCheck(mem_email);
	}

	public int deleteMemberMulti(String[] mem_noArray) {
		List<Integer> mem_noList = new ArrayList<>();
		for (String mem_no : mem_noArray) {
			mem_noList.add(Integer.parseInt(mem_no));
		}
		int deleteCount = adminMemberDAO.deleteMemberMulti(mem_noList);
		if (deleteCount > 0) {
			adminMemberDAO.deleteAuthMulti(mem_noList);
		}
		return deleteCount;
	}

	public Map<String, Object> getMemberNamenNo(String mem_email) {
		return adminMemberDAO.getMemberNamenNo(mem_email);
	}

	public int insertLoginLog(LoginLogDTO loginLogDTO) {
		return adminMemberDAO.insertLoginLog(loginLogDTO);
	}

	public AuthorityDTO getAuthInfo(String mem_email) {
		return adminMemberDAO.getAuthInfo(mem_email);
	}

	public int updateAuth(AuthorityDTO authorityDTO) {
		return adminMemberDAO.updateAuth(authorityDTO);
	}

	public int getUserCount() {
		return sessionListener.getUserCount();
	}

	public boolean isUsing(String mem_email) {
		return sessionListener.isUsing(mem_email);
	}
}
