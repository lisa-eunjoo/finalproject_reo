package kr.co.reo.client.reservation.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.client.reservation.dao.ReservationDAO;
import kr.co.reo.common.dto.ReservationDTO;

@Repository
public class ReservationDAOImpl implements ReservationDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void makeReservation(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		mapper.makeReservation(dto);
	}

	public List<ReservationDTO> getResAddList(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResAddList(dto);
	}

	public ReservationDTO getMyResInfo(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getMyResInfo(dto);
	}

	// 관리자 예약 리스트 현황 보기
	public List<ReservationDTO> getAllResList(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getAllResList(dto);
	}

	// 내 예약 수정하기
	@Override
	public int updateMyResInfoUpdate(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.updateMyResInfoUpdate(dto);
	}

	// 내 예약 취소하기
	@Override
	public int updateMyResInfoDel(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.updateMyResInfoDel(dto);
	}

	// 내 예약 리스트 보기
	@Override
	public List<ReservationDTO> getMyResList(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getMyResList(dto);
	}

	// 예약 현황 (레코드 갯수)
	@Override
	public int getResCount(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResCount(dto);
	}

	// 지난 예약 리스트
	@Override
	public List<ReservationDTO> getResPastList(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResPastList(dto);
	}

	// 예약 상태 변경
	@Override
	public int resStateUpdate(String Pay_no) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.resStateUpdate(Pay_no);
	}

	@Override
	public int getResNowCount(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResNowCount(dto);
	}

	@Override
	public int getResPastCount(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResPastCount(dto);
	}

	@Override
	public ReservationDTO getResUpdateSel(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResUpdateSel(dto);
	}

	// 예약 최신 번호 가져오기
	@Override
	public int getMaxResNo() {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getMaxResNo();
	}

	@Override
	public List<ReservationDTO> getResMonth(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.getResMonth(dto);
	}

	@Override
	public int updateAdResDel(ReservationDTO dto) {
		ReservationDAO mapper = mybatis.getMapper(ReservationDAO.class);
		return mapper.updateAdResDel(dto);
	}
}
