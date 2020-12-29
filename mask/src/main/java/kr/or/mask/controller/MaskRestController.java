package kr.or.mask.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.mask.service.MaskService;

@SessionAttributes("id")
@RestController
public class MaskRestController {
	@Autowired
	private MaskService mServ;
	
	//로그인
	@RequestMapping(value="/login",  method = RequestMethod.POST)
	public Map<String, Object> loginCtrl(String id, String pass, Model model){
		//System.out.println("id : "+id+", pass : "+pass);
		Map<String, Object> result = new HashMap<String, Object>();
		result = mServ.loginServ(id, pass);
		
		if(result.get("result").equals("succ")) {
			model.addAttribute("id", id);
		}
		
		return result;
	}
	
	
	//후원조직도
	@RequestMapping(value="/getSponsorTree",  method = RequestMethod.POST)
	public Map<String, Object> getSponsorTreeCtrl(String id, int maxLoop){
		System.out.println("id : "+id+", maxLoop : "+maxLoop);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("user", mServ.getSponsorList(id, maxLoop));
		
		return result;
	}
	
	//추천조직도
	@RequestMapping(value="/getRecommenderTree",  method = RequestMethod.POST)
	public Map<String, Object> getRecommenderTreeCtrl(String id, int maxLoop){
		System.out.println("id : "+id+", maxLoop : "+maxLoop);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("user", mServ.getRecommList(id, maxLoop));
		
		return result;
	}
	
	
}
