package kr.co.reo.admin.qna.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Repository
public class QnaAdminDAOImpl implements QnaAdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<QnaDTO> getQnaList(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getQnaList(scri);
	}

	@Override
	public void insertQna(QnaDTO qnaDTO) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.insertQna(qnaDTO);
	}

	@Override
	public void updateQna(QnaDTO qnaDTO) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.updateQna(qnaDTO);
	}

	@Override
	public void deleteQna(QnaDTO qnaDTO) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.deleteQna(qnaDTO);
	}

	@Override
	public int getQnaListCnt(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getQnaListCnt(scri);
	}

	@Override
	public void setAnswer(QnaDTO qna) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.setAnswer(qna);
	}

	@Override
	public void updateAnswer(QnaDTO qna) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.updateAnswer(qna);
	}

	@Override
	public void deleteAnswer(QnaDTO qna) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.deleteAnswer(qna);
	}

	@Override
	public List<QnaDTO> getNoAnswerList(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getNoAnswerList(scri);
	}

	@Override
	public int getNoAnswerListCnt(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getNoAnswerListCnt(scri);
	}

	@Override
	public List<QnaDTO> getReportedList(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getReportedList(scri);
	}

	@Override
	public int getReportedListCnt(SearchCriteria scri) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		return mapper.getReportedListCnt(scri);
	}

	@Override
	public void deleteQnaSingle(int qna_no) throws Exception {
		QnaAdminDAO mapper = sqlSessionTemplate.getMapper(QnaAdminDAO.class);
		mapper.deleteQnaSingle(qna_no);
	}

}