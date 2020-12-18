package kr.or.mask.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MaskDao {
	
	@Autowired
	private SqlSessionTemplate sql;
}
