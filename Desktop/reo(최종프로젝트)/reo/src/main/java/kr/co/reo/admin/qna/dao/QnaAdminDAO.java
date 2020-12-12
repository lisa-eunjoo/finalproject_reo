package kr.co.reo.admin.qna.dao;

import java.util.List;

import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

public interface QnaAdminDAO {

	public List<QnaDTO> getQnaList(SearchCriteria scri) throws Exception;

	public void insertQna(QnaDTO qnaDTO) throws Exception;

	public void updateQna(QnaDTO qnaDTO) throws Exception;

	public void deleteQna(QnaDTO qnaDTO) throws Exception;

	public int getQnaListCnt(SearchCriteria scri) throws Exception;

	public void setAnswer(QnaDTO qna) throws Exception;

	public void updateAnswer(QnaDTO qna) throws Exception;

	public void deleteAnswer(QnaDTO qna) throws Exception;

	public List<QnaDTO> getNoAnswerList(SearchCriteria scri) throws Exception;

	public int getNoAnswerListCnt(SearchCriteria scri) throws Exception;

	public List<QnaDTO> getReportedList(SearchCriteria scri) throws Exception;

	public int getReportedListCnt(SearchCriteria scri) throws Exception;

	public void deleteQnaSingle(int qna_no) throws Exception;

}