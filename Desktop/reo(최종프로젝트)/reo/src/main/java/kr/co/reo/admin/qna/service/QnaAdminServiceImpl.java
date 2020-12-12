package kr.co.reo.admin.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.reo.admin.qna.dao.QnaAdminDAO;
import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Service
public class QnaAdminServiceImpl implements QnaAdminService {

	@Inject
	private QnaAdminDAO qnaDAO;

	@Override
	public List<QnaDTO> getQnaList(SearchCriteria scri) throws Exception {
		return qnaDAO.getQnaList(scri);
	}

	@Override
	public void insertQna(QnaDTO qnaDTO) throws Exception {
		qnaDAO.insertQna(qnaDTO);
	}

	@Override
	public void updateQna(QnaDTO qnaDTO) throws Exception {
		qnaDAO.updateQna(qnaDTO);
	}

	@Override
	public void deleteQna(QnaDTO qnaDTO) throws Exception {
		qnaDAO.deleteQna(qnaDTO);
	}

	@Override
	public int getQnaListCnt(SearchCriteria scri) throws Exception {
		return qnaDAO.getQnaListCnt(scri);
	}

	@Override
	public void setAnswer(QnaDTO qna) throws Exception {
		qnaDAO.setAnswer(qna);
	}

	@Override
	public void updateAnswer(QnaDTO qna) throws Exception {
		qnaDAO.updateAnswer(qna);
	}

	@Override
	public void deleteAnswer(QnaDTO qna) throws Exception {
		qnaDAO.deleteAnswer(qna);
	}

	@Override
	public List<QnaDTO> getNoAnswerList(SearchCriteria scri) throws Exception {
		return qnaDAO.getNoAnswerList(scri);
	}

	@Override
	public int getNoAnswerListCnt(SearchCriteria scri) throws Exception {
		return qnaDAO.getNoAnswerListCnt(scri);
	}

	@Override
	public List<QnaDTO> getReportedList(SearchCriteria scri) throws Exception {
		return qnaDAO.getReportedList(scri);
	}

	@Override
	public int getReportedListCnt(SearchCriteria scri) throws Exception {
		return qnaDAO.getReportedListCnt(scri);
	}

	@Override
	public void deleteQnaSingle(int qna_no) throws Exception {
		qnaDAO.deleteQnaSingle(qna_no);
	}

}