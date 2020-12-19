package kr.or.mask.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.or.mask.service.MaskService;

@RestController
public class MaskRestController {
	@Autowired
	private MaskService mServ;
	
	//로그인
	@RequestMapping(value="/login",  method = RequestMethod.POST)
	public Map<String, Object> loginCtrl(String id, String pass){
		System.out.println("id : "+id+", pass : "+pass);
		return mServ.loginServ(id, pass);
	}
	
}
