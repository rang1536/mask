package kr.or.mask.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mask.dao.OfficeDao;
import kr.or.mask.domain.Agent;
import kr.or.mask.domain.Goods;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.User;

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
	
	//중복아이디조회
	public int getPass(User user){
		return officeDao.getPass(user);
	}
	//유저등록
	public int registerMember(User user){
		return officeDao.registerMember(user);
	}

	//상품등록
	public int registerGoods(Goods goods){
		return officeDao.registerGoods(goods);
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

	//상품목록
	public List<Goods> selectGoods(Goods goods){
		return officeDao.selectGoods(goods);
	}
	
	//포인트내역
	public List<PointHistory> selectPointHistory(PointHistory pointHistory){
		return officeDao.selectPointHistory(pointHistory);
	}
	
	//포인트출금신청
	public int registerPoint(PointHistory pointHistory){
		return officeDao.registerPoint(pointHistory);
	}
}