package kr.or.mask.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.mask.dao.MaskDao;
import kr.or.mask.dao.OfficeDao;
import kr.or.mask.domain.Agent;
import kr.or.mask.domain.ChartUser;
import kr.or.mask.domain.DayClosing;
import kr.or.mask.domain.Notice;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.User;

@Service
public class MaskService {
	@Autowired
	private MaskDao mDao;
	
	@Autowired
	private OfficeDao oDao;
	
	public Map<String, Object> loginServ(String id, String pass){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("pass", pass);
		
		User user = mDao.login(params);
		//System.out.println(user.toString());
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(user != null) {
			//System.out.println("1");
			result.put("result", "succ");		
		}else {
			//System.out.println("2");
			result.put("result", "fail");
		}
		
		return result;
	}
	
	
	//공지 총카운트 조회
	public int getNoticeCntServ() {
		return mDao.getNoticeCnt();
	}
	
	//공지 조회
	public List<Notice> getNoticeListServ(int nowPageNum){
		int startRow = ((nowPageNum*10)+1) - 10;
		
		List<Notice> noticeList = mDao.getNoticeList(startRow);
		return noticeList;
	}
	
	
	//==================================================================================================
	/* 공통 */
	//내정보조회
	public User getMyInfoServ(String id) {
		return mDao.getMyInfo(id);
	}
	
	//센터조회
	public String getUpAgentNmServ(String agentCode) {
		Agent agent = mDao.getUpAgentNm(agentCode);
		String agentNm = "noCenter";
		
		if(agent != null) {
			agentNm = agent.getName();
		}
		
		return agentNm;
	}
	
	
	/**************************************
	 * 후원조직도
	 ************************************** */
	
	//하위후원인 조회
	public List<User> getUnderTreeSponsorServ(String id){
		return mDao.getUnderTreeSponsor(id);
	}
		
	//후원조직도2
	public List<ChartUser> getSponsorList(String id, int maxLoop){
		List<User> sponList = new ArrayList<User>();
		int level = 1;
		int loopCnt = 0;
		
		//1. 최상위 내정보 세팅
		User user = getMyInfoServ(id);
		user.setAgentNm(getUpAgentNmServ(user.getAgent()));	
		user.setTreeLevel(level);
		
		sponList.add(user);
		
		//2. 후원인조회 
		List<User> underList = getUnderTreeSponsorServ(id);
		
		if(underList.size() > 0) {
			level++;
			loopCnt++; 
			for(int i=0; i< underList.size(); i++) {
				underList.get(i).setTreeLevel(level);
				underList.get(i).setAgentNm(getUpAgentNmServ(underList.get(i).getAgent()));	
				sponList.add(underList.get(i));
				
				if(maxLoop==0 || maxLoop > loopCnt) {
					//System.out.println("뤂 카운트 : "+loopCnt+", 맥스 : "+maxLoop);
					sponList = loopSponsor(underList.get(i), sponList, level, maxLoop, loopCnt);
				}else {
					System.out.println("선택한 마지막 대수~!!");
				}
				
			}
		}
		//System.out.println("최종유저확인 : "+sponList.toString());
		
		List<ChartUser> chartUserList = new ArrayList<ChartUser>();
		ChartUser cUser = null;
		for(int j=0; j<sponList.size();j++) {
			cUser = new ChartUser();
			
			cUser.setOlevel(String.valueOf(sponList.get(j).getTreeLevel()));
			cUser.setId(sponList.get(j).getTreeNo());
			cUser.setD_no(sponList.get(j).getTreeNo());
			cUser.setName(sponList.get(j).getName());
			cUser.setParentid(sponList.get(j).getParentId());
			cUser.setD_date(sponList.get(j).getRegdate().substring(0, 10));
			cUser.setD_jicname("대리점");
			cUser.setD_cename(sponList.get(j).getAgentNm());
			cUser.setD_jiccode("1");
			cUser.setPv1("0");
			cUser.setD_uid(sponList.get(j).getId());
			//cUser.setD_GRP_CD("KR");
			//cUser.setD_JICCODEP_NAME("M");
			cUser.setLeft_result("0");
			cUser.setRight_result("0");
			
			chartUserList.add(cUser);
		}
		
		//System.out.println("CHART USER : "+chartUserList);
		return chartUserList;
	}
	
	public List<User> loopSponsor(User underUser, List<User> sponList, int level, int maxLoop, int loopCnt){
		List<User> underList;	
				
		//조회된 하위 목록 세팅
		underList = getUnderTreeSponsorServ(underUser.getId());
			
		if(underList.size() > 0) {
			level++;
			loopCnt++;
			for(int i=0; i<underList.size(); i++) {
				//System.out.println("뤂 카운트 : "+loopCnt+", 맥스 : "+maxLoop);
				underList.get(i).setTreeLevel(level);
				underList.get(i).setAgentNm(getUpAgentNmServ(underList.get(i).getAgent()));
				sponList.add(underList.get(i));
				
				if(maxLoop == 0 || maxLoop > loopCnt) {
					sponList = loopSponsor(underList.get(i), sponList, level, maxLoop, loopCnt);
				}else {
					System.out.println("선택한 마지막 대수~!!");
				}
				
			}
		}else {
			System.out.println("하위 추천인 END");
		}
		
		return sponList;
	}
	
	
	
