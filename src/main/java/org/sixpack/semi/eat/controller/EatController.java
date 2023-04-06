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
	public ModelAndView showEatDiary(ModelAndView mv, 
			Diary diary, HttpSession session) {
		//다이어리 조회, 없어도 기본정보전달
		 //화면출력을 위한 memo,image
		Diary selectD = diaryService.selectOneDiary(diary);
		if(selectD !=null) {
			mv.addObject("diary", selectD);			
		}else{			
			mv.addObject("diary", diary);
		}
		
		//test : 비로그인시에도 화면 확인 //원래는 로그인화면으로 이동해야함
		if(diary.getUser_id()==null) {
			String user_id ="dd"; 
			Date today = java.sql.Date.valueOf("2023-03-01");
			diary.setUser_id(user_id);
			diary.setDiary_post_date(today);
			mv.addObject("diary", diary);
		}
		
		//목표정보, 날짜정보 조회 없어도 내보냄, 빈칸출력
		Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
		mv.addObject("goal", goal);
		mv.addObject("week", week);
		
		//식단정보 조회 있을때만 내보냄
		Goal cal = diaryService.selectCurrentGoal(diary);//diary날짜기준 계산용
		ArrayList<Diary> diarys = diaryService.selectDayDiary(diary); // 화면출력을 위한 memo,image
		ArrayList<Eat> eats = eatService.selectDayEats(diary); //하루치 식단다이어리 모두
		ArrayList<Eat> sums = eatService.selectSumAllEats(diary); //각 식단별 합계
		
		if(goal!=null && cal!=null && diarys!=null && eats!=null && sums!=null) {			
		mv.addObject("cal", cal);
		mv.addObject("diarys", diarys);
		mv.addObject("eats", eats);
		mv.addObject("sums", sums);		
		}
		mv.setViewName("diary/eat/eatDiary");
	return mv;		
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
