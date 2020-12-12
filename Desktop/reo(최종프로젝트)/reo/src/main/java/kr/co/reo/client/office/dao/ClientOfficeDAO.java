package kr.co.reo.client.office.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.reo.common.dto.AndroidSearchDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.ReservationDTO;

public interface ClientOfficeDAO {

	public List<OffImgsDTO> getOffimgs(OfficeDTO dto);

	public List<OffOptDTO> getOffopts(OfficeDTO dto);

	public List<OfficeDTO> getWishList(String mem_email);

	public OffImgsDTO getOffimgOne(OfficeDTO dto);

	public List<OffImgsDTO> getOffimgs(ReservationDTO dto);

	public OffImgsDTO getOffimgOne(ReservationDTO dto);

	public OfficeDTO getOffice(OfficeDTO dto);

	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> unit);

	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto);

	public List<OfficeDTO> getOffListByemail(HashMap<String, Object> offmap);

	public int getMyOfficeListCount(HashMap<String, Object> offmap);

	public List<OfficeDTO> getOfficeAllList();

	public List<OfficeDTO> getOfficeList(OfficeDTO dto);

	public List<OfficeDTO> getOfficeListAll(OfficeDTO dto);

	public List<OfficeDTO> getRecomdList(OfficeDTO dto);

	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order);

	public int getSearchWish(HashMap<String, Object> wishmap);

	public int insertWish(HashMap<String, Object> wishmap);

	public int deleteWish(HashMap<String, Object> wishmap);

	public int getSearchLike(HashMap<String, Object> likemap);

	public int getCountLike(OfficeDTO dto);

	public int insertLike(HashMap<String, Object> likemap);

	public int deleteLike(HashMap<String, Object> likemap);

	public int updatePlusLike(OfficeDTO dto);

	public int updateMinusLike(OfficeDTO dto);

	public List<String> getOffimgsname(OfficeDTO dto);

	public ArrayList<OfficeDTO> getOfficeByKeyword(String keyword);

	public ArrayList<AndroidSearchDTO> getOfficeByListSearch();

}