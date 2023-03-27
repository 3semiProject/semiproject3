package org.sixpack.semi.diary.model.service;

import java.util.ArrayList;

import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;

public interface DiaryService {

	// 입력한 diary값과 일치하는 다이어리 하나 조회 : 조건)null인 값 제외
	Diary selectOneDiary(Diary diary);
	
	// 하루치 모든 다이어리 조회 : 식단일 때
	ArrayList<Diary> selectDayDiary(Diary diary);

	// 기간별 다이어리 보기 : 캘린더, 주간이동바
	//ArrayList<Calendar> selectPeriodAct(Period period);

	//오늘기준 앞뒤로 일주일 diary 조회
	ArrayList<DateData> selectWeekDiary(Diary diary);
	
	
	// 다이어리 생성
	int insertDiary(Diary diary);

	// 다이어리 수정
	public int updateDiary(Diary diary);

	// 다이어리 삭제
	public int deleteDiary(Diary diary);
}