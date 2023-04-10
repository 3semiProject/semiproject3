package org.sixpack.semi.diary.model.service;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Food;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.stereotype.Service;

public interface DiaryService {
	//가장마지막 goal 조회
	public Goal selectlastGoal(Diary diary);
	//기준일로 goal 조회
	public Goal selectGoal(Diary diary);
	//한달이내 goal 최신값 조회
	public Goal selectCurrentGoal(Diary diary);

	//다이어리 이동용
	Diary selectDiaryNo(int diary_no); 
	public Diary selectDiaryOne(Diary diary); //id, date, category
	public Diary selectDiaryDate(DateData move); //id, date, category
	
	// 하루치 모든 다이어리 조회 : 식단일 때
	ArrayList<Diary> selectDayDiary(Diary diary);

	// 기간별 다이어리 보기 : 캘린더, 주간이동바
	//ArrayList<Calendar> selectPeriodAct(Period period);

	//오늘기준 앞뒤로 일주일 diary 조회
	ArrayList<Diary> selectWeekDiary(Diary diary);
	
	
	// 다이어리 생성
	int insertDiary(Diary diary);

	// 다이어리 수정
	public int updateDiary(Diary diary);

	// 다이어리 삭제
	public int deleteDiary(Diary diary);

	


	int insertFoodData(List<Food> datalist);

	int insertMoveData(List<Move> datalist);
	
	//시퀀스로 생성할 diary_no 받아오기
	public int getDiaryNo();
}