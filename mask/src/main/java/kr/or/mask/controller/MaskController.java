package kr.or.mask.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.mask.service.MaskService;

@Controller
public class MaskController {
	@Autowired
	private MaskService mServ;
	
	//회사소개
	@RequestMapping(value="/introCompany",  method = RequestMethod.GET)
	public String introCompanyCtrl(){
		//System.out.println(order);
		return "company";
	}
	
	//사업소개
	@RequestMapping(value="/introProduct",  method = RequestMethod.GET)
	public String introProductCtrl(){
		//System.out.println(order);
		return "main/product";
	}
	
	//공지사항
	@RequestMapping(value="/notice",  method = RequestMethod.GET)
	public String noticeCtrl(){
		//System.out.println(order);
		return "notice";
	}
	
	//마이오피스 - 로그인페이지 연결
	@RequestMapping(value="/officeLogin",  method = RequestMethod.GET)
	public String officeLoginCtrl(){
		//System.out.println(order);
		return "officeLogin";
	}
	
	//쇼핑몰
	@RequestMapping(value="/shop",  method = RequestMethod.GET)
	public String shopCtrl(){
		//System.out.println(order);
		return "shop";
	}
	
	
}
