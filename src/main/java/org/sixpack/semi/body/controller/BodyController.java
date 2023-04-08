package org.sixpack.semi.body.controller;

import java.sql.Date;
import java.util.ArrayList;

import org.sixpack.semi.body.model.service.BodyService;
import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("bodyCon")
public class BodyController {	
	
	@Autowired
	private DiaryService diaryService;
	@Autowired
	private BodyService bodyService;
	
	//체형다이어리 화면출력용
	@RequestMapping("diary_showBodyDiary.do")
	public ModelAndView showBodyDiary(ModelAndView mv, Diary diary) {			
			if(diary.getUser_id()==null) {
				//원래는 login페이지로 이동해야함 test용임
				diary.setUser_id("dd");
				diary.setDiary_post_date(Date.valueOf("2023-03-05"));
			}
			
			//다이어리 조회, 없어도 기본정보전달
			Diary selectD = diaryService.selectOneDiary(diary);
			if(selectD !=null) {
				mv.addObject("diary", selectD);			
			}else {
				mv.addObject("diary", diary);
			}
			//목표정보, 날짜정보 조회 없어도 내보냄, 빈칸출력
			Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
			ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
			mv.addObject("goal", goal);
			mv.addObject("week", week);
			
			//체형정보 조회 있을때만 내보냄
			Body body = bodyService.selectOneBody(diary);
			Body compare = bodyService.selectCompareBody(diary);
			if(body!=null && compare!=null) {
				mv.addObject("body", body);			
				mv.addObject("compare", compare);							
			}
			
			mv.setViewName("diary/body/bodyDiary");
			return mv;			
	}
	
	//체형다이어리 작성 화면출력용
	@RequestMapping("diary_showBodyWrite.do")
	public String showBodyWriteView() {
		return "diary/body/bodyWrite";
	}
	
	//체형다이어리 수정 화면출력용
	@RequestMapping("diary_showBodyModify.do")
	public String showBodyModifyView() {
			return "diary/body/bodyModify";			
	}
}
