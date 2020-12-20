package kr.or.mask.controller;

import java.text.DateFormat;
import java.util.Date;
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
		model.addAttribute("point", point);
		
		return "/office/registerMember";
	}

	@RequestMapping(value = "/rePurchase", method = RequestMethod.GET)
	public String rePurchase(@ModelAttribute(value="id")String id , Model model) {
		logger.info("rePurchase START");

		User user = officeService.getUser(id);
		String point = user.getPoint();
		model.addAttribute("point", point);
		
		return "/office/rePurchase";
	}
	
}
