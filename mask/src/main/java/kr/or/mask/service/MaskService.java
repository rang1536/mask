package kr.or.mask.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mask.dao.MaskDao;
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
	
	
	
}
