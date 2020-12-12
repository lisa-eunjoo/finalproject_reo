
package kr.co.reo.admin.map.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.OfficeDTO;

@Repository
public class MapDAOImpl implements MapDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void insertMap(MapDTO dto) {
		MapDAO mapper = mybatis.getMapper(MapDAO.class);
		mapper.insertMap(dto);
	}

	@Override
	public OfficeDTO getMapOne(int off_no) {
		MapDAO mapper = mybatis.getMapper(MapDAO.class);
		OfficeDTO list = mapper.getMapOne(off_no);
		return list;
	}

	@Override
	public List<MapDTO> getSearchDong(String dong) {
		MapDAO mapper = mybatis.getMapper(MapDAO.class);
		List<MapDTO> list = mapper.getSearchDong(dong);
		return list;
	}

}