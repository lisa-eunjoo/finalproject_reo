package kr.co.reo.admin.office.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;

@Repository
public class AdminOfficeDAOImpl implements AdminOfficeDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public void insertOffice(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		mapper.insertOffice(dto);
	}

	public void insertOffimgs(OffImgsDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		mapper.insertOffimgs(dto);
	}

	@Override
	public void insertOffopt(OffOptDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		mapper.insertOffopt(dto);
	}

	public int getLatestOffno(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getLatestOffno(dto);
	}

	public List<OffImgsDTO> getOffimgs(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOffimgs(dto);
	}

	@Override
	public List<OffOptDTO> getOffopts(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOffopts(dto);
	}

	@Override
	public OffImgsDTO getOffimgOne(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOffimgOne(dto);
	}

	public int deleteOffimgs(OffImgsDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.deleteOffimgs(dto);
	}

	@Override
	public int deleteOffopts(OffOptDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.deleteOffopts(dto);
	}

	public void updateOffice(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		mapper.updateOffice(dto);
	}

	public int deleteOffice(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.deleteOffice(dto);
	}

	public OfficeDTO getOffice(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOffice(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOfficeByemail(dto);
	}

	public MemberDTO getAgentNameTel(OfficeDTO dto) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getAgentNameTel(dto);
	}

	public List<OfficeDTO> getOfficeList(OfficeDTO offDTO) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOfficeList(offDTO);
	}

	@Override
	public int getOfficeListCount() {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOfficeListCount();
	}

	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOfficeSortedList(order);
	}

	@Override
	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> unit) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOfficeListByUnit(unit);
	}

	@Override
	public int getOffFilterListCount(HashMap<String, Object> unit) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getOffFilterListCount(unit);
	}

	public int getSearchWish(HashMap<String, Object> wishmap) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		return mapper.getSearchWish(wishmap);
	}

	public int insertWish(HashMap<String, Object> wishmap) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		int result = mapper.insertWish(wishmap);
		return result;
	}

	public int deleteWish(HashMap<String, Object> wishmap) {
		AdminOfficeDAO mapper = mybatis.getMapper(AdminOfficeDAO.class);
		int result = mapper.deleteWish(wishmap);
		return result;
	}
}