package kr.co.reo.client.reservation.dao;

import java.util.List;

import kr.co.reo.common.dto.ReservationDTO;

public interface ReservationDAO {
	void makeReservation(ReservationDTO dto);

	int resStateUpdate(String Pay_no);

	int getMaxResNo();

	List<ReservationDTO> getResAddList(ReservationDTO dto);

	List<ReservationDTO> getResMonth(ReservationDTO dto);

	List<ReservationDTO> getMyResList(ReservationDTO dto);

	List<ReservationDTO> getResPastList(ReservationDTO dto);

	int getResNowCount(ReservationDTO dto);

	int getResPastCount(ReservationDTO dto);

	ReservationDTO getMyResInfo(ReservationDTO dto);

	int updateMyResInfoDel(ReservationDTO dto);

	int updateMyResInfoUpdate(ReservationDTO dto);

	ReservationDTO getResUpdateSel(ReservationDTO dto);

	// 여기서부터 관리자
	List<ReservationDTO> getAllResList(ReservationDTO dto);

	int getResCount(ReservationDTO dto);

	int updateAdResDel(ReservationDTO dto);

}
