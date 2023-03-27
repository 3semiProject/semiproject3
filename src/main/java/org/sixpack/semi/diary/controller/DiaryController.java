package org.sixpack.semi.diary.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("diaryCon")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	private static final Logger logger = 
			LoggerFactory.getLogger(DiaryController.class);	
	//단순화면출력
	@SuppressWarnings("deprecation")
	@RequestMapping("test.do")
	public String testWeekvarView(Model model, Diary diary,
			ArrayList<DateData> week) {
		week.add(new DateData(new Date(2023,3,1),"ADMIN", 1, 3,0,1));
		week.add(new DateData(new Date(2023,3,2),"ADMIN", 2, 0,1,1));
		week.add(new DateData(new Date(2023,3,3),"ADMIN", 3, 2,1,1));
		week.add(new DateData(new Date(2023,3,4),"ADMIN", 4, 1,1,1));
		week.add(new DateData(new Date(2023,3,5),"ADMIN", 5, 0,1,1));
		week.add(new DateData(new Date(2023,3,6),"ADMIN", 6, 0,0,1));
		week.add(new DateData(new Date(2023,3,7),"ADMIN", 7, 0,0,1));
		
		diary.setDiary_post_date(week.get(3).getDate());
		diary.setUser_id(week.get(3).getUser_id());
		diary.setDiary_catagory("eat");
		
		model.addAttribute("diary", diary);
		model.addAttribute("week", week);
	return "diary/common/weekbar";
	}
	
	//날짜네비게이션 출력용
	@RequestMapping("diary_showWeekVar.do")
	public String showWeekvarView(Model model, 
			Diary diary, @RequestParam("week") DateData data,
	ArrayList<DateData> week) {
		logger.info("diary_showWeekVar실행 : " + diary.toString());
		//기준날짜 넣어서 일주일 다이어리 불러오기
		//값 있으면 바로 diary 넣고
		//값 없으면 id, 오늘날짜 만들어서 diary에 넣고 조회
		//샘플데이터는 ID 대문자로 통일시켰음
		if(data ==null) {
			diary.setDiary_post_date((Date)new java.util.Date());
			diary.setUser_id("ADMIN");
		}else {
			diary.setDiary_post_date(data.getDate());
			diary.setUser_id(data.getUser_id());
		}
		week = diaryService.selectWeekDiary(diary);
		//네비게이션 기준일 today를 하나만 보내는 경우, 날짜가 31로 넘어갈 수 없음 -1일이 되버림
		//int today = (week.get(3).getDate().getDay());
		//각 DateData가 day를 가져야함
		logger.info("조회 기준일 : ", diary.getDiary_post_date(), ", ", 
				week.get(3).getDay());
		
		//다이어리 화면으로 이동할땐 week.get[3]을 diary로 보내주면됨
		model.addAttribute("week", week);
		return "diary/common/weekbar";
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

	
//	//다이어리 첫 화면 출력용
//
//	public String showfirstDiaryView(HttpServletRequest request,
//			Diary diary, Model model) {
//		if(diary.getUser_id()==null) {
//		diary.setUser_id((String)request.getAttribute("userid"));
//
//		diary.setDiary_post_date(today);
//		logger.info("today" + today);
//		
//		model.addAttribute("today", today);
//		
//		}		
//		
//		if(request !=null) {			
//			model.addAttribute("diary", diary);
//			return "diary/eat/eatView";
//		}else {
//			return "diary/eat/eatView";
//		}
//	}//showfirstDiaryview
//	
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
