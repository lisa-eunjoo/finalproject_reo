package kr.co.reo.client.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.reo.client.qna.dao.QnaClientDAO;
import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Service
public class QnaClientServiceimpl implements QnaClientService {

	@Inject
	private QnaClientDAO qnaDAO;

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
	public void deleteQna(int qna_no) throws Exception {
		qnaDAO.deleteQna(qna_no);
	}

	@Override
	public int getQnaListCnt(SearchCriteria scri) throws Exception {
		return qnaDAO.getQnaListCnt(scri);
	}

	@Override
	public QnaDTO checkQnaReport(QnaDTO qna) throws Exception {
		return qnaDAO.checkQnaReport(qna);
	}

	@Override
	public void insertQnaReport(QnaDTO qna) throws Exception {
		qnaDAO.insertQnaReport(qna);
	}

	@Override
	public List<QnaDTO> getNoAnswerList() throws Exception {
		return qnaDAO.getNoAnswerList();
	}

	@Override
	public List<QnaDTO> getMyQnaList(String qna_email) throws Exception {
		return qnaDAO.getMyQnaList(qna_email);
	}

	@Override
	public void updateQnaReport(QnaDTO qna) throws Exception {
		qnaDAO.updateQnaReport(qna);
	}

}
