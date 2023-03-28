package org.sixpack.semi.goal.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.service.GoalService;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("goalCon")
public class GoalController {

	@Autowired
	private GoalService goalService;
	@Autowired
	private DiaryServiceImpl diaryService;
	//로그객체 생성구문 넣어야함
	
	//목표바 출력용
	@RequestMapping("diary_showGoalBar.do")
	public String showGoalBar(ModelAndView mv,
			@RequestParam(value="diary", required=false) Diary diary,
			HttpServletRequest request, Goal goal, Date today) {
		
		//해당일 목표값 조회
		goal = goalService.selectGoal(diary);
		if(goal ==null) {
			//없으면 해당일 기준 가장 최신 목표값 조회해서 오늘날짜로 생성, 다시조회해서 출력
			goal = goalService.selectRecentGoal(diary);
			goal.setGoal_date(today);
			int result = goalService.insertGoalInfo(goal);
			goal = goalService.selectGoal(diary);
		}
		mv.addObject("goal",goal);
		return "diary/common/goalBar";
	}
	
	//목표관리 화면출력용
	@RequestMapping("diary_showGoalView.do")
	public String showGoalView(ModelAndView mv,
			@RequestParam(value="diary", required=false) Diary diary,
			HttpServletRequest request, Date today, Goal goal) {
		//현재날짜기준 가장 최신 정보
		
//		if(diary.getUser_id() == null) {
//		String userid = (String) request.getAttribute("userid");
//		diary.setUser_id(userid);
//		}
//		
//		if(diary.getDiary_post_date() ==null){
//			diary.setDiary_post_date(today);
//		}
//		
//		goal = goalService.selectRecentGoal(diary);
		
		return "diary/goal/goalView";
	}
	
	//목표관리 수정 화면출력용
	@RequestMapping("diary_showGoalModify.do")
	public String showGoalModify(ModelAndView mv,
			@RequestParam(value="diary", required=false) Diary diary,
			HttpServletRequest request, Date today, Goal goal)  {
		
		if(goalService.insertGoalInfo(goal) > 0) {
			mv.addObject("goal",goal);
			return "diary/goal/goalModify";		
		}else {
			mv.addObject("message", "목표관리 수정화면 전환 실패");
			return "common/error";		
		}
	}
}
