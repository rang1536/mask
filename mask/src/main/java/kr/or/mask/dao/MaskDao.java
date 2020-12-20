package kr.or.mask.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.Notice;
import kr.or.mask.domain.User;

@Repository
public class MaskDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	//LOGIN
	public User login(Map<String, Object> params) {
		return sql.selectOne("mask.login", params);
	}
	
	//공지총카운트조회
	public int getNoticeCnt() {
		return sql.selectOne("mask.getNoticeCnt");
	}
	
	//공지글 조회
	public List<Notice> getNoticeList(int startRow){
		return sql.selectList("mask.getNoticeList", startRow);
	}
}
