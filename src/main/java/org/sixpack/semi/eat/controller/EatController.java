package org.sixpack.semi.eat.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.sixpack.semi.diary.controller.DiaryController;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.service.EatService;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("eatCon")
public class EatController {
	
	@Autowired
	private EatService eatService;
	
	@Autowired
	private DiaryService diaryService;	
	
	private static final Logger logger = 
	LoggerFactory.getLogger(EatController.class);	
	
	//식단다이어리 화면출력용 : diary 필수
	@RequestMapping(value="diary_showEatDiary.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView showEatDiary(ModelAndView mv, Goal goal, 
			Diary diary, HttpSession session,
		ArrayList<DateData> week,ArrayList<Diary> diarys, ArrayList<Eat> eats, ArrayList<Eat> sums, Eat total) {
		logger.info("diary_showEatDiary.do 실행 :" + diary);
		if(diary.getUser_id()==null) {
		//회원id로 오늘날짜의 식단을 입력한 diary 정보만 전달
		diary.setUser_id(((Member)session.getAttribute("loginMember")).getUser_id());
			diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
			//test용 날짜값 변경
		//diary.setDiary_post_date(java.sql.Date.valueOf("2023-03-01"));
		}
		diary.setDiary_category("eat");		
		
		goal = diaryService.selectGoal(diary);//diary날짜 기준 가장최근
		week = diaryService.selectWeekDiary(diary);
		diarys = diaryService.selectDayDiary(diary);
		sums = eatService.selectSumAllEats(diary);
		eats = eatService.selectDayEats(diary);
		
		mv.addObject("diary", diary);
		mv.addObject("diarys", diarys);
		mv.addObject("week", week);
		mv.addObject("goal", goal);
		mv.addObject("eats", eats);
		mv.addObject("sums", sums);		
		mv.setViewName("diary/eat/eatDiary");
	return mv;		
	}
	
	//diary no 모름.
	//tab을 눌러서 이동할때
	//userid=session
	//날짜는 param
	//카테고리는 con에서 셋팅
	//redirect로 기본 출력용 .do를 실행하자
	@RequestMapping("diary_moveTabEat.do")
	public String moveTabEatDiary(Model model,
			HttpSession session,
			Diary diary) {
		
		//diary.setUser_id(session.getAttribute("user_id").toString());
		diary.setDiary_post_date(Date.valueOf("2023-03-02"));
		diary.setDiary_category("eat");
		
		diary = diaryService.selectOneDiary(diary);
		
		model.addAttribute("diary", diary);
		return "redirect:diary_showEatDiary.do";
	}
	
	
	//식단다이어리 작성 화면출력용
	@RequestMapping("diary_showEatWrite.do")
	public String showEatWriteView() {
		//어떤날짜에 누가 작성할지를 전달받고 전달해야함
		return "diary/eat/eatWrite";
	}
	
	//식단다이어리 수정 화면출력용
	@RequestMapping("diary_showEatModify.do")
	public String showEatModify() {
		return "diary/eat/eatModify";
	}

	
}
