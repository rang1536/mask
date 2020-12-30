package kr.or.mask;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.mask.service.MaskService;
import kr.or.mask.service.OfficeService;

@Component
public class Scheduler {
	
	@Autowired
	private OfficeService oServ;
	
	@Autowired
	private MaskService mServ;
	
	@Scheduled(cron="1 0 0 * * *")
	public void dayClosing() {
		Date date = new Date();
		
		//System.out.println(date+" 일마감 스케줄러 시작~!!");
		
		/*
		 * 후원보너스 정산 
		 * */
		
		//mServ.dayClosingStart();
		
		
		
	}
}
