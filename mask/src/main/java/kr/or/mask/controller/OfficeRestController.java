package kr.or.mask.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.mask.domain.Agent;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.User;
import kr.or.mask.service.OfficeService;

@SessionAttributes({"id"})

@RestController
public class OfficeRestController {

	@Autowired
	private OfficeService officeService;
	
	private static final Logger logger = LoggerFactory.getLogger(OfficeController.class);
	
	@RequestMapping(value="/dupIdCheck", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> loginCtrl(@RequestParam(value="id") String id){
				
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.dupIdCheck(id);
		
		if(cnt==0){
			map.put("result", "success");
			map.put("message", "사용가능한 아이디 입니다.");
		}else {
			map.put("result", "error");
			map.put("message", "이미 사용하고 있는 아이디 입니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/register", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> registerMember(@ModelAttribute(value="id") String id , User user){
		user.setRegid(id);
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.registerMember(user);
		
		if(cnt==1){
			//포인트 이력 테이블 등록
			PointHistory ph = new PointHistory();
			ph.setId(id);
			ph.setMessage("신규회원가입");
			ph.setPoint("70000");
			ph.setType("02");
			officeService.insertPointHistory(ph);
			
			//회원가입을 진행한 유저의 포인트 차감
			User user2 = new User();
			user2.setPoint("-70000");
			user2.setId(id);
			officeService.updatePoint(user2);
			
			map.put("result", "success");
			map.put("message", "등록되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/updMem", method= {RequestMethod.POST})
	public Map<String, Object> updateMember(@ModelAttribute(value="id") String id , User user){
		user.setModid(id);
		user.setId(id);
		int cnt = officeService.getPass(user);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(cnt==0){
			map.put("result", "error");
			map.put("message", "아이디 혹은 비밀번호가 일치하지 않습니다.");
		}else {
			cnt = officeService.updateMember(user);
			
			if(cnt==1){
				map.put("result", "success");
				map.put("message", "정상 처리되었습니다.");
			}else {
				map.put("result", "error");
				map.put("message", "오류가 발생하였습니다.");
			}
		}
		return map;
	}
	
	@RequestMapping(value="/searchMem", method= {RequestMethod.POST})
	public Map<String, Object> selectMember(@RequestParam(value="searchWord") String searchWord){

		List<User> list = officeService.selectMember(searchWord);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value="/searchAgent", method= {RequestMethod.POST})
	public Map<String, Object> searchAgent(@RequestParam(value="searchWord") String searchWord){

		List<Agent> list = officeService.selectAgent(searchWord);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
}
