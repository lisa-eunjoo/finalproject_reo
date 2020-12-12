package kr.co.reo.client.member.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import com.mongodb.WriteResult;

import kr.co.reo.common.dto.AuthorityDTO;
import kr.co.reo.common.dto.LoginLogDTO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.SnsDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		mapper.insertMember(dto);
	}

	@Override
	public int updateMember(MemberDTO dto) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.updateMember(dto);
	}

	@Override
	public void deleteMember(String mem_email) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		mapper.deleteMember(mem_email);
	}

	@Override
	public SnsDTO getLoginSns(SnsDTO dto) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.getLoginSns(dto);
	}

	@Override
	public String checkEmail(String mem_email) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.checkEmail(mem_email);
	}

	@Override
	public MemberDTO checkLoginEmail(String mem_email) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.checkLoginEmail(mem_email);
	}

	@Override
	public int updatePass(MemberDTO dto) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.updatePass(dto);
	}

	@Override
	public int insertLoginLog(LoginLogDTO loginLogDTO) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.insertLoginLog(loginLogDTO);
	}

	@Override
	public MemberDTO qrScan(String mem_email) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.qrScan(mem_email);
	}

	@Override
	public int insertAuth(AuthorityDTO authorityDTO) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.insertAuth(authorityDTO);
	}

	@Override
	public int deleteAuth(String mem_email) throws Exception {
		MemberDAO mapper = sqlSessionTemplate.getMapper(MemberDAO.class);
		return mapper.deleteAuth(mem_email);
	}

	@Override
	public void mongoEmailCheckInsert(Map<String, Object> map) throws Exception {
		mongoTemplate.insert(map, "emailCheck");
	}

	@Override
	public List<Map<String, Object>> mongoEmailCheck(Map<String, Object> map) throws Exception {
		return null;
	}

	@Override
	public int mongoEmailCheckDelete(Map<String, Object> map) throws Exception {
		WriteResult deleteCount = mongoTemplate.remove(map, "emailCheck");
		return deleteCount.getN();
	}
}
