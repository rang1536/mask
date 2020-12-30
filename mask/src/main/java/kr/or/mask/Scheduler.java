package kr.or.mask;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.mask.service.OfficeService;

@Component
public class Scheduler {
	
	@Autowired
	private OfficeService oServ;
	
	@Scheduled(cron="1 * * * * *")
	public void dayClosing() {
		Date date = new Date();
		
		//System.out.println(date+" 일마감 스케줄러 시작~!!");
		
		//재구매정산
		
		//후원보너스 정산 
		
		//일마감 테이블 초기화 혹은 재생성.
		
	}
}
