package kr.or.mask.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mask.dao.MaskDao;
import kr.or.mask.domain.Agent;
import kr.or.mask.domain.ChartUser;
import kr.or.mask.domain.Notice;
import kr.or.mask.domain.User;

@Service
public class MaskService {
	@Autowired
	private MaskDao mDao;
	
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
	
	//후원조직도
	public User getSponsorTree(String id, int maxLoop) {
		int loopCnt = 0;
		
		//1. 최상위 내정보 세팅
		User user = getMyInfoServ(id);
		user.setAgentNm(getUpAgentNmServ(user.getAgent()));
				
		//2. 하위 후원인 세팅
		List<User> underList = getUnderTreeSponsorServ(id);
		User returnUser = getUnderTreeSponsor(underList, user, loopCnt, maxLoop);	
		
		System.out.println("후원인 트리 : "+returnUser.toString());
		return returnUser;
	}
	
	//하위후원인 조회
	public List<User> getUnderTreeSponsorServ(String id){
		return mDao.getUnderTreeSponsor(id);
	}
		
	//하위의 하위 후원인 조회
	public User getUnderTreeSponsor(List<User> underList, User user, int loopCnt, int maxLoop){
		List<User> underList2;		
		loopCnt++;
		
		if(underList.size() > 0) {
			//조회된 하위 목록 세팅
			user.setUserList(underList);
			
			for(int i=0; i < underList.size(); i++) {
				//센터명 추가
				user.getUserList().get(i).setAgentNm(getUpAgentNmServ(user.getUserList().get(i).getAgent()));
				
				//하위 목록 조회
				underList2 = new ArrayList<User>();
				underList2 = getUnderTreeSponsorServ(underList.get(i).getId());
				
				//하위 후원인 조회된 대상이 같지 않을때 하위 목록에 추가
				if(!getUnderTreeSponsor(underList2, user.getUserList().get(i), loopCnt, maxLoop).getId().equals(underList.get(i).getId())) {
					//개별 대 입력시 반복세팅 제한
					if(maxLoop > 0 && loopCnt < maxLoop) { //maxLoop 0 은 전체조회
						user.getUserList().add(getUnderTreeSponsor(underList2, user.getUserList().get(i), loopCnt, maxLoop));
					}else if(maxLoop == 0) {
						user.getUserList().add(getUnderTreeSponsor(underList2, user.getUserList().get(i), loopCnt, maxLoop));
					}
					
				}				
				
			}
		}else {
			System.out.println("하위 후원인 END");
		}
		
		return user;
	}
	
	
	
	/**************************************
	 * 추천조직도
	 ************************************** */
	//추천조직도
	public User getRecommenderTree(String id, int maxLoop) {
		//1. 최상위 내정보 세팅
		User user = getMyInfoServ(id);
		user.setAgentNm(getUpAgentNmServ(user.getAgent()));
		
		User returnUser = null;
		int loopCnt = 0;
		
		//2. 하위 후원인 세팅
		List<User> underList = getUnderTreeRecommenderServ(id);
		returnUser = getUnderTreeRecommender(underList, user, loopCnt, maxLoop);	
		
		
		System.out.println("전체 추천인 트리 : "+returnUser.toString());
		
		return returnUser;
	}
	
	//하위 추천인 조회
	public List<User> getUnderTreeRecommenderServ(String id){
		return mDao.getUnderTreeRecommender(id);
	}
		
	//하위의 하위 추천인 조회
	public User getUnderTreeRecommender(List<User> underList, User user, int loopCnt, int maxLoop){
		List<User> underList2;	
		loopCnt++;
		
		if(underList.size() > 0) {
			//조회된 하위 목록 세팅
			user.setUserList(underList);
			
			for(int i=0; i < underList.size(); i++) {
				//센터명 추가
				user.getUserList().get(i).setAgentNm(getUpAgentNmServ(user.getUserList().get(i).getAgent()));
				
				//하위 목록 조회
				underList2 = new ArrayList<User>();
				underList2 = getUnderTreeRecommenderServ(underList.get(i).getId());
				
				//하위 후원인 조회된 대상이 같지 않을때 하위 목록에 추가
				if(!getUnderTreeRecommender(underList2, user.getUserList().get(i), loopCnt, maxLoop).getId().equals(underList.get(i).getId())) {
					
					//개별 대 입력시 반복세팅 제한
					if(maxLoop > 0 && loopCnt < maxLoop) { //maxLoop 0 은 전체조회
						user.getUserList().add(getUnderTreeRecommender(underList2, user.getUserList().get(i), loopCnt, maxLoop));
					}else if(maxLoop == 0) {
						user.getUserList().add(getUnderTreeRecommender(underList2, user.getUserList().get(i), loopCnt, maxLoop));
					}				
				}				
				
			}
		}else {
			System.out.println("하위 추천인 END");
		}
		
		return user;
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
				System.out.println("뤂 카운트 : "+loopCnt+", 맥스 : "+maxLoop);
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
	
	
}


