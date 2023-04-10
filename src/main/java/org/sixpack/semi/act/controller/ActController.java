package org.sixpack.semi.act.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.act.model.service.ActService;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("actCon")
public class ActController {
	private static final Logger logger = 
	LoggerFactory.getLogger(ActController.class);	

	@Autowired
	private ActService actService;
	@Autowired
	private DiaryService diaryService;
	//로그객체 생성구문 넣어야함

	//운동다이어리 화면출력용
	@RequestMapping("diary_showActDiary.do")
	public String showActDiary(Model model, Diary diary, HttpSession session) {
	Diary move = null;
		
		//diary_no 있을때 바로이동
		if(diary.getDiary_no()>0) {
			move = diaryService.selectDiaryNo(diary.getDiary_no());
		}else {
		//diary_no없을때 id, date, category로 조회
			if(diary.getUser_id()!=null || diary.getDiary_post_date()!=null || diary.getDiary_category()!=null) {
			    move = diaryService.selectDiaryOne(diary);			
			}
		//id 없을때 비로그인 상태면 로그인 페이지로 이동
			if(session==null|| session.getAttribute("loginMember") == null) {				
				return "redirect:loginPage.do";	
			}else {
				String id =((Member)session.getAttribute("loginMember")).getUser_id();
				diary.setUser_id(id);
				diary.setUser_id("dd"); //test용
			}					
		//date 없을때 현재날짜로
			if(diary.getDiary_post_date()==null) {
	            diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
			}					
			//category 없을때 식단우선
			if(diary.getDiary_category()==null) {
				diary.setDiary_category("eat");
			}			
			//id, date, category 일치하는 diary 있는지 조회
	        move = diaryService.selectDiaryOne(diary);

			//조회된 move 없으면 그냥 빈 식단화면 띄우기
			if(move ==null) {
				logger.info("빈 운동화면 띄우기"+ diary.toString());
				move=diary;
			}
		}

		model.addAttribute("diary", move);		
		
		
		//목표정보, 날짜정보 조회 
		Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
		if(goal!=null&& week!=null) {
		model.addAttribute("goal", goal);
		model.addAttribute("week", week);
		}
		
		//운동정보 조회 있을때만 내보냄
		ArrayList<Act> acts = actService.selectDayAct(diary);
		if(acts.size()>0) {
			model.addAttribute("acts", acts);	 // 하루치 운동정보 목록
		}
		return "diary/act/actDiary";
	}
	
	//운동다이어리 작성 화면출력용
	//이전다이어리 존재하면 수정화면으로 이동(act, body)
	@RequestMapping("diary_showActWrite.do")
	public String showActWriteView(Model model, Diary diary, RedirectAttributes redirect,
			HttpSession session) {
		// 세션 객체가 null인 경우
		if (session == null) {
			// return "redirect:loginPage.do";
			diary.setUser_id("dd"); // test용
		}else {	
		// 사용자 ID가 없는 경우: 비회원은 로그인페이지, 회원은 id추출
		if (diary.getUser_id() == null) {			
				String id = ((Member) session.getAttribute("loginMember")).getUser_id();
				diary.setUser_id(id);
		}
		}
		// 다이어리 작성 날짜가 없는 경우: 현재날짜로
		if (diary.getDiary_post_date() == null) {
			java.sql.Date today = new Date(new java.util.Date().getTime());
			// today =java.sql.Date.valueOf("2023-03-01"); //test용
			diary.setDiary_post_date(today);
		}
		// 다이어리 카테고리
		diary.setDiary_category("act");

		// 이전다이어리 조회 : id, date, category
		Diary previousDiary=null;
		previousDiary = diaryService.selectDiaryOne(diary);
		
		// 이전다이어리가 존재하는 경우
		if (previousDiary !=null&&previousDiary.getDiary_no()>0) {
			model.addAttribute("message", "이미 다이어리가 존재합니다.");
			return "common/error";
		}

		//작성할 다이어리 번호 전달
			diary.setDiary_no(diaryService.getDiaryNo());
			
		model.addAttribute("diary", diary);
		return "diary/act/actWrite";
	}
	
	//운동다이어리 수정 화면출력용
	@RequestMapping("diary_showActModify.do")
	public String showActModifyView(Model model,Diary diary) {
		Diary move = null;		
		//다이어리 
		if(diary.getDiary_no()>0) {
		move = diaryService.selectDiaryNo(diary.getDiary_no());
		}
		
		//수정할 다이어리가 없으면 다이어리화면으로 이동
		if(move==null) {
			model.addAttribute("diary",diary);
			return "redirect:diary_showActDiary.do";	
		}
		
		//수정화면에 띄울값 조회
		ArrayList<Act> acts = actService.selectDayAct(move);
		if(acts !=null && acts.size()>0) {
			model.addAttribute("diary", move);
			model.addAttribute("acts", acts);
			return "diary/act/actModify";			
		}else {
			model.addAttribute("message","수정화면 다이어리 조회 실패");
			return "common/error";
		}
	}
	
