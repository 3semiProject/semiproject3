package org.sixpack.semi.eat.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

@Controller("eatCon")
public class EatController {
	
	@Autowired
	private EatService eatService;
	
	@Autowired
	private DiaryService diaryService;	
	
	private static final Logger logger = 
	LoggerFactory.getLogger(EatController.class);	
	
	//식단다이어리 화면출력용
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
				logger.info("빈 식단화면 띄우기"+ diary.toString());
				move=diary;
			}
		}

		model.addAttribute("diary", move);			
		
		//목표정보, 날짜정보 조회 
		Goal goal = diaryService.selectlastGoal(move);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(move); // 일주일날짜에 대한 다이어리 정보
		if(goal!=null&& week!=null) {
		model.addAttribute("goal", goal);
		model.addAttribute("week", week);
		}
		
		//식단정보 조회
		Goal cal = diaryService.selectCurrentGoal(move);//diary날짜기준 계산용
		ArrayList<Diary> diarys = diaryService.selectDayDiary(move); // 화면출력을 위한 memo,image
		ArrayList<Eat> eats = eatService.selectDayEats(move); //하루치 식단다이어리 모두
		ArrayList<Eat> sums = eatService.selectSumAllEats(move); //각 식단별 합계 
		
		if(cal!=null && diarys!=null && eats!=null && sums!=null) {			
			model.addAttribute("cal", cal);
			model.addAttribute("diarys", diarys);
			model.addAttribute("eats", eats);
			model.addAttribute("sums", sums);		
		}
	return "diary/eat/eatDiary";		
	}
	
	//식단다이어리 작성 화면출력용
	@RequestMapping("diary_showEatWrite.do")
	public String showEatWriteView(Model mo, Diary diary) {
		//작성할 새 다이어리번호 전달
		diary.setDiary_no(diaryService.getDiaryNo());
		mo.addAttribute("diary", diary);
		return "diary/eat/eatWrite";
	}
	
	//식단다이어리 수정 화면출력용 : diary_no로 이동
	@RequestMapping("diary_showEatModify.do")
	public String showEatModify(Model model, Diary diary) {
	    //다이어리 번호가 있을 경우에만 조회
	    if(diary.getDiary_no() > 0) {
	        Diary move = diaryService.selectDiaryNo(diary.getDiary_no());
	        if(move != null) {
	            //수정화면에 띄울값 조회
	            ArrayList<Eat> eats = eatService.selectDayEats(move);
	            if(eats != null && !eats.isEmpty()) {
	                model.addAttribute("diary", move);
	                model.addAttribute("eats", eats);
	                return "diary/eat/eatModify";
	            }
	        }
	    }
		
	    //수정할 다이어리가 없으면 작성화면으로 이동
	    Diary newDiary = new Diary();
	    newDiary.setUser_id(diary.getUser_id());
	    model.addAttribute("diary", newDiary);
	    return "redirect:diary_showEatWrite.do";
	}
	
	//식단다이어리 음식이름 검색
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
	
	//식단다이어리 작성처리용
	@RequestMapping(value="diary_insertEatWrite.do", method= RequestMethod.POST)
	public ResponseEntity<String> insertEatWrite(
			@RequestBody List<Eat> eats){
				int result = eatService.insertAllEat(eats);
				if(result <= 0) {
					return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);					
				}				
	return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	//캘린더 날짜 이동용 :no, date입력 // 수정예정
	@RequestMapping(value="diary_eatCalendar.do", method= RequestMethod.POST)
	public String moveCalendarEat(Model model, 
			@RequestParam int diary_no,			
			@RequestParam String diary_post_date) {
	    // diary_no로 회원정보 조회 : id, category
	    Diary move = diaryService.selectDiaryNo(diary_no);
	    if (move == null) {
	        return "redirect:diary.do";
	    }
	    // post_date로 이동할 날짜 설정
	    move.setDiary_post_date(Date.valueOf(diary_post_date));

	    model.addAttribute("diary", move);
	    return "redirect:diary_showEatDiary.do";
	}
	
}
