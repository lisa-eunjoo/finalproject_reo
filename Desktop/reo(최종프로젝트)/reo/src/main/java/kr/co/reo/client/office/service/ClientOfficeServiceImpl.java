package kr.co.reo.client.office.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.reo.client.office.dao.ClientOfficeDAO;
import kr.co.reo.common.dto.AndroidSearchDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.util.PageUtil;

@Service("clientOfficeService")
public class ClientOfficeServiceImpl implements ClientOfficeService {
	@Autowired
	private ClientOfficeDAO clientOfficeDAO;

	@Autowired
	private PageUtil pageUtil;

	@Override
	public List<OfficeDTO> getOfficeList(OfficeDTO dto) {
		return clientOfficeDAO.getOfficeList(dto);
	}

	@Override
	public List<OfficeDTO> getRecomdList(OfficeDTO dto) {
		return clientOfficeDAO.getRecomdList(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order) {
		return clientOfficeDAO.getOfficeSortedList(order);
	}

	@Override
	public List<OfficeDTO> getWishList(String mem_email) {
		return clientOfficeDAO.getWishList(mem_email);
	}

	@Override
	public OfficeDTO getOffice(OfficeDTO dto) {
		return clientOfficeDAO.getOffice(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> unit) {
		return clientOfficeDAO.getOfficeListByUnit(unit);
	}

	@Override
	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto) {
		return clientOfficeDAO.getOfficeByemail(dto);
	}

	@Override
	public List<OfficeDTO> getOffListByemail(HashMap<String, Object> offmap) {
		int totalRows = getMyOfficeListCount(offmap);
		offmap.put("pageNo", pageUtil.ablePageNo(Integer.parseInt(offmap.get("pageNo").toString()), totalRows));
		offmap.put("LIMIT", pageUtil.getLimit());
		offmap.put("OFFSET", pageUtil.getOffset(Integer.parseInt(offmap.get("pageNo").toString())));
		return clientOfficeDAO.getOffListByemail(offmap);
	}

	@Override
	public int getMyOfficeListCount(HashMap<String, Object> offmap) {
		return clientOfficeDAO.getMyOfficeListCount(offmap);
	}

	@Override
	public List<OffImgsDTO> getOffimgs(OfficeDTO dto) {
		return clientOfficeDAO.getOffimgs(dto);
	}

	@Override
	public List<OffImgsDTO> getOffimgs(ReservationDTO dto) {
		return clientOfficeDAO.getOffimgs(dto);
	}

	@Override
	public List<OffOptDTO> getOffopts(OfficeDTO dto) {
		return clientOfficeDAO.getOffopts(dto);
	}

	@Override
	public OffImgsDTO getOffimgOne(OfficeDTO dto) {
		return clientOfficeDAO.getOffimgOne(dto);
	}

	@Override
	public OffImgsDTO getOffimgOne(ReservationDTO dto) {
		return clientOfficeDAO.getOffimgOne(dto);
	}

	@Override
	public int getSearchWish(HashMap<String, Object> wishmap) {
		return clientOfficeDAO.getSearchWish(wishmap);
	}

	@Override
	public int insertWish(HashMap<String, Object> wishmap) {
		return clientOfficeDAO.insertWish(wishmap);
	}

	@Override
	public int deleteWish(HashMap<String, Object> wishmap) {
		return clientOfficeDAO.deleteWish(wishmap);
	}

	@Override
	public int getSearchLike(HashMap<String, Object> likemap) {
		return clientOfficeDAO.getSearchLike(likemap);
	}

	@Override
	public int getCountLike(OfficeDTO dto) {
		return clientOfficeDAO.getCountLike(dto);
	}

	@Override
	public int insertLike(HashMap<String, Object> likemap) {
		return clientOfficeDAO.insertLike(likemap);
	}

	@Override
	public int deleteLike(HashMap<String, Object> likemap) {
		return clientOfficeDAO.deleteLike(likemap);
	}

	@Override
	public int updatePlusLike(OfficeDTO dto) {
		return clientOfficeDAO.updatePlusLike(dto);
	}

	@Override
	public int updateMinusLike(OfficeDTO dto) {
		return clientOfficeDAO.updateMinusLike(dto);
	}

	@Override
	public List<String> getOffimgsname(OfficeDTO dto) {
		return clientOfficeDAO.getOffimgsname(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeAllList() {
		return clientOfficeDAO.getOfficeAllList();
	}

	@Override
	public List<OfficeDTO> getOfficeListAll(OfficeDTO dto) {
		return clientOfficeDAO.getOfficeListAll(dto);
	}

	@Override
	public ArrayList<AndroidSearchDTO> getOfficeByListSearch() {
		return clientOfficeDAO.getOfficeByListSearch();
	}

	@Override
	public ArrayList<OfficeDTO> getOfficeByKeyword(String keyword) {
		return clientOfficeDAO.getOfficeByKeyword(keyword);
	}

}