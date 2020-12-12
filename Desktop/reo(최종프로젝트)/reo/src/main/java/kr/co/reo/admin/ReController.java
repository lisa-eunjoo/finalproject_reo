package kr.co.reo.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.reo.admin.map.service.MapService;
import kr.co.reo.client.office.service.ClientOfficeService;
import kr.co.reo.common.dto.MapDTO;
import kr.co.reo.common.dto.OfficeDTO;

@RestController
public class ReController {
	@Autowired
	private MapService mapService;
	@Autowired
	private ClientOfficeService officeService;

	@RequestMapping(value = "/indexList.reo", method = RequestMethod.GET)
	public List<OfficeDTO> indexList(OfficeDTO dto) throws IOException {
		int index = 0;
		List<OfficeDTO> indexList = officeService.getRecomdList(dto);

		for (OfficeDTO list : indexList) {
			try {
				if (officeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(officeService.getOffimgOne(list).getOffimg_name());
					indexList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		return indexList;
	}

	@RequestMapping(value = "/clustererMap.reo", method = RequestMethod.POST)
	public List<OfficeDTO> clustererMap(String clusTitle) throws IOException {
		String[] titleSplit = clusTitle.split(",");
		List<OfficeDTO> officelist = new ArrayList<OfficeDTO>();
		OfficeDTO setlist = new OfficeDTO();
		for (int i = 0; i < titleSplit.length; i++) {
			setlist.setOff_no(Integer.parseInt(titleSplit[i]));
			setlist = officeService.getOffice(setlist);
			setlist.setOff_imgs(officeService.getOffimgsname(setlist));
			officelist.add(i, setlist);
		}
		return officelist;
	}

	@RequestMapping(value = "/findDong.reo", method = RequestMethod.GET)
	public List<MapDTO> findDong(String dong) throws IOException {
		List<MapDTO> list = mapService.getSearchDong(dong);
		return list;
	}

	@RequestMapping(value = "/firstEnter.reo", method = RequestMethod.GET)
	public List<OfficeDTO> firstEnter(String keyword) throws IOException {
		OfficeDTO dto = new OfficeDTO();
		if (keyword.equals("undefined")) {
			dto.setKeyword("");
		} else {
			dto.setKeyword(keyword);
		}
		List<OfficeDTO> offlist = officeService.getOfficeListAll(dto);
		for (OfficeDTO list : offlist) {
			dto = mapService.getMapOne(list.getOff_no());
			list.setMap_dong(dto.getMap_dong());
			list.setMap_gu(dto.getMap_gu());
			list.setMap_la(dto.getMap_la());
			list.setMap_ln(dto.getMap_ln());
		}
		return offlist;
	}

	@RequestMapping(value = "/aloneMap.reo", method = RequestMethod.GET)
	public OfficeDTO aloneMap(OfficeDTO off_no) throws IOException {
		OfficeDTO dto = new OfficeDTO();
		dto = mapService.getMapOne(off_no.getOff_no());
		return dto;
	}

	@RequestMapping("/mapListFilter.reo")
	public List<OfficeDTO> getOfficeListByUnit(HttpServletRequest request, Model model,
			@RequestParam(value = "SORD", defaultValue = "desc", required = false) String sord,
			@RequestParam(value = "SIDX", defaultValue = "off_no", required = false) String sidx,
			@RequestParam(value = "offopt_name", required = false) List<String> options) {

		HashMap<String, Object> filterMap = new HashMap<String, Object>();
		OfficeDTO offDTO = new OfficeDTO();
		offDTO.setOff_type(request.getParameter("off_type"));
		int index = 0;

		List<OfficeDTO> recomdList = officeService.getRecomdList(offDTO);
		for (OfficeDTO list : recomdList) {
			try {
				if (officeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(officeService.getOffimgOne(list).getOffimg_name());
					recomdList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}

		model.addAttribute("recomdList", recomdList);

		filterMap.put("off_type", request.getParameter("off_type"));
		filterMap.put("off_unit", request.getParameter("off_unit"));
		filterMap.put("min_price", request.getParameter("min_price"));
		filterMap.put("max_price", request.getParameter("max_price"));
		filterMap.put("off_maxNum", request.getParameter("off_maxNum"));
		filterMap.put("keyword", request.getParameter("keyword"));
		filterMap.put("offopt_name", options);

		filterMap.put("SORD", sord);
		filterMap.put("SIDX", sidx);
		filterMap.put("offset", Integer.parseInt(request.getParameter("offset")));

		List<OfficeDTO> sortList = new ArrayList<OfficeDTO>();
		sortList = officeService.getOfficeListByUnit(filterMap);
		index = 0;
		OfficeDTO tempList = new OfficeDTO();
		for (OfficeDTO list : sortList) {
			try {
				if (officeService.getOffimgOne(list).getOffimg_name() != null) {
					list.setOff_image(officeService.getOffimgOne(list).getOffimg_name());
					//
					tempList = mapService.getMapOne(list.getOff_no());
					list.setMap_dong(tempList.getMap_dong());
					list.setMap_gu(tempList.getMap_gu());
					list.setMap_la(tempList.getMap_la());
					list.setMap_ln(tempList.getMap_ln());
					sortList.set(index, list);
				}
				index++;
			} catch (NullPointerException e) {
				index++;
				continue;
			}
		}
		return sortList;
	}
}