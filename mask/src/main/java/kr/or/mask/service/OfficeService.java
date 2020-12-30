package kr.or.mask.service;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.or.mask.dao.MaskDao;
import kr.or.mask.dao.OfficeDao;
import kr.or.mask.domain.Agent;
import kr.or.mask.domain.Charge;
import kr.or.mask.domain.DayClosing;
import kr.or.mask.domain.Exchanges;
import kr.or.mask.domain.Goods;
import kr.or.mask.domain.Inquiry;
import kr.or.mask.domain.Notice;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.Purchase;
import kr.or.mask.domain.RoleHistory;
import kr.or.mask.domain.User;
import kr.or.mask.util.ExcelRead;
import kr.or.mask.util.ReadOption;

@Service
public class OfficeService {
	
	@Autowired
	private OfficeDao officeDao;
	
	@Autowired
	private MaskDao mDao;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	//유저조회
	public User getUser(String userId){
		return officeDao.getUser(userId);
	}

	//유저조회
	public List<User> selectSponList(String id){
		return officeDao.selectSponList(id);
	}
	
	//중복아이디조회
	public int dupIdCheck(String userId){
		return officeDao.dupIdCheck(userId);
	}
	
	//배송유형별 건수조회
	public int getDeliveryTypeCnt(Purchase purchase){
		return officeDao.getDeliveryTypeCnt(purchase);
	}

	//중복아이디조회
	public int getPass(User user){
		return officeDao.getPass(user);
	}
	
	//유저등록
	//트랜잭션 처리
	@Transactional(rollbackFor =Exception.class)
	public int registerMember(String id, User user){
		int result = officeDao.registerMember(id, user);
		
		if(result == 1) {
			/*
			 * 추천후원롤업 및 히스토리 저장
			 * 아 ㅅㅂ 이거 재구매네.. ㅈ됌..ㅋㅋ
			 * */
			
			// 1. 후원롤업대상 조회(20대 - 50p)
			/*
			List<User> upSponList = new ArrayList<User>(); 
			upSponList.add(user); //본인포함 20대
			String sponId = user.getSponsor(); // 가입자의 후원인 아이디 확인
			for(int i=0; i<19; i++) { //본인포함이므로
				User upUser = officeDao.getSponAndRecommTarget(sponId);
				
				if(upUser != null) { 
					upSponList.add(upUser);
					sponId = upUser.getSponsor(); //조회된 상위 대 후원인의 후원인아이디를 세팅
				}else {
					break; //상위 후원인이 없으면 루프 종료
				}
				
			}
			
			// 2. 추천롤업대상 조회(30대 - 100p)
			List<User> upRecommList = new ArrayList<User>(); 
			upRecommList.add(user); //본인포함 30대
			String recommId = user.getRecommender(); // 가입자의 추천인 아이디 확인
			for(int i=0; i<28; i++) {
				User upUser = officeDao.getSponAndRecommTarget(recommId); 
				
				if(upUser != null) {
					upRecommList.add(upUser);
					recommId = upUser.getRecommender(); //조회된 상위 대 추천인의 추천인아이디를 세팅
				}else {
					break;
				}
				
			}
			
			// 3. 후원추천롤업 저장
			DayClosing dc;
			RoleHistory rh;
				
			// 3.1 후원
			for(int i=0; i<upSponList.size();i++) {
				rh = new RoleHistory();
				rh.setAmt(50); // 후원 50p
				rh.setFromId(user.getId());
				rh.setToId(upSponList.get(i).getId());
				rh.setStatus(1); // 미지급
				rh.setType(2); // 1.추천롤업, 2.후원롤업
				
				officeDao.setSponAndRecommRoleHistory(rh);
			}
			
			// 3.2 추천
			for(int i=0; i<upRecommList.size();i++) {
				rh = new RoleHistory();
				rh.setAmt(100); // 후원 50p
				rh.setFromId(user.getId());
				rh.setToId(upRecommList.get(i).getId());
				rh.setStatus(1); // 미지급
				rh.setType(1); // 1.추천롤업, 2.후원롤업
				
				officeDao.setSponAndRecommRoleHistory(rh);
			}
				
			//=====  4. 좌우카운트 및 추천카운트 반영
			
			//4.1 후원
			//흠. 후원은 이렇게 해서는 유저수 많으면 끝이 없을듯.. 정산시 조회해서 카운트 하던지 다른방식으로 해야 할듯.
			/*
			int myCnt = officeDao.getUnderSponCnt(upSponList.get(1).getId());
			dc = new DayClosing();
			
			dc.setUserId(upSponList.get(1).getId());
			dc.setRecommCnt(0);
			
			if(myCnt ==0) { // left++
				dc.setLeftCnt(1);
				dc.setRightCnt(0);
			}else if(myCnt == 1){ //right++
				dc.setLeftCnt(0);
				dc.setRightCnt(1);
			}
			officeDao.modDayClosing(dc);
			*/
			
		}
		
		return result;
	}
	
	
	//상품등록
	public int registerGoods(Goods goods){
		return officeDao.registerGoods(goods);
	}

