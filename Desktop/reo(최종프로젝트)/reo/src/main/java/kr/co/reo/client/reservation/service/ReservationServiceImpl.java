package kr.co.reo.client.reservation.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.reo.client.reservation.dao.ReservationDAO;
import kr.co.reo.common.dto.ReservationDTO;
import kr.co.reo.common.util.PageUtil;

@Service("reservationService")
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDAO reservationDAO;

	@Autowired
	private PageUtil pageUtil;

	@Override
	public void makeReservation(ReservationDTO dto) {
		reservationDAO.makeReservation(dto);
	}

	@Override
	public List<ReservationDTO> getResAddList(ReservationDTO dto) {
		return reservationDAO.getResAddList(dto);
	}

	@Override
	public ReservationDTO getMyResInfo(ReservationDTO dto) {
		return reservationDAO.getMyResInfo(dto);
	}

	@Override
	public List<ReservationDTO> getAllResList(ReservationDTO dto) {
		int resCount = getResCount(dto);
		dto.setPageNo(pageUtil.ablePageNo(dto.getPageNo(), resCount));
		dto.setLIMIT(pageUtil.getLimit());
		dto.setOFFSET(pageUtil.getOffset(dto.getPageNo()));
		return reservationDAO.getAllResList(dto);
	}

	@Override
	public int updateMyResInfoUpdate(ReservationDTO dto) {
		return reservationDAO.updateMyResInfoUpdate(dto);
	}

	@Override
	public int updateMyResInfoDel(ReservationDTO dto) {
		return reservationDAO.updateMyResInfoDel(dto);
	}

	@Override
	public List<ReservationDTO> getMyResList(ReservationDTO dto) {
		int resNowCount = getResNowCount(dto);
		dto.setPageNo(pageUtil.ablePageNo(dto.getPageNo(), resNowCount));
		dto.setLIMIT(pageUtil.getLimit());
		dto.setOFFSET(pageUtil.getOffset(dto.getPageNo()));

		return reservationDAO.getMyResList(dto);
	}

	@Override
	public int getResCount(ReservationDTO dto) {
		return reservationDAO.getResCount(dto);
	}

	@Override
	public List<ReservationDTO> getResPastList(ReservationDTO dto) {
		int resPastCount = getResPastCount(dto);
		dto.setPageNo(pageUtil.ablePageNo(dto.getPageNo(), resPastCount));
		dto.setLIMIT(pageUtil.getLimit());
		dto.setOFFSET(pageUtil.getOffset(dto.getPageNo()));

		return reservationDAO.getResPastList(dto);
	}

	@Override
	public int resStateUpdate(String Pay_no) {
		return reservationDAO.resStateUpdate(Pay_no);
	}

	@Override
	public int getResNowCount(ReservationDTO dto) {
		return reservationDAO.getResNowCount(dto);
	}

	@Override
	public int getResPastCount(ReservationDTO dto) {
		return reservationDAO.getResPastCount(dto);
	}

	@Override
	public ReservationDTO getResUpdateSel(ReservationDTO dto) {
		return reservationDAO.getResUpdateSel(dto);
	}

	@Override
	public int getMaxResNo() {
		return reservationDAO.getMaxResNo();
	}

	@Override
	public List<ReservationDTO> getResMonth(ReservationDTO dto) {
		return reservationDAO.getResMonth(dto);
	}

	@Override
	public int updateAdResDel(ReservationDTO dto) {
		return reservationDAO.updateAdResDel(dto);
	}
}
