package org.sixpack.semi.diary.controller;

import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("diaryCon")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	private static final Logger logger = 
			LoggerFactory.getLogger(DiaryController.class);
	
	//다이어리 최초화면 정보전달용
	@RequestMapping(value="diary.do", method=RequestMethod.POST)
	public String showFirstDiary(RedirectAttributes redirect,
			HttpSession session, Diary diary) {
		if(session!=null) {
		//회원id로 오늘날짜의 식단을 입력한 diary 정보만 전달
		diary.setUser_id(session.getAttribute("user_id").toString());
		diary.setDiary_post_date((Date)new java.util.Date());
		diary.setDiary_catagory("eat");
		}
		//test용 data입력
		if(session==null) {
			diary.setUser_id("USER01");
			diary.setDiary_post_date(new Date(2023-1900,3-1,4));
			diary.setDiary_catagory("eat");			
		}
		
		redirect.addFlashAttribute("diary", diary);
		return "redirect:diary_showEatDiary.do";
	}
	
	
	//날짜네비게이션 날짜 이동처리용
	@RequestMapping("diary_moveWeekVar.do")
	public String moveWeekvarMethod(Model model,
			@RequestParam("week")DateData data, Diary diary) {
		if(data==null) {
			model.addAttribute("message","전달정보가 없어 날짜이동 실패");
			return "common/error";
		}
		
		//전달받은 값으로 출력할 다이어리 값 셋팅
		diary.setUser_id(data.getUser_id());
		diary.setDiary_post_date(data.getDate());		
		if(data.getEats()>0) {
			diary.setDiary_catagory("eat");
		}else if(data.getActs()>0) {
			diary.setDiary_catagory("act");
		}else {
			diary.setDiary_catagory("body");
		}
		//다이어리 조회, model에 담기
		diary = diaryService.selectOneDiary(diary);
		model.addAttribute("diary",diary);
		
		//카테고리에 따라 controller 지정
		//diary 없으면 빈 식단화면으로 나옴
		if(diary.getDiary_catagory().equals("act")){
			return "diary_showBodyView.do";						
		}else if(diary.getDiary_catagory().equals("body")){
			return "diary_showActView.do";						
		}else {
			//diary.getDiary_catagory().equals("eat")
			return "diary_showEatView.do";			
		}
	}


//	//캘린더 출력용
//	@RequestMapping(value = "diary_showCalendar.do", method = RequestMethod.GET)
//	public String calendar(Model model, HttpServletRequest request, DateData dateData){
//		
//		Calendar cal = Calendar.getInstance();
//		DateData calendarData;
//		//검색 날짜
//		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
//			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
//		}
//		//검색 날짜 end
//
//		Map<String, Integer> today_info =  dateData.today_info(dateData);
//		List<DateData> dateList = new ArrayList<DateData>();
//		
//		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
//		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
//		for(int i=1; i<today_info.get("start"); i++){
//			calendarData= new DateData(null, null, null, null);
//			dateList.add(calendarData);
//		}
//		
//		//날짜 삽입
//		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
//			if(i==today_info.get("today")){
//				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
//			}else{
//				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
//			}
//			dateList.add(calendarData);
//		}
//
//		//달력 빈곳 빈 데이터로 삽입
//		int index = 7-dateList.size()%7;
//		
//		if(dateList.size()%7!=0){
//			
//			for (int i = 0; i < index; i++) {
//				calendarData= new DateData(null, null, null, null);
//				dateList.add(calendarData);
//			}
//		}
//		System.out.println(dateList);
//		
//		//배열에 담음
//		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
//		model.addAttribute("today_info", today_info);
//		return "views/diary/common/calendar";
//	}


	@RequestMapping ("diary.do")
	public String moveStatsMethod(){
		return "diary/stats/actStats";
	}


}//controller
