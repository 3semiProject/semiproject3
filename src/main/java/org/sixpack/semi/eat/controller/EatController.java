package org.sixpack.semi.eat.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.service.EatService;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.eat.model.vo.Food;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("eatCon")
public class EatController {
	private static final Logger logger = 
	LoggerFactory.getLogger(EatController.class);	
	
	@Autowired
	private EatService eatService;
	
	@Autowired
	private DiaryService diaryService;	
		
	//1. 식단다이어리 화면출력용
	@RequestMapping(value="diary_showEatDiary.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String showEatDiary(Model model, Diary diary, HttpSession session) {		
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
			}					
		//date 없을때 현재날짜로
			if(diary.getDiary_post_date()==null) {
	            diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
			}					
			//category
			diary.setDiary_category("eat");
					
			//id, date, category 일치하는 diary 있는지 조회
	        move = diaryService.selectDiaryOne(diary);

			//조회된 move 없으면 그냥 빈 식단화면 띄우기
			if(move !=null) {
				logger.info("빈 식단화면 띄우기"+ diary.toString());
				diary=move;
			}
		}

		model.addAttribute("diary", diary);			
		
		//목표정보, 날짜정보 조회 
		Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
		if(goal!=null&& week!=null) {
		model.addAttribute("goal", goal);
		model.addAttribute("week", week);
		}
		
		//식단정보 조회
		Goal cal = diaryService.selectCurrentGoal(diary);//diary날짜기준 계산용
		ArrayList<Diary> diarys = diaryService.selectDayDiary(diary); // 화면출력을 위한 memo,image
		ArrayList<Eat> eats = eatService.selectDayEats(diary); //하루치 식단다이어리 모두
		ArrayList<Eat> sums = eatService.selectSumAllEats(diary); //각 식단별 합계 
		
		if(cal!=null && diarys!=null && eats!=null && sums!=null) {			
			model.addAttribute("cal", cal);
			model.addAttribute("diarys", diarys);
			model.addAttribute("eats", eats);
			model.addAttribute("sums", sums);		
		}
	return "diary/eat/eatDiary";		
	}
	
	//2. 식단다이어리 작성 화면출력용
	@RequestMapping(value="diary_showEatWrite.do", method= {RequestMethod.POST, RequestMethod.GET} )
	public String showEatWriteView(Model model, HttpSession session) {
		//식단다이어리 작성 화면출력용 :diary번호 없어도 됨.
			//작성할 새 다이어리번호 전달
			//diary_no 있을때 바로이동
			Diary diary = new Diary();

			//id 없을때 비로그인 상태면 로그인 페이지로 이동
				if(session==null|| session.getAttribute("loginMember") == null) {				
					return "redirect:loginPage.do";	
				}				

		//작성할 새 다이어리번호 전달
		int number = diaryService.getDiaryNo();
		model.addAttribute("diary_no", number);
		return "diary/eat/eatWrite";
	}	
	
	//3. 식단다이어리 수정 화면출력용 : diary_no로 이동
	@RequestMapping(value="diary_showEatModify.do", method= {RequestMethod.POST, RequestMethod.GET} )
	public String showEatModify( Model model, @RequestParam("diary_no") int diary_no) {
		if(diary_no ==0) {
			return "redirect:diary_showEatWrite.do";
		}
		
	    //다이어리 번호가 있을 경우에만 조회
	        Diary move = diaryService.selectDiaryNo(diary_no);
	        ArrayList<Eat> eats = eatService.selectDayEats(move);
	            if(eats != null && !eats.isEmpty()) {
	                model.addAttribute("diary", move);
	                model.addAttribute("eats", eats);
	            }
         return "diary/eat/eatModify";
	}
	
	//4. 식단다이어리 음식이름 검색
	@RequestMapping(value="diary_searchFoodAjax.do", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String searchFoodAjax(HttpServletResponse response, 
			@RequestParam("food_name") String food_name) throws UnsupportedEncodingException{
		//post 로 request body 에 기록된 json 문자열을 꺼내서 param 변수에 저장 처리
		logger.info("diary_searchFoodAjax.do run...");
		ArrayList<Food> foodlist = eatService.selectSearchFoodlist(food_name);
		response.setContentType("application/json; charset=utf-8");

		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		for(Food food : foodlist) {
			JSONObject job = new JSONObject();					
			job.put("food_code", URLEncoder.encode(food.getFood_code(), "utf-8"));
			job.put("food_name", URLEncoder.encode(food.getFood_name(), "utf-8"));
			job.put("food_kcal", food.getFood_kcal());
			job.put("food_carbohydrate", food.getFood_carbohydrate());
			job.put("food_protein", food.getFood_protein());
			job.put("food_fat", food.getFood_protein());
			jarr.add(job);
		}  //for each
		
		sendJson.put("foodlist", jarr);
		//	public String 형 >> 등록된 뷰리졸버인 JsonView 로 보냄
		return sendJson.toJSONString();
	}
	
	//5. 식단다이어리 작성처리용
	@RequestMapping(value="diary_insertEatWrite.do", method= RequestMethod.POST)
	@ResponseBody
	public void insertEatWrite(HttpServletResponse response,
			@RequestBody List<Eat> eats) throws IOException{
	//시퀀스 설정
		for (int i = 0; i < eats.size(); i++) {
			eats.get(i).setEat_seq(i);
		}
		
	//insert 후 결과값 전달
		int result = eatService.insertAllEat(eats);
		if (result <= 0) {
			response.getWriter().append("fail").flush();
		}
		response.getWriter().append("ok").flush();
	}

	//6.기존 식단 다이어리 1개 eat 삭제처리용
	@RequestMapping("diary_deleteOneEat.do")
	@ResponseBody
	public void deleteOneEat(HttpServletResponse response,
			 RedirectAttributes redirect,
			 Eat deleteEat) throws IOException{
		//diary_no와 seq일치하는 Eat 삭제
		if( eatService.deleteEatOverSeq(deleteEat)>0) {
			response.getWriter().append("ok").flush();
		}
		response.getWriter().append("fail").flush();		
	}
	
	//7.식단 다이어리 전체삭제처리용
	@RequestMapping(value="diary_deleteEatDiary.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String deleteAllEat( RedirectAttributes redirect, 
			int diary_no) {
		Diary move = diaryService.selectDiaryNo(diary_no);
		if(move!=null) {			
			diaryService.deleteDiary(diary_no);
			eatService.deleteAllEat(diary_no);			
		}
		    redirect.addFlashAttribute("diary", move);
		    return "redirect:diary_showEatDiary.do";    
	}
	 
	//8. 날짜 이동용 :현재no, 이동할date입력
	@RequestMapping(value="diary_eatCalendar.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String moveCalendarEat( RedirectAttributes redirect, 
			@RequestParam int no,			
			@RequestParam Date movedate) {
		
	    // diary_no로 회원정보 조회 : id, category
	    Diary move = diaryService.selectDiaryNo(no);
	    //이동할 날짜 설정
	    move.setDiary_post_date(movedate);

	    redirect.addFlashAttribute("diary", move);
	    return "redirect:diary_showEatDiary.do";
	}

	
	/*
	 * //9.식단다이어리 1개 삭제처리용
	 * 
	 * @RequestMapping(value="diary_deleteOneEat.do", method=
	 * {RequestMethod.GET,RequestMethod.POST}) public void
	 * deleteOneEat(HttpServletResponse response, Eat deleteEat) {
	 * 
	 * if(eatService.deleteOneEat(deleteEat)>0) { response.add }
	 * 
	 * }
	 */
	
}
