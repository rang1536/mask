package kr.or.mask.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.Agent;
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
	
	
	
	/********************************************************
	 * 조직도
	 ******************************************************** */
	
	/* 공통 */
	// 내정보 조회 
	public User getMyInfo(String id) {
		return sql.selectOne("mask.getMyInfo", id);
	}
	
	
	// 센터조회
	public Agent getUpAgentNm(String agent) {
		return sql.selectOne("mask.getUpAgentNm", agent);
	}
	
	
	/* 후원인 */
	// 하위후원인조회
	public List<User> getUnderTreeSponsor(String id){
		return sql.selectList("mask.getUnderTreeSponsor", id);
	}
	
	/* 추천인 */
	// 하위 추천인 조회
	public List<User> getUnderTreeRecommender(String id){
		return sql.selectList("mask.getUnderTreeRecommender", id);
	}
	
}
