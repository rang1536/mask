package kr.or.mask.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.User;

@Repository
public class OfficeDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	//아이디 중복 체크
	public int dupIdCheck(String id){
		return sql.selectOne("office.dupIdCheck", id);
	}
	
	//회원가입
	public int registerMember(User user){
		return sql.insert("office.registerMember", user);
	}
}
