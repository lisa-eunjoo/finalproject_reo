package kr.co.reo.client.office.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.AndroidSearchDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.dto.ReservationDTO;

@Repository
public class ClientOfficeDAOImpl implements ClientOfficeDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<OffImgsDTO> getOffimgs(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffimgs(dto);
	}

	@Override
	public List<OffOptDTO> getOffopts(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffopts(dto);
	}

	@Override
	public List<OfficeDTO> getWishList(String mem_email) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getWishList(mem_email);
	}

	@Override
	public OffImgsDTO getOffimgOne(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffimgOne(dto);
	}

	public OfficeDTO getOffice(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffice(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeByemail(dto);
	}

	@Override
	public List<OfficeDTO> getOffListByemail(HashMap<String, Object> offmap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffListByemail(offmap);
	}

	@Override
	public int getMyOfficeListCount(HashMap<String, Object> offmap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getMyOfficeListCount(offmap);
	}

	public List<OfficeDTO> getOfficeList(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeList(dto);
	}

	@Override
	public List<OfficeDTO> getRecomdList(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getRecomdList(dto);
	}

	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeSortedList(order);
	}

	@Override
	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> unit) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeListByUnit(unit);
	}

	public int getSearchWish(HashMap<String, Object> wishmap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getSearchWish(wishmap);
	}

	public int insertWish(HashMap<String, Object> wishmap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.insertWish(wishmap);
		return result;
	}

	public int deleteWish(HashMap<String, Object> wishmap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.deleteWish(wishmap);
		return result;
	}

	@Override
	public int getSearchLike(HashMap<String, Object> likemap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.getSearchLike(likemap);
		return result;
	}

	@Override
	public int getCountLike(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.getCountLike(dto);
		return result;
	}

	@Override
	public int insertLike(HashMap<String, Object> likemap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.insertLike(likemap);
		return result;
	}

	@Override
	public int deleteLike(HashMap<String, Object> likemap) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.deleteLike(likemap);
		return result;
	}

	@Override
	public int updatePlusLike(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.updatePlusLike(dto);
		return result;
	}

	@Override
	public int updateMinusLike(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		int result = mapper.updateMinusLike(dto);
		return result;
	}

	@Override
	public List<String> getOffimgsname(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		List<String> Offimgsname = mapper.getOffimgsname(dto);
		return Offimgsname;
	}

	@Override
	public List<OfficeDTO> getOfficeAllList() {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeAllList();
	}

	@Override
	public List<OfficeDTO> getOfficeListAll(OfficeDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeListAll(dto);
	}

	@Override
	public List<OffImgsDTO> getOffimgs(ReservationDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffimgs(dto);
	}

	@Override
	public OffImgsDTO getOffimgOne(ReservationDTO dto) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOffimgOne(dto);
	}

	@Override
	public ArrayList<OfficeDTO> getOfficeByKeyword(String keyword) {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeByKeyword(keyword);
	}

	@Override
	public ArrayList<AndroidSearchDTO> getOfficeByListSearch() {
		ClientOfficeDAO mapper = mybatis.getMapper(ClientOfficeDAO.class);
		return mapper.getOfficeByListSearch();
	}

}