	/**************************************
	 * 추천조직도
	 ************************************** */
	
	//하위 추천인 조회
	public List<User> getUnderTreeRecommenderServ(String id){
		return mDao.getUnderTreeRecommender(id);
	}
		
	
	//추천조직도2
	public List<ChartUser> getRecommList(String id, int maxLoop){
		List<User> recommList = new ArrayList<User>();
		int level = 1;
		int loopCnt = 0;
		
		//1. 최상위 내정보 세팅
		User user = getMyInfoServ(id);
		user.setAgentNm(getUpAgentNmServ(user.getAgent()));	
		user.setTreeLevel(level);
		
		recommList.add(user);
		
		//2. 추천인조회 
		List<User> underList = getUnderTreeRecommenderServ(id);
		
		if(underList.size() > 0) {
			level++;
			loopCnt++; 
			for(int i=0; i< underList.size(); i++) {
				underList.get(i).setTreeLevel(level);
				underList.get(i).setAgentNm(getUpAgentNmServ(underList.get(i).getAgent()));	
				recommList.add(underList.get(i));
				
				if(maxLoop==0 || maxLoop > loopCnt) {
					//System.out.println("뤂 카운트 : "+loopCnt+", 맥스 : "+maxLoop);
					recommList = loopRecommender(underList.get(i), recommList, level, maxLoop, loopCnt);
				}else {
					System.out.println("선택한 마지막 대수~!!");
				}
				
			}
		}
		System.out.println("최종유저확인 : "+recommList.toString());
		
		List<ChartUser> chartUserList = new ArrayList<ChartUser>();
		ChartUser cUser = null;
		for(int j=0; j<recommList.size();j++) {
			cUser = new ChartUser();
			
			cUser.setOlevel(String.valueOf(recommList.get(j).getTreeLevel()));
			cUser.setId(recommList.get(j).getTreeNo());
			cUser.setD_no(recommList.get(j).getTreeNo());
			cUser.setName(recommList.get(j).getName());
			cUser.setParentid(recommList.get(j).getReParentId());
			cUser.setD_date(recommList.get(j).getRegdate().substring(0, 10));
			cUser.setD_jicname("대리점");
			cUser.setD_cename(recommList.get(j).getAgentNm());
			cUser.setD_jiccode("1");
			cUser.setPv1("0");
			cUser.setD_uid(recommList.get(j).getId());
			//cUser.setD_GRP_CD("KR");
			//cUser.setD_JICCODEP_NAME("M");
			cUser.setLeft_result("0");
			cUser.setRight_result("0");
			
			chartUserList.add(cUser);
		}
		
		//System.out.println("CHART USER : "+chartUserList);
		return chartUserList;
	}
	
	public List<User> loopRecommender(User underUser, List<User> recommList, int level, int maxLoop, int loopCnt){
		List<User> underList;	
				
		//조회된 하위 목록 세팅
		underList = getUnderTreeRecommenderServ(underUser.getId());
			
		if(underList.size() > 0) {
			level++;
			loopCnt++;
			for(int i=0; i<underList.size(); i++) {
				System.out.println("뤂 카운트 : "+loopCnt+", 맥스 : "+maxLoop);
				underList.get(i).setTreeLevel(level);
				underList.get(i).setAgentNm(getUpAgentNmServ(underList.get(i).getAgent()));
				recommList.add(underList.get(i));
				
				if(maxLoop == 0 || maxLoop > loopCnt) {
					recommList = loopRecommender(underList.get(i), recommList, level, maxLoop, loopCnt);
				}else {
					System.out.println("선택한 마지막 대수~!!");
				}
				
			}
		}else {
			System.out.println("하위 추천인 END");
		}
		
		return recommList;
	}
	
	
	//=======================================일정산
	
	//전체회원조회
	public List<User> getAllUserServ(){
		return mDao.getAllUser();
	}
	
	//일정산데이터 생성
	public int setDayClosingTargetUserServ(DayClosing dc) {
		return mDao.setDayClosingTargetUser(dc);
	}
	
	//일정산 
	@Transactional(rollbackFor =Exception.class)
	public Map<String, Object> dayClosingStart(){
		Map<String, Object> map = new HashMap<String, Object>();
		dayClosingMainServ(); //일마감 메인호출
		
		//마감 카운트 조회해서 정산대상자 포인트 지급 (좌,우 1 이상인 대상조회)
		List<DayClosing> cList = mDao.getSponBonusUserList();  
		
		//포인트 지급 및 히스토리반영
		if(cList.size() > 0) { 
			for(int i=0; i<cList.size(); i++) {
				int left = cList.get(i).getLeftCnt();
				int right = cList.get(i).getRightCnt();
				
				String point = getBonusPoint(left, right);
				
				//대상유저에게 포인트 지급
				User mUser = new User();
				mUser.setPoint(point);
				mUser.setId(cList.get(i).getUserId()); 
				
				mDao.updatePointSponBonus(mUser); 
				
				//포인트 히스토리 반영(미지급->지급)
				PointHistory ph = new PointHistory();
				ph.setPoint(point);
				ph.setClosingChk(2); //지급
				ph.setToId(cList.get(i).getUserId());
				
				mDao.modPointHisForSponBonus(ph);
			}
		}
		
		//지급된 포인트 히스토리 제외 후원보너스 관련 히스토리 전체 삭제
		mDao.delPointHisSponBouns();
		
		map.put("result", "success");
		return map;
	}
	
