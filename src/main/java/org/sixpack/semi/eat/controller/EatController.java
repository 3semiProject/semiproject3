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
	LoggerFactory.getLogger(DiaryController.class);	
	
	//식단다이어리 화면출력용 : diary 필수
	@RequestMapping(value="diary_showEatDiary.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView showEatDiary(ModelAndView mv, Diary diary, Goal goal,	
		ArrayList<DateData> week,ArrayList<Diary> diarys, ArrayList<Eat> eats, ArrayList<Eat> sums, Eat total) {
		//test용 data입력
		
			diary.setUser_id("USER01");
			diary.setDiary_post_date(new Date(2023-1900,3-1,4));
			diary.setDiary_category("eat");			
		
		//weekBar.jsp에 전달할 데이터
//		week = diaryService.selectWeekDiary(diary);	//sql문 오류
		//goalBar.jsp에 전달할 데이터
		goal = diaryService.selectGoal(diary);
		//eatDiary.jsp에 전달할 데이터
		diarys = diaryService.selectDayDiary(diary);
		sums = eatService.selectSumAllEats(diary);
		eats = eatService.selectDayEats(diary);
//		int kcal=0, carbo=0, protein=0, fat=0;
//		for(Eat e : sums) {
//			kcal +=e.getEat_kcal();
//			carbo += e.getEat_carbohydrate();
//			protein += e.getEat_protein();
//			fat += e.getEat_fat();
//		}
//		total.setEat_kcal(kcal); //총 섭취 kcal :
//		total.setEat_carbohydrate(carbo); //총 탄수화물 섭취량g
//		total.setEat_protein(protein); //총 단백질 섭취량g
//		total.setEat_fat(fat); //총 지방 섭취량g	
		
		mv.addObject("diary", diary);
		mv.addObject("diarys", diarys);
//		mv.addObject("week", week);		//sql문 오류
		mv.addObject("goal", goal);
		mv.addObject("eats", eats);
		mv.addObject("sums", sums);		
//		mv.addObject("total", total);		
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
			HttpSession session,Diary diary,
			@RequestParam Date diary_post_date) {
		
		diary.setUser_id(session.getAttribute("user_id").toString());
		diary.setDiary_post_date(diary_post_date);
		diary.setDiary_category("eat");
		
		//test용 입력값
		if(session == null) {
		System.out.println("test용 입력값");
		diary.setUser_id("ADMIN");
		diary = diaryService.selectOneDiary(diary);
		diary.setDiary_category("eat");
		diary.setDiary_post_date(Date.valueOf("2023-03-04"));
		}
		
		diary = diaryService.selectOneDiary(diary);
		
		model.addAttribute("diary", diary);
		return "redirect:diary_showEatDiary.do";
	}
	
//		if(diary!=null) {
//		//diary의 id,날짜로 해당일의 모든 다이어리 조회
//		diarys = diaryService.selectDayDiary(diary);
//		//diarys로 모든 식단다이어리 조회		
//		eats = eatService.selectDayEat(diary);
//		//식단별 합계값 조회
//		sums = eatService.selectSumAllEat(diary);
//		}
//		//하루 총 섭취량 계산
//		int kcal=0, carbo=0, protein=0, fat=0;
//		for(Eat e : sums) {
//			kcal +=e.getEat_kcal();
//			carbo += e.getEat_carbohydrate();
//			protein += e.getEat_protein();
//			fat += e.getEat_fat();
//		
//		total.setEat_kcal(kcal); //총 섭취 kcal :
//		total.setEat_carbohydrate(carbo); //총 탄수화물 섭취량g
//		total.setEat_protein(protein); //총 단백질 섭취량g
//		total.setEat_fat(fat); //총 지방 섭취량g		
//		
//		
//		
//		if(eats !=null && eats.size()>0) {
//			mv.addObject("diarys", diarys);
//			mv.addObject("eats", eats);
//			mv.addObject("sums", sums);
//			mv.addObject("total", total);
//		}else {
//			mv.addObject("message","다이어리 조회 실패");
//			mv.setViewName("common/error");
//		}
//	}
	
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
