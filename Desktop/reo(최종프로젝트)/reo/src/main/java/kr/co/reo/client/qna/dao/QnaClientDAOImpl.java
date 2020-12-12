package kr.co.reo.client.qna.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.reo.common.dto.QnaDTO;
import kr.co.reo.common.dto.SearchCriteria;

@Repository
public class QnaClientDAOImpl implements QnaClientDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<QnaDTO> getQnaList(SearchCriteria scri) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		return mapper.getQnaList(scri);
	}

	@Override
	public void insertQna(QnaDTO qnaDTO) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		mapper.insertQna(qnaDTO);
	}

	@Override
	public void updateQna(QnaDTO qnaDTO) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		mapper.updateQna(qnaDTO);
	}

	@Override
	public void deleteQna(int qna_no) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		mapper.deleteQna(qna_no);
	}

	@Override
	public int getQnaListCnt(SearchCriteria scri) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		return mapper.getQnaListCnt(scri);
	}

	@Override
	public QnaDTO checkQnaReport(QnaDTO qna) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		return mapper.checkQnaReport(qna);
	}

	@Override
	public void insertQnaReport(QnaDTO qna) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		mapper.insertQnaReport(qna);
	}

	@Override
	public List<QnaDTO> getNoAnswerList() throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		return mapper.getNoAnswerList();
	}

	@Override
	public List<QnaDTO> getMyQnaList(String qna_email) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		return mapper.getMyQnaList(qna_email);
	}

	@Override
	public void updateQnaReport(QnaDTO qna) throws Exception {
		QnaClientDAO mapper = sqlSessionTemplate.getMapper(QnaClientDAO.class);
		mapper.updateQnaReport(qna);
	}

}
