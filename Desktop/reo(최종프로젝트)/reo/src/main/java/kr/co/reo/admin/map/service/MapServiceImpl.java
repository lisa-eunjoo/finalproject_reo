
package kr.co.reo.admin.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.reo.admin.map.dao.MapDAO;
import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.OfficeDTO;

@Service("mapService")
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDAO mapDAO;

	@Override
	public void insertMap(MapDTO dto) {
		mapDAO.insertMap(dto);
	}

	@Override
	public OfficeDTO getMapOne(int off_no) {
		OfficeDTO list = mapDAO.getMapOne(off_no);
		return list;
	}

	@Override
	public List<MapDTO> getSearchDong(String dong) {
		List<MapDTO> list = mapDAO.getSearchDong(dong);
		return list;
	}
}