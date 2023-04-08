package org.sixpack.semi.eat.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;

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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String showEatWriteView(Model mo, Diary diary) {
		diary.setDiary_category("eat");
		//어떤날짜에 누가 작성할지를 전달받고 전달해야함
		//test용
		if(diary.getUser_id()==null) {
			String user_id ="dd"; 
			Date today = java.sql.Date.valueOf("2023-03-01");
			diary.setUser_id(user_id);
			diary.setDiary_post_date(today);
		}
		
		int seq = diaryService.getDiaryNo();
		diary.setDiary_no(seq);
		mo.addAttribute("diary", diary);
		return "diary/eat/eatWrite";
	}
	
	//식단다이어리 수정 화면출력용
	@RequestMapping("diary_showEatModify.do")
	public String showEatModify() {
		return "diary/eat/eatModify";
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

	
}
