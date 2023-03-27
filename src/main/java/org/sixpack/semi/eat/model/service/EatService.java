package org.sixpack.semi.eat.model.service;

import java.util.ArrayList;

import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.eat.model.vo.Food;

public interface EatService {	
	
	//해당 날짜의 모든 식단조회
	ArrayList<Eat> selectDayEat(Diary diary);
	//식단별 음식 총 합계 조회
	ArrayList<Eat> selectSumAllEat(Diary diary);	
	//음식이름 검색
	Food selectFoodName(String food_name);

	//식단에 음식모두 추가
	int insertAllEat(ArrayList<Eat> eats);
	//식단에 음식모두 수정
	int updateAllEat(ArrayList<Eat> eats);
	//식단에 음식모두 삭제
	int deleteAllEat(Diary diary);
}
