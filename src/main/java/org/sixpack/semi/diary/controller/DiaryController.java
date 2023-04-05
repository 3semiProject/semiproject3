package org.sixpack.semi.diary.controller;

import java.sql.Date;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("diaryCon")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	private static final Logger logger = LoggerFactory.getLogger(DiaryController.class);
	
	//메인->다이어리로 화면전환시 회원정보전달용
	@RequestMapping(value="diary.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String showFirstDiary( RedirectAttributes redirect,
			HttpSession session, Diary diary) {
		String user_id = ((Member)session.getAttribute("loginMember")).getUser_id();
		if(user_id!=null) { //로그인상태 목표정보확인
			Goal goal;
			//Date today = new Date(new java.util.Date().getTime());
			//test용 날짜값 변경
			Date today = java.sql.Date.valueOf("2023-03-01"); //test
			diary.setUser_id(((Member)session.getAttribute("loginMember")).getUser_id());
			diary.setDiary_post_date(today);

			//goal 최근작성일이 오늘기준 한달이전 goal을 조회
			//한달이내 goal이 없으면 목표관리 페이지로 이동
			//goal 목표 종료일이 오늘 이전이면 목표관리 페이지로 이동(이동 후 팝업안내창띄우기)
			goal = diaryService.selectCurrentGoal(diary);
			if(goal==null || goal.getGoal_date().before(today)) {
				redirect.addFlashAttribute("diary", diary);
				return "redirect:diary_showGoalModify.do";
			}
			
			//목표정보 있으면 식단다이어리 보기화면
			redirect.addFlashAttribute("diary", diary);
			return "redirect:diary_showEatDiary.do";
		}
		
		//비로그인 상태면 로그인 페이지로 이동
			return "redirect:loginPage.do";
	}
	
	
	//날짜네비게이션 날짜 이동처리용
	@RequestMapping("diary_moveWeekDiary.do")
	public String moveWeekDiary(RedirectAttributes redirect,
			HttpSession session,
			@RequestParam("ago") int ago,
			@RequestParam("week")Date day) {
		//기준일로 부터 몇일 전 날짜로 이동할지
		String user_id = ((Member)session.getAttribute("loginMember")).getUser_id();
		DateData move = new DateData(day, user_id, ago);
		
		Diary diary = diaryService.selectMoveDiary(move);
		redirect.addFlashAttribute("diary", diary);
		
		//카테고리에 따라 controller 지정
		//diary 없으면 빈 식단화면으로 나옴
		if(diary.getDiary_category().equals("act")){
			return "redirect:diary_showActDiary.do";
		}else if(diary.getDiary_category().equals("body")){
			return "redirect:diary_showBodyDiary.do";
		}else {
			return "redirect:diary_showEatDiary.do";
		}
	}
//	//탭버든 날짜 이동처리용
//	@RequestMapping(value="diary_moveTapDiary.do", method= {RequestMethod.GET, RequestMethod.POST})
//	public String moveTapDiary(RedirectAttributes redirect,
//			//HttpSession session,
//			@RequestParam(value="diaryTap", required=false)Diary diary) {
//		
//		redirect.addFlashAttribute("diary", diary);
//		//카테고리에 따라 controller 지정
//		//diary 없으면 빈 식단화면으로 나옴
//		if(diary.getDiary_category().equals("act")){
//			return "redirect:diary_showActDiary.do";
//		}else if(diary.getDiary_category().equals("body")){
//			return "redirect:diary_showBodyDiary.do";
//		}else {
//			return "redirect:diary_showEatDiary.do";
//		}
//	}
	
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


//	@RequestMapping ("diary.do")
//	public String moveStatsMethod(){
//		return "diary/stats/actStats";
//	}


}//controller
