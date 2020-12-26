package kr.or.mask.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.mask.service.MaskService;

@SessionAttributes("id")
@Controller
public class MaskController {
	@Autowired
	private MaskService mServ;
	
	//회사소개
	@RequestMapping(value="/introCompany",  method = RequestMethod.GET)
	public String introCompanyCtrl(){
		//System.out.println(order);
		return "main/company";
	}
	
	//사업소개
	@RequestMapping(value="/introProduct",  method = RequestMethod.GET)
	public String introProductCtrl(){
		//System.out.println(order);
		return "main/product";
	}
	
	//공지사항
	@RequestMapping(value="/notice",  method = RequestMethod.GET)
	public String noticeCtrl(Model model
			,@RequestParam(value="nowPageNum", defaultValue="1")int nowPageNum){
		model.addAttribute("totalCnt", mServ.getNoticeCntServ());
		model.addAttribute("list", mServ.getNoticeListServ(nowPageNum));
		return "main/notice";
	}
	
	//마이오피스 - 로그인페이지 연결
	@RequestMapping(value="/officeLogin",  method = RequestMethod.GET)
	public String officeLoginCtrl(){
		//System.out.println(order);
		return "main/officeLogin";
	}
	
	//쇼핑몰
	@RequestMapping(value="/shop",  method = RequestMethod.GET)
	public String shopCtrl(){
		//System.out.println(order);
		return "main/shop";
	}
	
	//조직도
	@RequestMapping(value="/workChart",  method = RequestMethod.GET)
	public String workChartCtrl(Model model
			, @ModelAttribute(value="id")String id){
		//model.addAttribute("sponList", mServ.getSponsorTree(id, 0));
		//model.addAttribute("recommList", mServ.getRecommenderTree(id, 0));
		return "office/workChart";
	}
	
	//조직도
	@RequestMapping(value="/zoomTest",  method = RequestMethod.GET)
	public String zoomTestCtrl(){
		//System.out.println(order);
		return "office/frameSet/sponsorChart";
	}
	
}
