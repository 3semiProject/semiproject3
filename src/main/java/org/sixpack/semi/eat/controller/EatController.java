package org.sixpack.semi.eat.controller;

import java.util.ArrayList;

import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.controller.DiaryController;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.service.EatService;
import org.sixpack.semi.eat.model.vo.Eat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("eatCon")
public class EatController {
	
	@Autowired
	private EatService eatService;
	
	private static final Logger logger = 
	LoggerFactory.getLogger(DiaryController.class);	
	@Autowired
	private DiaryService diaryService;	
	
	
	//식단다이어리 화면출력용
	@RequestMapping("diary_showEatDiary.do")
	public String showEatDiary() {
		return "diary/eat/eatDiary";			
	}
	
	//diary 전달값은 없을 수 없음. userid와 날짜라도 받아야함.
	public String show(ModelAndView mv,
			@RequestParam(value="diary", required=false) Diary diary, 
			ArrayList<Diary> diarys, ArrayList<Eat> eats, ArrayList<Eat> sums,
			Eat total) {		
		
		if(diary!=null) {
		//diary의 id,날짜로 해당일의 모든 다이어리 조회
		diarys = diaryService.selectDayDiary(diary);
		//diarys로 모든 식단다이어리 조회		
		eats = eatService.selectDayEat(diary);
		//식단별 합계값 조회
		sums = eatService.selectSumAllEat(diary);
		
		//하루 총 섭취량 계산
		int kcal=0, carbo=0, protein=0, fat=0;
		for(Eat e : sums) {
			kcal +=e.getEat_kcal();
			carbo += e.getEat_carbohydrate();
			protein += e.getEat_protein();
			fat += e.getEat_fat();
		}
		total.setEat_kcal(kcal); //총 섭취 kcal :
		total.setEat_carbohydrate(carbo); //총 탄수화물 섭취량g
		total.setEat_protein(protein); //총 단백질 섭취량g
		total.setEat_fat(fat); //총 지방 섭취량g		
		
		
		if(eats !=null && eats.size()>0) {
			mv.addObject("diarys", diarys);
			mv.addObject("eats", eats);
			mv.addObject("sums", sums);
			mv.addObject("total", total);
			return "diary/eat/eatDiary";
		}else {
			mv.addObject("message","다이어리 조회 실패");
			return "common/error";
		}
		}else {
			return "diary/eat/eatDiary";			
		}
		
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
