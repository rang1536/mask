package kr.or.mask.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mask.domain.Agent;
import kr.or.mask.domain.DayClosing;
import kr.or.mask.domain.Notice;
import kr.or.mask.domain.PointHistory;
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
	
	
	
	/*
	 * 일마감
	 * */
	
	//전체회원조회
	public List<User> getAllUser(){
		return sql.selectList("mask.getAllUser");
	}
	
	//일정산데이터 생성
	public int setDayClosingTargetUser(DayClosing dc) {
		return sql.insert("mask.setDayClosingTargetUser", dc);
	}
	
	//상대에게 후원보너스 받았는지 여부 확인
	public int chkSponBonusYn(Map<String, Object> params) {
		return sql.selectOne("mask.chkSponBonusYn", params);
	}
	
	//포인트 히스토리 생성(후원보너스용)
	public int setPointHisForSponBonus(PointHistory ph) {
		return sql.insert("mask.setPointHisForSponBonus", ph);
	}
	
	//포인트 히스토리 수정(지급으로 수정)
	public int modPointHisForSponBonus(PointHistory ph) {
		return sql.insert("mask.modPointHisForSponBonus", ph);
	}
	
	//일마감조회
	public List<DayClosing> getSponBonusUserList(){
		return sql.selectList("mask.getSponBonusUserList");
	}
	
	//미지급포인트 히스토리 삭제
	public int delPointHisSponBouns() {
		return sql.delete("mask.delPointHisSponBouns");
	}
	
	//포인트수정
	public int updatePointSponBonus(User user){
		return sql.insert("mask.updatePointSponBonus", user);
	}
	
	
}