	//상품등록
	public int registerPurchase(String id, Purchase purchase){
		return officeDao.registerPurchase(id, purchase);
	}
	
	//포인트 이력 등록
	public int insertPointHistory(PointHistory ph){
		return officeDao.insertPointHistory(ph);
	}
	
	//유저수정
	public int updateMember(User user){
		return officeDao.updateMember(user);
	}
	
	//포인트 수정
	public int updatePoint(User user){
		return officeDao.updatePoint(user);
	}
	
	//유저검색
	public Map<String, Object> selectMember(String searchWord){
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<User> userList = officeDao.selectMember(searchWord);
		//System.out.println("조회된 유저 확인 : "+userList);
		
		
		map.put("list", userList);
		
		/*if(userList.size() == 1){
			map.put("result", "succ");
			userList.get(0).setAgentNm(mDao.getUpAgentNm(userList.get(0).getAgent()).getName());
			map.put("user", userList.get(0));
		}else {
			map.put("result", "fail");
		}*/
		
		return map;
	}
	
	//유저검색
	public List<Purchase> searchPurchase(Purchase purchase){
		return officeDao.searchPurchase(purchase);
	}
	
	//센터목록
	public List<Agent> selectAgent(String searchWord){
		return officeDao.selectAgent(searchWord);
	}

	//센터승인대기 대리점 목록
	public List<Agent> selectStandByAgent(){
		return officeDao.selectStandByAgent();
	}
		
	//후원인목록
	public List<Agent> selectSponsor(String searchWord){
		return officeDao.selectSponsor(searchWord);
	}
	
	//상품목록
	public List<Goods> selectGoods(Goods goods){
		return officeDao.selectGoods(goods);
	}
	
	//포인트내역
	public List<PointHistory> selectPointHistory(PointHistory pointHistory){
		return officeDao.selectPointHistory(pointHistory);
	}
	
	//포인트등록
	public int registerPoint(PointHistory pointHistory){
		return officeDao.registerPoint(pointHistory);
	}
	
	//관리자조회
	public String selectAdmin(String grade){
		return officeDao.selectAdmin(grade);
	}
	
	//출금처리
	public int exchange(Exchanges exchanges){
		return officeDao.exhcange(exchanges);
	}

	//충전신청
	public int charge(Charge charge){
		return officeDao.charge(charge);
	}
	
	//충전신청
	public int trans(PointHistory pointHistory){
		return officeDao.trans(pointHistory);
	}
	
	//충전신청대기건수
	public int requestChargeCnt(){
		return officeDao.requestChargeCnt();
	}
	
	//충전신청목록
	public List<Charge> selectChargeList(){
		return officeDao.selectChargeList();
	}
	
	//충전신청승인
	public int approveCharge(Charge charge){
		return officeDao.approveCharge(charge);
	}
	
	//문의하기목록
	public List<Inquiry> selectInquiry(String id){
		return officeDao.selectInquiry(id);
	}
	
	//문의사항 등록
	public int registerInquiry(Inquiry inquiry){
		return officeDao.registerInquiry(inquiry);
	}
	
	//문의사항 답변등록
	public int registerAnswer(Inquiry inquiry){
		return officeDao.registerAnswer(inquiry);
	}
	
	//센터등록
	@Transactional(rollbackFor =Exception.class)
	public int registerAgent(Agent agent){
		int a = officeDao.registerAgent(agent);
		User user = new User();
		user.setId(agent.getOwner());
		user.setAgentYn("Y");
		user.setModid(agent.getModid());
		int b = officeDao.gradeUpMember(user);
		
		return a+b;
	}
	
	//구매내역
	public List<Purchase> selectPurchaseList(String id){
		return officeDao.selectPurchaseList(id);
	}
	
	public Map<String, Object> uploadPurchase(String id , File destFile) {

		ReadOption readOption = new ReadOption();
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A","B","C","D","E");
		readOption.setStartRow(2);
		  
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		  
		Purchase purchase = null;
		Map<String, Object> map = new HashMap<String, Object>();
		for(Map<String, String> article : excelContent){

			purchase = new Purchase();
			purchase.setModid(id);
			purchase.setCode(article.get("A"));
			purchase.setReceiveName(article.get("B")); 
			purchase.setReceivePhone(article.get("C"));
			purchase.setDeliveryCompany(article.get("D"));
			purchase.setDeliveryCode(article.get("E"));

			int result = officeDao.uploadPurchase(purchase);
			
			if(result == 1) {
				System.out.println("excel insert Success~!!");
				map.put("result", "success");
				map.put("message", "등록되었습니다.");
			}else {
				map.put("result", "error");
				map.put("message", "등록에 실패하였습니다.");				
			}
		}
		return map;
	}
	
	//공지사항 목록
	public List<Notice> selectNoticeList(){
		return officeDao.selectNoticeList();
	}
	
}
