package kr.or.mask.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

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

@Repository
public class OfficeDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	//유저정보
	public User getUser(String id){
		return sql.selectOne("office.getUser", id);
	}

	//유저정보
	public Agent getAgent(String code){
		return sql.selectOne("office.getAgent", code);
	}
	
	//후원인목록
	public List<User> selectSponList(String id){
		return sql.selectList("office.selectSponList", id);
	}
	
	//후원인목록
	public List<Purchase> searchPurchase(Purchase purchase){
		return sql.selectList("office.searchPurchase", purchase);
	}
	
	//아이디 중복 체크
	public int dupIdCheck(String id){
		return sql.selectOne("office.dupIdCheck", id);
	}
	
	//배송유형별 건수조회
	public int getDeliveryTypeCnt(Purchase purchase){
		return sql.selectOne("office.getDeliveryTypeCnt", purchase);
	}
	
	//비밀번호 체크
	public int getPass(User user){
		return sql.selectOne("office.getPass", user);
	}
	
	//회원가입
	public int registerMember(String id, User user){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("registerMember-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {

			String grade = "SE01MASK";
			String admin = sql.selectOne("office.selectAdmin",grade);
			
			//회원 등록
			user.setGrade("1");
			sql.insert("office.registerMember", user);
			
			//윤. 마감테이블에 가입회원 등록
			sql.insert("office.setDayClosing", user);

			//포인트 이력 테이블 등록
			PointHistory ph = new PointHistory();
			ph.setId(user.getId());
			ph.setType("02");
			ph.setMessage("신규회원가입");
			ph.setPoint(user.getBuyPoint());
			ph.setFromId(id);
			ph.setToId(admin);
			registerPoint(ph);
			
			//회원가입을 진행한 유저의 포인트 차감
			User mUser = new User();
			mUser.setPoint("-"+user.getBuyPoint());
			mUser.setId(id);
			updatePoint(mUser);
			
			//차감된 유저의 포인트를 관리자에게 부여
			mUser.setPoint(user.getBuyPoint());
			mUser.setId(admin);
			updatePoint(mUser);
			
			//주문코드 생성
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			String code = "";
			String preCode = sdf.format(today);
			String maxCode = sql.selectOne("office.selectMaxOrderCode",preCode);

			if(maxCode == null) {
				code = preCode+"00001";
			}else {
				code = maxCode;
			}
			
			//주문테이블 등록
			Purchase pc = new Purchase();
			pc.setCode(code);
			pc.setGoodsCode(user.getGoodsCode());
			pc.setGoodsName(user.getGoodsName());
			pc.setPoint(user.getBuyPoint());
			pc.setStatus("01");
			pc.setType("01");
			pc.setDeliveryZipcode(user.getDeliveryZipcode());
			pc.setDeliveryAddr1(user.getDeliveryAddr1());
			pc.setDeliveryAddr2(user.getDeliveryAddr2());
			pc.setRegid(id);
			insertPurchase(pc);
			
			
			//센터 포인트 지급
			Agent agent = getAgent(user.getAgent()); // 가입센터조회
			List<User> upCenList = new ArrayList<User>();
			User user2 = getUser(agent.getOwner()); //가입된 센터의 소유자(대리점) 정보 조회
			upCenList.add(user2); //1대(가입시 선택한) 센터
			String recommId = user2.getRecommender();
			int i = 0;

			while(true) {
				User upUser = getSponAndRecommTarget(recommId);
				if(upUser == null) { // 상위 추천인이 없으면 루프종료
					break;
				}else {
					recommId = upUser.getRecommender();
				}
				
				if(upUser.getAgentYn().equals("Y")) { // 상위 추천인이 센터라면 리스트에 애드한 후 카운트 업
					upCenList.add(upUser);
					i++;
				}
				if(i == 2) { // 상위 추천인 2명 구하면 루프 종료
					break;
				}
			}
			
			for(i=0; i<upCenList.size();i++) {
				String point = "";
				if(i == 0) point = "4000";
				else point = "500";
				
				ph = new PointHistory();
				ph.setId("BATCH");
				ph.setType("10");
				ph.setPoint(point);
				ph.setMessage("센터회원가입롤업 "+(i+1)+"대");
				ph.setFromId(user.getId());
				ph.setToId(upCenList.get(i).getId());
				registerPoint(ph);
				
				User us = new User();
				us.setId(upCenList.get(i).getId());
				us.setPoint(point);
				updatePoint(us);
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			throw e;
		}

		transactionManager.commit(status);
		return 1;
	}
	
	//후원, 추천롤업대상 조회
	public User getSponAndRecommTarget(String id){
		return sql.selectOne("office.getSponAndRecommTarget", id);
	}
	
	//후원, 추천롤업대상 포인트 히스토리 입력
	public int setSponAndRecommRoleHistory(RoleHistory roleHistory) {
		return sql.insert("office.setSponAndRecommRoleHistory", roleHistory);
	}
	
	//주문등록
	public int registerPurchase(String id, Purchase purchase) {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("registerMember-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {

			//관리자 ID 얻어오기
			String grade = "SE01MASK";
			String admin = sql.selectOne("office.selectAdmin",grade);
			
			String msg = "";
			if(purchase.getType().equals("04")) {
				msg = "회원가입";
			}else if(purchase.getType().equals("05")) {
				msg = "재구매";
				
			}else if(purchase.getType().equals("06")) {
				msg = "소비자구매";
			}
			
			//포인트 이력 테이블 등록
			PointHistory ph = new PointHistory();
			ph.setId(id);
			ph.setType(purchase.getType());
			ph.setMessage(msg);
			ph.setPoint(purchase.getPoint());
			ph.setFromId(id);
			ph.setToId(admin);
			registerPoint(ph);
			
			//재구매를 진행한 유저의 포인트 차감
			User mUser = new User();
			mUser.setPoint("-"+purchase.getPoint());
			mUser.setId(id);
			updatePoint(mUser);
			
			//재구매를 진행한 유저는 대리점 만료일 한달 연장
			if(purchase.getType().equals("05") || purchase.getType().equals("06")) {
				updateExpire(mUser);
			}
			
			//차감된 유저의 포인트를 관리자에게 부여
			mUser.setPoint(purchase.getPoint());
			mUser.setId(admin);
			updatePoint(mUser);
			
			//소비자구매 시 소매마진(소비자구매가-회원가)을 payback 해줌
			if(purchase.getType().equals("06")) {
				Goods sGoods = new Goods();
				sGoods.setGoodsCode(purchase.getGoodsCode());
				Goods cGoods = getGoods(sGoods);
				
			    String mPrice = cGoods.getRePrice();
			    String cPrice = cGoods.getCustomerPrice();
			     
			    int payBack = Integer.parseInt(cPrice) - Integer.parseInt(mPrice);
			    String payBackString = payBack+"";
			    
				//포인트 이력 테이블 등록
				ph = new PointHistory();
				ph.setId(id);
				ph.setType("09");
				ph.setMessage("소매마진");
				ph.setPoint(payBackString);
				ph.setFromId(admin);
				ph.setToId(id);
				registerPoint(ph);
				
				mUser.setPoint("-"+payBackString);
				mUser.setId(admin);
				updatePoint(mUser);
				
				mUser.setPoint(payBackString);
				mUser.setId(id);
				updatePoint(mUser);
			}
			
			//주문코드 생성
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			String code = "";
			String preCode = sdf.format(today);
			String maxCode = sql.selectOne("office.selectMaxOrderCode",preCode);

			if(maxCode == null) {
				code = preCode+"00001";
			}else {
				code = maxCode;
			}
			
			//주문테이블 등록
			purchase.setCode(code);
			purchase.setStatus("01");
			purchase.setRegid(id);
			insertPurchase(purchase);
			
			//재구매 롤업
			// 1. 후원롤업대상 조회(20대 - 50p)
			List<User> upSponList = new ArrayList<User>();
			User user = getUser(id);
			upSponList.add(user); //본인포함 20대
			String sponId = user.getSponsor(); // 가입자의 후원인 아이디 확인
			for(int i=0; i<19; i++) { //본인포함이므로
				User upUser = getSponAndRecommTarget(sponId);
				
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
				User upUser = getSponAndRecommTarget(recommId); 
				
				if(upUser != null) {
					upRecommList.add(upUser);
					recommId = upUser.getRecommender(); //조회된 상위 대 추천인의 추천인아이디를 세팅
				}else {
					break;
				}
				
			}
			
			// 3. 후원추천롤업 저장
			// 3.1 후원
			for(int i=0; i<upSponList.size();i++) {
				ph = new PointHistory();
				ph.setId("BATCH");
				ph.setType("08");
				ph.setPoint("50"); // 후원 50 point
				ph.setMessage(msg+" 후원롤업 "+(i+1)+"대"); // 후원 50 point
				ph.setFromId(user.getId());
				ph.setToId(upSponList.get(i).getId());
				registerPoint(ph);
				
				User us = new User();
				us.setId(upSponList.get(i).getId());
				us.setPoint("50");
				updatePoint(us);
			}
			
			// 3.2 추천
			for(int i=0; i<upRecommList.size();i++) {
				ph = new PointHistory();
				ph.setId("BATCH");
				ph.setType("07");
				ph.setPoint("100"); // 추천 100 point
				ph.setMessage(msg+" 추천롤업 "+(i+1)+"대"); // 후원 50 point
				ph.setFromId(user.getId());
				ph.setToId(upSponList.get(i).getId());
				registerPoint(ph);
				
				User us = new User();
				us.setId(upSponList.get(i).getId());
				us.setPoint("100");
				updatePoint(us);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			throw e;
		}

		transactionManager.commit(status);
		return 1;
	}
	
	//출금처리
	public int exhcange(Exchanges exchanges) {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("registerMember-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {

			//관리자 ID 얻어오기
			String grade = "SE01MASK";
			String admin = sql.selectOne("office.selectAdmin",grade);

			//포인트 이력 테이블 등록
			PointHistory pointHistory = new PointHistory();
			pointHistory.setType("02");
			pointHistory.setMessage("출금");
			pointHistory.setPoint(exchanges.getPoint());
			pointHistory.setId(exchanges.getId());
			pointHistory.setFromId(exchanges.getId());
			pointHistory.setToId("admin");
			registerPoint(pointHistory);
						
			//출금을 진행한 유저의 포인트 차감
			User mUser = new User();
			mUser.setPoint("-"+exchanges.getPoint());
			mUser.setId(exchanges.getId());
			updatePoint(mUser);
			
			//차감된 유저의 포인트를 관리자에게 부여
			mUser.setPoint(exchanges.getPoint());
			mUser.setId(admin);
			updatePoint(mUser);
			
			//출금 테이블 등록
			exchanges.setStatus("01");
			insertExchanges(exchanges);
			
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			throw e;
		}

		transactionManager.commit(status);
		return 1;
	}
	
	public String rollUpSponsor(String id) {
		 String parent = sql.selectOne("office.rollUpSponsor",id);
		 return parent;
	}
	
	public String rollUpRecommender(String id) {
		 String parent = sql.selectOne("office.rollUpRecommender",id);
		 return parent;
	}
	//출금처리
	public int trans(PointHistory pointHistory) {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("registerMember-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {

			//포인트 이력 테이블 등록
			pointHistory.setPoint(pointHistory.getPoint());
			pointHistory.setType("03");
			pointHistory.setMessage("송금");
			registerPoint(pointHistory);
						
			//송금을 진행한 유저의 포인트 차감
			User mUser = new User();
			mUser.setPoint("-"+pointHistory.getPoint());
			mUser.setId(pointHistory.getId());
			updatePoint(mUser);
			
			//차감된 유저의 포인트를 송금받는 사람에게 부여
			mUser.setPoint(pointHistory.getPoint());
			mUser.setId(pointHistory.getToId());
			updatePoint(mUser);
			
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			throw e;
		}

		transactionManager.commit(status);
		return 1;
	}
	
	//출금처리
	public int approveCharge(Charge charge) {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("registerMember-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {

			//관리자 ID 얻어오기
			String grade = "SE01MASK";
			String admin = sql.selectOne("office.selectAdmin",grade);
			
			//충전신청 데이터 가져오기
			Charge cg = sql.selectOne("office.selectCharge", charge);
			
			//포인트 이력 테이블 등록
			PointHistory pointHistory = new PointHistory();
			pointHistory.setId(cg.getId());
			pointHistory.setPoint(cg.getPoint());
			pointHistory.setType("01");
			pointHistory.setMessage("충전");
			pointHistory.setFromId(admin);
			pointHistory.setToId(cg.getId());
			registerPoint(pointHistory);

			//충전을 진행한 관리자의 포인트 차감
			User mUser = new User();
			mUser.setPoint("-"+cg.getPoint());
			mUser.setId(admin);
			updatePoint(mUser);
			
			//충전한 유저의 포인트를 충전
			mUser.setPoint(cg.getPoint());
			mUser.setId(cg.getId());
			updatePoint(mUser);
			
			//충전완료처리
			cg.setModid(admin);
			cg.setStatus("02");
			cg.setSeq(charge.getSeq());
			sql.update("office.approveCharge",cg);
			
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			throw e;
		}

		transactionManager.commit(status);
		return 1;
	}
	
	//충전신청
	public int charge(Charge charge) {
		return sql.insert("office.registerCharge", charge);
	}
	
	//상품등록
	public int registerGoods(Goods goods){
		return sql.insert("office.registerGoods", goods);
	}
	
	//상품등록
	public int insertExchanges(Exchanges exchanges){
		return sql.insert("office.insertExchanges", exchanges);
	}
	
	//주문등록
	public int insertPurchase(Purchase purchase){
		return sql.insert("office.insertPurchase", purchase);
	}
	
	//유효기간 설정
	public int updateExpire(User user){
		return sql.update("office.updateExpire", user);
	}
	
	//포인트이력등록
	public int insertPointHistory(PointHistory ph){
		return sql.insert("office.insertPointHistory", ph);
	}
	
	//회원정보수정
	public int updateMember(User user){
		return sql.insert("office.updateMember", user);
	}
	
	//센터승급
	public int gradeUpMember(User user){
		return sql.update("office.gradeUpMember", user);
	}
	
	//포인트수정
	public int updatePoint(User user){
		return sql.insert("office.updatePoint", user);
	}
	
	//포인트수정
	public int registerAgent(Agent agent){
		return sql.insert("office.registerAgent", agent);
	}
		
	//회원리스트
	public List<User> selectMember(String searchWord){
		return sql.selectList("office.selectMember", searchWord);
	}
	
	//센터리스트
	public List<Agent> selectAgent(String searchWord){
		return sql.selectList("office.selectAgent", searchWord);
	}

	//센터승인대기 대리점 리스트
	public List<Agent> selectStandByAgent(){
		return sql.selectList("office.selectStandByAgent");
	}

	
	//후원인리스트
	public List<Agent> selectSponsor(String searchWord){
		return sql.selectList("office.selectSponsor", searchWord);
	}
	
	//문의하기 리스트
	public List<Inquiry> selectInquiry(String id){
		return sql.selectList("office.selectInquiry", id);
	}
	
	//상품리스트
	public List<Goods> selectGoods(Goods goods){
		return sql.selectList("office.selectGoods", goods);
	}
	
	//상품리스트
	public Goods getGoods(Goods goods){
		return sql.selectOne("office.getGoods", goods);
	}
	
	//포인트내역
	public List<PointHistory> selectPointHistory(PointHistory pointHistory){
		return sql.selectList("office.selectPointHistory", pointHistory);
	}
	
	//포인트수정
	public int registerPoint(PointHistory pointHistory){
		return sql.insert("office.registerPoint", pointHistory);
	}
	
	//관리자 찾기
	public String selectAdmin(String grade){
		return sql.selectOne("office.selectAdmin",grade);
	}
	
	//충전신청 대기건수
	public int requestChargeCnt(){
		String status = "01";
		return sql.selectOne("office.requestChargeCnt", status);
	}
	
	//충전신청목록
	public List<Charge> selectChargeList(){
		return sql.selectList("office.selectChargeList");
	}
	
	//문의사항등록
	public int registerInquiry(Inquiry inquiry){
		return sql.insert("office.registerInquiry", inquiry);
	}
	
	//문의사항등록
	public int registerAnswer(Inquiry inquiry){
		return sql.update("office.registerAnswer", inquiry);
	}
	
	//구매내역
	public List<Purchase> selectPurchaseList(String id){
		return sql.selectList("office.selectPurchaseList", id);
	}
	
	//구매내역 업데이트
	public int uploadPurchase(Purchase purchase){
		return sql.update("office.uploadPurchase", purchase);
	}
	
	
	//구매내역
	public List<Notice> selectNoticeList(){
		String type = "2";
		return sql.selectList("office.selectNoticeList", type);
	}
	
	//================================================ 일마감
	
	// 하위 후원인 카운트 조회
	public int getUnderSponCnt(String id) {
		return sql.selectOne("office.getUnderSponCnt", id);
	}
	
	// 일마감 자료 반영
	public int modDayClosing(DayClosing dayClosing) {
		return sql.update("office.modDayClosing", dayClosing);
	}
	
	//일마감초기화(추천인만 지급)
	public int resetRecommDayClosing(String id) {
		return sql.update("office.resetRecommDayClosing", id);
	}
	
	//일마감초기화(후원, 추천인 지급)
	public int resetSponRecommDayClosing(String id) {
		return sql.update("office.resetSponRecommDayClosing", id);
	}
	
	
	
	
}
