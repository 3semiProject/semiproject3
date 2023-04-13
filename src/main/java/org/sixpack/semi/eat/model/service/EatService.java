package org.sixpack.semi.eat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.eat.model.vo.Food;

public interface EatService {	
	/*다이어리 보기화면*/
	//해당 날짜의 모든 식단조회
	ArrayList<Eat> selectDayEats(Diary diary);
	//식단별 음식 총 합계 조회
	ArrayList<Eat> selectSumAllEats(Diary diary);
	
	
	/*다이어리 작성화면*/
	//ajax 음식이름으로 food목록 조회
	ArrayList<Food> selectSearchFoodlist(String food_name);
	//식단에 음식모두 추가
	int insertAllEat(List<Eat> eats);
	
	//식단 업데이트갯수 초과하는 eat_seq 삭제
	int deleteEatOverSeq(Eat eat);
	
	/*다이어리 수정화면*/
	//식단에 음식하나 추가
	int insertOneEat(Eat eat);
	//식단에 음식모두 수정
	int updateAllEat(ArrayList<Eat> eats);
	//식단에 음식모두 삭제
	int deleteAllEat(int diary_no);
	//식단에 음식하나 수정
	int updateOneEat(Eat e);
	//음식갯수 확인
	int selectEatCount(int diary_no);
	
}
