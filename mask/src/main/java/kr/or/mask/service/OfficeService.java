package kr.or.mask.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mask.dao.OfficeDao;
import kr.or.mask.domain.Agent;
import kr.or.mask.domain.Charge;
import kr.or.mask.domain.Exchanges;
import kr.or.mask.domain.Goods;
import kr.or.mask.domain.Inquiry;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.Purchase;
import kr.or.mask.domain.User;
import kr.or.mask.util.ExcelRead;
import kr.or.mask.util.ReadOption;

@Service
public class OfficeService {
	
	@Autowired
	private OfficeDao officeDao;
	
	//유저조회
	public User getUser(String userId){
		return officeDao.getUser(userId);
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
	public int registerMember(String id, User user){
		return officeDao.registerMember(id, user);
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
	public List<User> selectMember(String searchWord){
		return officeDao.selectMember(searchWord);
	}
	
	//대리점목록
	public List<Agent> selectAgent(String searchWord){
		return officeDao.selectAgent(searchWord);
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
				map.put("result", "등록되었습니다.");
			}else {
				map.put("result", "error");
				map.put("result", "등록에 실패하였습니다.");				
			}
		}
		return map;
	}
	
	
}
