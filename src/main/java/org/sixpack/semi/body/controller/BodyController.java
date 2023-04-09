package org.sixpack.semi.body.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.sixpack.semi.body.model.service.BodyService;
import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("bodyCon")
public class BodyController {	
	
	@Autowired
	private DiaryService diaryService;
	@Autowired
	private BodyService bodyService;
	
	private static final Logger logger = LoggerFactory.getLogger(BodyController.class);

	//체형다이어리 화면출력용
	@RequestMapping("diary_showBodyDiary.do")
	public String showBodyDiary(Model model, Diary diary, HttpSession session) {			
		Diary move = null;
		if(diary.getDiary_no()>0) {
			move = diaryService.selectDiaryNo(diary.getDiary_no());
		}else {
			//id 없을때 : 비로그인 상태면 로그인 페이지로 이동
			if(session==null) {
				return "redirect:loginPage.do";
			}else {
				String id =((Member)session.getAttribute("loginMember")).getUser_id();
				diary.setUser_id(id);
				if(id==null) {diary.setUser_id("dd");} //test용 비로그인시에도 확인가능
			}					
			//date 없을때 현재날짜로
			if(diary.getDiary_post_date()==null) {
				Date today = new Date(new java.util.Date().getTime());
				//today =java.sql.Date.valueOf("2023-03-01"); //test용
				diary.setDiary_post_date(today);
			}					
			//category 없을때
			if(diary.getDiary_category()==null) {
				diary.setDiary_category("body");
			}			
			//id, date, category 일치하는 diary 있는지 조회
			if(!(diary.getUser_id()==null&& diary.getDiary_post_date()==null&&diary.getDiary_category()==null)) {
				move = diaryService.selectDiaryOne(diary);			
			}
			//조회된 move 없으면 그냥 빈 다이어리 화면 띄우기
			if(move ==null) {
				logger.info("빈 다이어리 화면 띄우기"+ diary.toString());
				move=diary;
			}
		}
			//목표정보, 날짜정보 조회
			Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
			ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
			if(goal!=null&& week!=null) {
				model.addAttribute("goal", goal);
				model.addAttribute("week", week);
			}
			
			//체형정보 조회 있을때만 내보냄
			Body body = bodyService.selectOneBody(diary);
			Body compare = bodyService.selectCompareBody(diary);
			if(body!=null && compare!=null) {
				model.addAttribute("body", body);			
				model.addAttribute("compare", compare);							
			}			
			return "diary/body/bodyDiary";
	}
	
	//체형다이어리 작성 화면출력용
	@RequestMapping("diary_showBodyWrite.do")
	public String showBodyWriteView(Model model, Diary diary, RedirectAttributes redirect,
			HttpSession session) {
		//이전다이어리 존재하면 수정화면으로 이동(act, body)
		Diary before=null;
		//diary_no로 회원정보 조회
		if(diary.getDiary_no()>0) {
			diary = diaryService.selectDiaryNo(diary.getDiary_no());
		}else {
			//id 없을때
			if(session==null) {
				//비로그인 상태면 로그인 페이지로 이동
				//return "redirect:loginPage.do";
				diary.setUser_id("dd"); //test용
			}else {
				String id =((Member)session.getAttribute("loginMember")).getUser_id();
				diary.setUser_id(id);
			}					
			//date 없을때 현재날짜로
			if(diary.getDiary_post_date()==null) {
				Date today = new Date(new java.util.Date().getTime());
				//today =java.sql.Date.valueOf("2023-03-01"); //test용
				diary.setDiary_post_date(today);
			}					
			//category 없을때
			if(diary.getDiary_category()==null) {
				diary.setDiary_category("eat");
			}			
			//id, date, category 일치하는 diary 있는지 조회
			if(!(diary.getUser_id()==null&& diary.getDiary_post_date()==null&&diary.getDiary_category()==null)) {
				before = diaryService.selectDiaryOne(diary);			
			}
			//이전다이어리 존재하면 수정화면으로 이동(act, body)
			if(before !=null) {
				model.addAttribute("diary",before);
				return "redirect:diary_showBodyModify.do";	
			}
		}			
			//작성할 새 다이어리번호 전달
			diary.setDiary_no(diaryService.getDiaryNo());
			model.addAttribute("diary",diary);
		return "diary/body/bodyWrite";
	}
	
	//체형다이어리 수정 화면출력용
	@RequestMapping("diary_showBodyModify.do")
	public String showBodyModifyView() {
			return "diary/body/bodyModify";			
	}
}
