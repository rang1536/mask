package kr.or.mask.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class OfficeController {
	
	private static final Logger logger = LoggerFactory.getLogger(OfficeController.class);
	
	@RequestMapping(value = "/business", method = RequestMethod.GET)
	public String business(Locale locale, Model model) {
		logger.info("business START");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/office/myBusiness";
	}
	
	@RequestMapping(value = "/infoMem", method = RequestMethod.GET)
	public String infoMember(Locale locale, Model model) {
		logger.info("infoMember START");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
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
	public String registerMember(Locale locale, Model model) {
		logger.info("registerMember START");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/office/registerMember";
	}




	
}
