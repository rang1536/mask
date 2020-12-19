package kr.or.mask.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mask.dao.OfficeDao;
import kr.or.mask.domain.User;

@Service
public class OfficeService {
	
	@Autowired
	private OfficeDao officeDao;
	
	//중복아이디조회
	public int dupIdCheck(String userId){
		return officeDao.dupIdCheck(userId);
	}
	
	//유저정보조회
	public int registerMember(User user){
		return officeDao.registerMember(user);
	}

}