	//운동이름 검색 ajax
	@RequestMapping(value="diary_searchMoveAjax.do", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String searchMoveAjax(HttpServletResponse response, 
			@RequestParam("move_name") String move_name) throws UnsupportedEncodingException{
		//post 로 request body 에 기록된 json 문자열을 꺼내서 param 변수에 저장 처리
		logger.info("diary_searchFoodAjax.do run...");
		ArrayList<Move> movelist = actService.selectSearchMovelist(move_name); //selectMoveName
		response.setContentType("application/json; charset=utf-8");

		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		for(Move move : movelist) {
			JSONObject job = new JSONObject();					
			job.put("move_code", URLEncoder.encode(move.getMove_code(), "utf-8"));
			job.put("move_name", URLEncoder.encode(move.getMove_name(), "utf-8"));
			job.put("move_met", move.getMove_met());
			job.put("move_intensity", URLEncoder.encode(move.getMove_intensity(), "utf-8"));
			jarr.add(job);
		}  //for each
		
		sendJson.put("movelist", jarr);
		//	public String 형 >> 등록된 뷰리졸버인 JsonView 로 보냄
		return sendJson.toJSONString();
	}
	
	//운동작성 요청처리용
	@RequestMapping(value="diary_insertActWrite.do", method=RequestMethod.POST)
	public ResponseEntity<String> insertActWrite(
			@RequestBody List<Act> acts){
		int result = actService.insertAllAct(acts);
		if(result <= 0) {
			return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);					
		}				
return new ResponseEntity<String>("success", HttpStatus.OK);
}
	
	//운동다이어리 삭제용
	@RequestMapping(value="diary_delAct.do", method=RequestMethod.POST)
	public String deleteActMethod(ModelAndView mv,
			@RequestParam("diary")Diary diary) {
		//삭제할 다이어리 정보를 받아와서 
		//다이어리 번호에 해당하는 act 먼저 삭제하고
		//diary도 삭제하고 결과값 받고
		//해당일의 다이어리 화면으로 돌아감
		
		int result = actService.deleteAllAct(diary);
		
		if(result > 0 && diaryService.deleteDiary(diary) > 0) {
			mv.addObject("diary",diary);
			return "redirect:diary_showActDiary.do";
		}else {
			mv.addObject("message","해당 다이어리 삭제 실패");
			return "common/error";			
		}
	}

	//운동다이어리 수정용
	@RequestMapping(value="diary_modifyAct.do", method=RequestMethod.POST)
	public String modifyActMethod(ModelAndView mv,
			@RequestParam("diary")Diary diary,
			@RequestParam("acts")ArrayList<Act> acts) {
		//수정할 다이어리 정보를 받아와서
		//기존 운동 갯수가 많았다면 삭제하고
		//acts 수정하고
		//diary의 내용도 수정하고 결과값 받고
		//해당일의 다이어리 화면으로 돌아감
		
		//해당일의 기존 운동을 조회
		//입력된 acts.size보다 많으면 뒤쪽 순번운동은 삭제
		ArrayList<Act> beforeActs = actService.selectDayAct(diary);
		int updateSize = acts.size();
		int beforeSize = beforeActs.size();

		if (beforeSize > updateSize) {
			int deleteCount = 0;
			for (int i = updateSize; i < beforeSize; i++) {
				deleteCount += actService.deleteOneAct(beforeActs.get(i));
			}
			// logger로 삭제한 행갯수 deleteCount 확인
			if ((beforeSize - updateSize) != deleteCount) {
				mv.addObject("message","기존 다이어리 삭제 실패");
				return "common/error";	
			}
		}
		
		int updateCount = 0;
		for(Act a : acts) {
			updateCount += actService.updateOneAct(a);
		}
		
		if(updateSize == updateCount && diaryService.deleteDiary(diary) > 0) {
			mv.addObject("diary",diary);
			return "redirect:diary_showActDiary.do";
		}else {
			mv.addObject("message","해당 다이어리 삭제 실패");
			return "common/error";			
		}
		
	}

	@RequestMapping(value = "diary_actCalendar.do", method = RequestMethod.POST)
	public String moveCalendarAct(Model model, Diary diary) {
		// diary_no로 회원정보 조회 : id, category
		Diary move = null;
		if (diary.getDiary_no() > 0) {
			move = diaryService.selectDiaryNo(diary.getDiary_no());
		}
		// post_date로 이동할 날짜설정
		move.setDiary_post_date(diary.getDiary_post_date());

		// 이동할 다이어리 조회 : id, data, category
		move = diaryService.selectDiaryOne(diary);
		if(move==null) {
			model.addAttribute("diary", diary);			
		}
		model.addAttribute("diary", move);

		//목표정보, 날짜정보 조회 
		Goal goal = diaryService.selectlastGoal(move);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(move); // 일주일날짜에 대한 다이어리 정보
		model.addAttribute("goal", goal);
		model.addAttribute("week", week);
		
		//운동정보 조회 있을때만 내보냄
		ArrayList<Act> acts = actService.selectDayAct(move);
		if(acts.size()>0) {
			model.addAttribute("acts", acts);	 // 하루치 운동정보 목록
		}
		return "diary/act/actDiary";
	}
		
}