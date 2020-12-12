package kr.co.reo.client.qna.dao;

import java.util.List;

import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

public interface QnaClientDAO {

	public List<QnaDTO> getQnaList(SearchCriteria scri) throws Exception;

	public List<QnaDTO> getMyQnaList(String qna_email) throws Exception;

	public void insertQna(QnaDTO qnaDTO) throws Exception;

	public void updateQna(QnaDTO qnaDTO) throws Exception;

	public void deleteQna(int qna_no) throws Exception;

	public int getQnaListCnt(SearchCriteria scri) throws Exception;

	public QnaDTO checkQnaReport(QnaDTO qna) throws Exception;

	public void insertQnaReport(QnaDTO qna) throws Exception;

	public List<QnaDTO> getNoAnswerList() throws Exception;

	public void updateQnaReport(QnaDTO qna) throws Exception;

}
