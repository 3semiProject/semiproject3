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
	
	//정보전달 없이 다이어리화면 띄울때,
	@RequestMapping(value="diary.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String showFirstDiary( RedirectAttributes redirect,
			HttpSession session) {
		if(session==null) {
			//비로그인 상태면 로그인 페이지로 이동
			return "redirect:loginPage.do";
			
			//정보 없을때 test용 날짜값 변경
			//Diary diary= new Diary("dd", java.sql.Date.valueOf("2023-03-01"), 0, "eat", null, null );
			//redirect.addFlashAttribute("diary", diary);
			//return "redirect:diary_showEatDiary.do";			
		}
		
		//다이어리에 회원정보담기
		String user_id = ((Member)session.getAttribute("loginMember")).getUser_id();
		Date today = new Date(new java.util.Date().getTime());
		Diary diary= new Diary(user_id, today, 0, "eat", null, null );
		
		//다이어리 전환 전, 목표정보 있는지 확인
		/* 목표관리페이지 아직 미완성
		 * Goal goal; goal = diaryService.selectCurrentGoal(diary); //1달이내 정보조회
		 * if(goal==null || goal.getGoal_date().before(today)) { //조회값이 없거나, 목표일이 끝났을때
		 * redirect.addFlashAttribute("diary", diary);
		 * redirect.addFlashAttribute("message", "목표정보가 없습니다. 목표를 설정해주세요"); return
		 * "redirect:diary_showGoalWrite.do"; //목표작성화면으로 이동 }
		 */
		
		//식단 다이어리화면으로 이동
		redirect.addFlashAttribute("diary", diary);
		return "redirect:diary_showEatDiary.do";
	}
	
	//다이어리 화면내 id, date, category 정보로 다이어리간 이동
	@RequestMapping(value="diary_moveDiary.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String showMoveDiary( RedirectAttributes redirect, Diary diary) {
		//diary 정보 없을때 test용 날짜값 변경
		logger.info(diary.toString());
		if(diary.getDiary_post_date()==null) {			
			diary.setDiary_post_date(java.sql.Date.valueOf("2023-03-01"));
			diary.setUser_id("dd");
			diary.setDiary_category("eat");
		}
		redirect.addFlashAttribute("diary", diary);
		
		//카테고리별 이동
		if(diary.getDiary_category()==null || 
			diary.getDiary_category().equals("eat")){
			return "redirect:diary_showEatDiary.do";
		}else if(diary.getDiary_category().equals("act")){
			return "redirect:diary_showActDiary.do";
		}else{
			return "redirect:diary_showBodyDiary.do";
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


//	@RequestMapping ("diary.do")
//	public String moveStatsMethod(){
//		return "diary/stats/actStats";
//	}


}//controller
