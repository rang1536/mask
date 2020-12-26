package kr.or.mask.controller;

import java.text.DateFormat;
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

import kr.or.mask.domain.Goods;
import kr.or.mask.domain.PointHistory;
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
	public String business(Model model) {
		logger.info("business START");

		//model.addAttribute("serverTime", formattedDate );
		
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
	public String purchase(Locale locale, Model model) {
		logger.info("purchase START");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
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

		User user = officeService.getUser(id);
		pointHistory.setBeginIdx(0);
		pointHistory.setSearchRows(1000);
		if(pointHistory.getSearchToDate() != null){
			pointHistory.setSearchToDate(Integer.parseInt(pointHistory.getSearchToDate())+1+"");
		}

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
	
}
