package kr.or.mask.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.User;

@Repository
public class MaskDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	//LOGIN
	public User login(Map<String, Object> params) {
		return sql.selectOne("mask.login", params);
	}
}
