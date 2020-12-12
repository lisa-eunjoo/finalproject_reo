package kr.co.reo.admin.office.service;

import java.util.HashMap;
import java.util.List;

import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;

public interface AdminOfficeService {

	public List<OfficeDTO> getOfficeList(OfficeDTO offDTO);

	public int getOfficeListCount();

	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order);

	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> unit);

	public int getOffFilterListCount(HashMap<String, Object> unit);

	public OfficeDTO getOffice(OfficeDTO dto);

	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto);

	public MemberDTO getAgentNameTel(OfficeDTO dto);

	public void insertOffice(OfficeDTO dto);

	public void insertOffimgs(OffImgsDTO dto);

	public void insertOffopt(OffOptDTO dto);

	public int getLatestOffno(OfficeDTO dto);

	public List<OffImgsDTO> getOffimgs(OfficeDTO dto);

	public List<OffOptDTO> getOffopts(OfficeDTO dto);

	public OffImgsDTO getOffimgOne(OfficeDTO dto);

	public int deleteOffimgs(OffImgsDTO dto);

	public int deleteOffopts(OffOptDTO dto);

	public void updateOffice(OfficeDTO dto);

	public int deleteOffice(OfficeDTO dto);

	public int getSearchWish(HashMap<String, Object> wishmap);

	public int insertWish(HashMap<String, Object> wishmap);

	public int deleteWish(HashMap<String, Object> wishmap);

	public boolean createQRCode(String filePath, String path, int off_no);
}