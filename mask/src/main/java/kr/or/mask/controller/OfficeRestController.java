package kr.or.mask.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.mask.domain.Agent;
import kr.or.mask.domain.Charge;
import kr.or.mask.domain.Exchanges;
import kr.or.mask.domain.Goods;
import kr.or.mask.domain.Inquiry;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.Purchase;
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
		logger.info(user.toString());
		int cnt = officeService.registerMember(id, user);
		
		if(cnt==1){
			map.put("result", "success");
			map.put("message", "등록되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/registerGoods", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> registerGoods(@ModelAttribute(value="id") String id , Goods goods){
		goods.setRegid(id);
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.registerGoods(goods);
		
		if(cnt==1){
			map.put("result", "success");
			map.put("message", "등록되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
		
	@RequestMapping(value="/registerPurchase", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> registerPurchase(@ModelAttribute(value="id") String id , Purchase purchase){
		purchase.setRegid(id);
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.registerPurchase(id, purchase);
		
		if(cnt==1){
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

	@RequestMapping(value="/searchSponsor", method= {RequestMethod.POST})
	public Map<String, Object> searchSponsor(@RequestParam(value="searchWord") String searchWord){

		List<Agent> list = officeService.selectSponsor(searchWord);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value="/selectHistory", method= {RequestMethod.POST})
	public Map<String, Object> selectHistory(@ModelAttribute(value="id")String id , PointHistory pointHistory){

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);
		
		String grade = "SE01MASK";
		String admin = officeService.selectAdmin(grade);
		
		pointHistory.setBeginIdx(0);
		pointHistory.setSearchRows(1000);
		if(pointHistory.getSearchToDate() != null){
			pointHistory.setSearchToDate(Integer.parseInt(pointHistory.getSearchToDate())+1+"");
		}else {
			pointHistory.setSearchFromDate(today);
			pointHistory.setSearchToDate((Integer.parseInt(today)+1)+"");
		}
		
		if(id.equals(admin)) {
			pointHistory.setId(null);
		}else {
			pointHistory.setId(id);
		}
		logger.info(pointHistory.toString());
		List<PointHistory> list = officeService.selectPointHistory(pointHistory);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value="/exchange", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> exchange(@ModelAttribute(value="id") String id , Exchanges exchanges){
		Map<String, Object> map = new HashMap<String, Object>();

		exchanges.setId(id);
		exchanges.setRegid(id);
		exchanges.setPoint(exchanges.getPoint().replaceAll(",", ""));
		logger.info(exchanges.toString());
		int cnt = officeService.exchange(exchanges);
		
		if(cnt==1){
			map.put("result", "success");
			map.put("message", "출금신청이 정상처리되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "출금신청 등록에 실패하였습니다.");
		}

		return map;
	}

	@RequestMapping(value="/charge", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> charge(@ModelAttribute(value="id") String id , Charge charge){
		Map<String, Object> map = new HashMap<String, Object>();

		charge.setId(id);
		charge.setRegid(id);
		charge.setPoint(charge.getPoint().replaceAll(",", ""));
		logger.info(charge.toString());
		int cnt = officeService.charge(charge);
		
		if(cnt==1){
			map.put("result", "success");
			map.put("message", "충전신청이 정상처리되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "충전신청 등록에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/trans", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> trans(@ModelAttribute(value="id") String id , PointHistory pointHistory){
		Map<String, Object> map = new HashMap<String, Object>();

		pointHistory.setId(id);
		pointHistory.setFromId(id);
		pointHistory.setPoint(pointHistory.getPoint().replaceAll(",", ""));
		
		int cnt = officeService.trans(pointHistory);

		if(cnt==1){
			map.put("result", "success");
			map.put("message", "송금이 정상처리되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "송금에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/requestCharge", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> requestCharge(@ModelAttribute(value="id") String id){
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.requestChargeCnt();

		String grade = "SE01MASK";
		String admin = officeService.selectAdmin(grade);
		
		if(cnt > 0){
			if(id.equals(admin)) {
				map.put("result", "ok");
				map.put("message", cnt+" 건의 충전신청이 있습니다\n충전신청관리 페이지로 이동하시겠습니까?");
			}
		}

		return map;
	}
	
	
	@RequestMapping(value="/approveCharge", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> approveCharge(@ModelAttribute(value="id") String id, Charge charge){
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = officeService.approveCharge(charge);
		
		if(cnt > 0){
			map.put("result", "success");
			map.put("message", "승인이 완료되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "승인하기가 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/registerInquiry", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> registerInquiry(@ModelAttribute(value="id") String id, Inquiry inquiry){
		Map<String, Object> map = new HashMap<String, Object>();
		inquiry.setRegid(id);
		inquiry.setStatus("01");
		int cnt = officeService.registerInquiry(inquiry);
		
		if(cnt > 0){
			map.put("result", "success");
			map.put("message", "등록이 완료되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/registerAnser", method= {RequestMethod.POST,RequestMethod.GET})
	public Map<String, Object> registerAnser(@ModelAttribute(value="id") String id, Inquiry inquiry){
		Map<String, Object> map = new HashMap<String, Object>();
		inquiry.setAnsid(id);
		inquiry.setStatus("02");
		int cnt = officeService.registerAnswer(inquiry);
		
		if(cnt > 0){
			map.put("result", "success");
			map.put("message", "등록이 완료되었습니다.");
		}else {
			map.put("result", "error");
			map.put("message", "등록에 실패하였습니다.");
		}

		return map;
	}
	
	@RequestMapping(value="/uploadPurchase", method = RequestMethod.POST)
    public Map<String, Object> uploadPurchase(@ModelAttribute(value="id") String id , MultipartHttpServletRequest request){

        MultipartFile excelFile = request.getFile("uploadExcel");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택해 주세요");
        }
 
        File destFile = new File("D:\\"+excelFile.getOriginalFilename());
        try {
        	excelFile.transferTo(destFile);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(),e);
 
        }
        
        Map<String, Object> map = officeService.uploadPurchase(id, destFile);
        
        return map;
    }
	
}
