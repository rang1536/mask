package kr.or.mask.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.mask.domain.User;
import kr.or.mask.service.OfficeService;

@RestController
public class OfficeRestController {

	@Autowired
	private OfficeService officeService;
	
	private static final Logger logger = LoggerFactory.getLogger(OfficeController.class);
	
	@RequestMapping(value="/dupIdCheck", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> loginCtrl(@RequestParam(value="id")String id){
				
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
	public Map<String, Object> registerMember(User user){
		logger.info(user.toString());
		System.out.println(user.toString());
		user.setRegid("test");
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.registerMember(user);
		
		if(cnt==1){
			map.put("result", "success");
			map.put("message", "등록되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
}
