
package kr.co.reo.admin.map.dao;

import java.util.List;

import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.OfficeDTO;

public interface MapDAO {

	public void insertMap(MapDTO dto);

	public OfficeDTO getMapOne(int off_no);

	public List<MapDTO> getSearchDong(String dong);
}