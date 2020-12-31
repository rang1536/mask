package kr.or.mask.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.mask.domain.Agent;
import kr.or.mask.domain.Charge;
import kr.or.mask.domain.Goods;
import kr.or.mask.domain.Inquiry;
import kr.or.mask.domain.Notice;
import kr.or.mask.domain.PointHistory;
import kr.or.mask.domain.Purchase;
import kr.or.mask.domain.User;
import kr.or.mask.service.OfficeService;

@SessionAttributes({"id"})

/**
 * Handles requests for the application home page.
 */
@Controller
public class OfficeController {
	
	private static final Logger logger = LoggerFactory.getLogger(OfficeController.class);
	
	@Autowired
	private OfficeService officeService;
	
	
	@RequestMapping(value = "/business", method = RequestMethod.GET)
	public String business(@ModelAttribute(value="id")String id , Model model) {
		
		User user = officeService.getUser(id);
		List<Notice> noticeList = officeService.selectNoticeList();
		List<User> sponList = officeService.selectSponList(id);
		String aSpon = "";
		String bSpon = "";
		for(int i=0; i<sponList.size(); i++) {
			if(i == 0) aSpon = sponList.get(i).getId();
			if(i == 1) bSpon = sponList.get(i).getId();
		}

		model.addAttribute("aSpon", aSpon);
		model.addAttribute("bSpon", bSpon);
		model.addAttribute("user", user);
		model.addAttribute("noticeList", noticeList);
		
		return "/office/myBusiness";
	}
	
	@RequestMapping(value = "/infoMem", method = RequestMethod.GET)
	public String infoMember(@ModelAttribute(value="id")String id , Model model) {
		logger.info("infoMember START : "+id);
		
		User user = officeService.getUser(id);
		model.addAttribute("user", user);
		
		return "/office/infoMember";
	}
	
	@RequestMapping(value = "/purchase", method = RequestMethod.GET)
	public String purchase(@ModelAttribute(value="id")String id , Model model) {
		logger.info("purchase START");

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);

		Purchase purchase = new Purchase();
		purchase.setSearchFromDate(today);
		purchase.setSearchToDate(today);
		purchase.setRegid(id);
		
		List<Purchase> list = officeService.searchPurchase(purchase);
		
		model.addAttribute("list", list);

		Purchase pc = new Purchase();
		pc.setRegid(id);
		model.addAttribute("payedCnt", officeService.getDeliveryTypeCnt(pc));
		pc.setStatus("03");
		model.addAttribute("completedCnt", officeService.getDeliveryTypeCnt(pc));
		pc.setStatus("01");
		model.addAttribute("readyCnt", officeService.getDeliveryTypeCnt(pc));
		pc.setStatus("02");
		model.addAttribute("ingCnt", officeService.getDeliveryTypeCnt(pc));
		return "/office/purchase";
	}
	
	@RequestMapping(value = "/regiMem", method = RequestMethod.GET)
	public String registerMember(@ModelAttribute(value="id")String id , Model model) {
		logger.info("registerMember START");
		
		User user = officeService.getUser(id);
		String point = user.getPoint();
		
		Goods goods = new Goods();
		goods.setNewPriceYn("Y");
		List<Goods> goodsList = officeService.selectGoods(goods);
		
		model.addAttribute("list",goodsList);
		model.addAttribute("point", point);
		
		return "/office/registerMember";
	}

	@RequestMapping(value = "/rePurchase", method = RequestMethod.GET)
	public String rePurchase(@ModelAttribute(value="id")String id , Model model) {
		logger.info("rePurchase START");

		User user = officeService.getUser(id);
		String point = user.getPoint();
		
		List<Goods> goodsList = officeService.selectGoods(null);
		
		model.addAttribute("list",goodsList);
		model.addAttribute("point", point);
		
		model.addAttribute("user",user);
		
		return "/office/rePurchase";
	}

	@RequestMapping(value = "/customer", method = RequestMethod.GET)
	public String customer(@ModelAttribute(value="id")String id , Model model) {
		logger.info("customer START");
		
		User user = officeService.getUser(id);
		String point = user.getPoint();
		
		List<Goods> goodsList = officeService.selectGoods(null);
		
		model.addAttribute("list",goodsList);
		model.addAttribute("point", point);
		
		model.addAttribute("user",user);
		
		return "/office/customer";
	}
	
	@RequestMapping(value = "/goods", method = RequestMethod.GET)
	public String goods(Model model) {
		logger.info("goods START");

		List<Goods> goodsList = officeService.selectGoods(null);
		model.addAttribute("list",goodsList);
		return "/office/goods";
	}

	@RequestMapping(value = "/pointHistory", method = RequestMethod.GET)
	public String pointHistory(@ModelAttribute(value="id")String id , PointHistory pointHistory, Model model) {
		logger.info("pointHistory START");

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date);
		
		String grade = "SE01MASK";
		String admin = officeService.selectAdmin(grade);
		User user = officeService.getUser(id);
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
		
		System.out.println(pointHistory.getId());
		
		List<PointHistory> pointList = officeService.selectPointHistory(pointHistory);
		model.addAttribute("list" , pointList);
		model.addAttribute("user", user);
		return "/office/pointHistory";
	}
	
	@RequestMapping(value = "/pointExchange", method = RequestMethod.GET)
	public String pointExchange(@ModelAttribute(value="id")String id , Model model) {
		logger.info("pointExchange START");

		User user = officeService.getUser(id);
		String point = user.getPoint();

		model.addAttribute("point", point);
		return "/office/exchange";
	}

	@RequestMapping(value = "/pointCharge", method = RequestMethod.GET)
	public String pointCharge(@ModelAttribute(value="id")String id , Model model) {
		logger.info("pointCharge START");

		User user = officeService.getUser(id);
		String point = user.getPoint();

		model.addAttribute("point", point);
		return "/office/charge";
	}
	
	@RequestMapping(value = "/chargeList", method = RequestMethod.GET)
	public String chargeList(@ModelAttribute(value="id")String id , Model model) {
		logger.info("chargeList START");
		
		String grade = "SE01MASK";
		String admin = officeService.selectAdmin(grade);
		
		if(admin == null) {
			return "/office/business";
		}else {
			List<Charge> list = officeService.selectChargeList();
			model.addAttribute("list", list);
			return "/office/chargeList";
		}
	}
	

	@RequestMapping(value = "/inquiry", method = RequestMethod.GET)
	public String inquiry(@ModelAttribute(value="id")String id , Model model) {
		logger.info("inquiry START");

		String grade = "SE01MASK";
		String admin = officeService.selectAdmin(grade);
		boolean isAdmin = false;
		if(id.equals(admin)) {
			isAdmin = true;
		}
		List<Inquiry> list = officeService.selectInquiry(id);
		model.addAttribute("list", list);
		model.addAttribute("isAdmin", isAdmin);
		return "/office/inquiry";

	}

	@RequestMapping(value = "/agentList", method = RequestMethod.GET)
	public String agent(@ModelAttribute(value="id")String id , Model model) {
		logger.info("agent START");

		List<Agent> agentList = officeService.selectAgent("");
		List<Agent> standByList = officeService.selectStandByAgent();
		model.addAttribute("agentList", agentList);
		model.addAttribute("standByList", standByList);
		return "/office/agent";

	}

}
