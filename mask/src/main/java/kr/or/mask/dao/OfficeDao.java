package kr.or.mask.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.Agent;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.User;

@Repository
public class OfficeDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	//유저정보
	public User getUser(String id){
		return sql.selectOne("office.getUser", id);
	}
	
	//아이디 중복 체크
	public int dupIdCheck(String id){
		return sql.selectOne("office.dupIdCheck", id);
	}
	
	//비밀번호 체크
	public int getPass(User user){
		return sql.selectOne("office.getPass", user);
	}
	
	//회원가입
	public int registerMember(User user){
		return sql.insert("office.registerMember", user);
	}
	
	//회원가입
	public int insertPointHistory(PointHistory ph){
		return sql.insert("office.insertPointHistory", ph);
	}
	
	//회원정보수정
	public int updateMember(User user){
		return sql.insert("office.updateMember", user);
	}
	
	//포인트수정
	public int updatePoint(User user){
		return sql.insert("office.updatePoint", user);
	}
	
	//회원리스트
	public List<User> selectMember(String searchWord){
		return sql.selectList("office.selectMember", searchWord);
	}
	
	//대리점리스트
	public List<Agent> selectAgent(String searchWord){
		return sql.selectList("office.selectAgent", searchWord);
	}
}