	//포인트 계산
	public String getBonusPoint(int left, int right) {
		String bonusPoint = "30000"; //1:1
		
		if(left >= 3 && right >= 3) {
			bonusPoint = "50000";
		}else if(left >= 5 && right >= 5) {
			bonusPoint = "70000";
		}else if(left >= 7 && right >= 7) {
			bonusPoint = "100000";
		}else if(left >= 10 && right >= 10) {
			bonusPoint = "200000";
		}else if(left >= 20 && right >= 20) {
			bonusPoint = "300000";
		}
				
		return bonusPoint;
	}
	
	//일정산 main
	@Transactional(rollbackFor =Exception.class)
	public void dayClosingMainServ(){
		
		//변수세팅
		DayClosing dc;
		int leftCnt = 0;
		int rightCnt = 0;
		Map<String, Object> param;
		
		List<User> userList = getAllUserServ(); //전체회원조회
		
		//회원별 일마감 자료 생성 (후원보너스)
		for(int i=0; i<userList.size(); i++) { //전체회원 루프
			leftCnt = 0;
			rightCnt = 0;
			
			//1. 하위후원인 조회
			List<User> underList = getUnderTreeSponsorServ(userList.get(i).getId());
			
			//2. 카운팅	
			// 최초 카운팅은 최상위의 바로 아래 트리이므로 리스트의 첫번째는 leftCnt++, 두번째는 rightCnt++ 
			if(underList.size() >= 1) {
				param = new HashMap<String, Object>();
				param.put("fromId", underList.get(0).getId());
				param.put("toId", userList.get(i).getId());
			    
				if(mDao.chkSponBonusYn(param) == 0) { //후원보너스 지급이력이 없을때 ++
					leftCnt++;
					
					//포인트 히스토리입력
					setPointHisForSponBonus(underList.get(0).getId(), userList.get(i).getId());
					
					//leftCnt 루프시작~
					leftCnt = getSponCntLoop(leftCnt, underList.get(0));				
				}	
				
				if(underList.size() == 2){
					param = new HashMap<String, Object>();
					param.put("fromId", underList.get(1).getId());
					param.put("toId", userList.get(i).getId());
					
					if(mDao.chkSponBonusYn(param) == 0) { //후원보너스 지급이력이 없을때 ++
						rightCnt++;
						
						//포인트 히스토리입력 (String fromId, String toId)
						setPointHisForSponBonus(underList.get(1).getId(), userList.get(i).getId());
						
						//rightCnt 루프시작~
						rightCnt = getSponCntLoop(rightCnt, underList.get(1));
					}	
				}	
			}	
			
			// 3. 후원인 카운팅이 끝났으면 일마감 데이터 생성
			dc = new DayClosing();
			dc.setUserId(userList.get(i).getId());
			dc.setLeftCnt(leftCnt);
			dc.setRightCnt(rightCnt);
			dc.setState("1");
			//포인트는 정산하고 타입별로 업데이트 해야함.
			

			System.out.println(i+" 번째 일마감데이터 확인"+dc);
			mDao.setDayClosingTargetUser(dc);		

		}
		
	}
	

	//트리 좌 혹은 우측 카운팅 루프
	public int getSponCntLoop(int cnt, User user ) {
		Map<String, Object> map = new HashMap<String, Object>(); //leftCnt, rightCnt 리턴용
		Map<String, Object> param;
		
		List<User> underList = getUnderTreeSponsorServ(user.getId());
		
		//2. 카운팅
		if(underList.size() >= 1) {
			param = new HashMap<String, Object>();
			param.put("fromId", underList.get(0).getId());
			param.put("toId", user.getId());
		    
			if(mDao.chkSponBonusYn(param) == 0) { //후원보너스 지급이력이 없을때 ++
				cnt++;
				cnt = getSponCntLoop(cnt, underList.get(0));
			}	
			
			if(underList.size() == 2){
				param = new HashMap<String, Object>();
				param.put("fromId", underList.get(1).getId());
				param.put("toId", user.getId());
				
				if(mDao.chkSponBonusYn(param) == 0) { //후원보너스 지급이력이 없을때 ++
					cnt++;
					cnt = getSponCntLoop(cnt, underList.get(1));
				}	
			}
		}	
		System.out.println("마지막 후원인~!!");
		return cnt;

	}
	
	//포인트히스토리 입력
	public int setPointHisForSponBonus(String fromId, String toId) {
		PointHistory ph = new PointHistory();
		ph.setType("09");
		ph.setFromId(fromId);
		ph.setToId(toId);
		
		return mDao.setPointHisForSponBonus(ph);
	}
}


