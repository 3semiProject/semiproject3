package org.sixpack.semi.diary.model.service;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.dao.DiaryDao;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Food;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("diaryService")
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	private DiaryDao diaryDao;

	@Override
	public Goal selectlastGoal(Diary diary) {
		return diaryDao.selectlastGoal(diary);
	}

	@Override
	public Goal selectGoal(Diary diary) {
		return diaryDao.selectGoal(diary);
	}
	
	@Override
	public Goal selectCurrentGoal(Diary diary) {
		return diaryDao.selectCurrentGoal(diary);
	}

	@Override
	public Diary selectOneDiary(Diary diary) {
		return diaryDao.selectOneDiary(diary);
	}

	@Override
	public ArrayList<Diary> selectDayDiary(Diary diary) {
		return diaryDao.selectDayDiary(diary);
	}

	@Override
	public int insertDiary(Diary diary) {
		return 0;
	}

	@Override
	public int updateDiary(Diary diary) {
		return 0;
	}

	@Override
	public int deleteDiary(Diary diary) {
		return 0;
	}

	@Override
	public Diary selectMoveDiary(DateData move) {
		return diaryDao.selectMoveDiary(move);
	}

	@Override
	public ArrayList<Diary> selectWeekDiary(Diary diary) {
		return diaryDao.selectWeekDiary(diary);
	}

	@Override
	public Diary selectDiaryNo(int diary_no) {
		return null;
	}


	@Override
	public int insertFoodData(List<Food> datalist) {
		return diaryDao.insertFoodData(datalist);
	}

	@Override
	public int insertMoveData(List<Move> datalist) {
		return diaryDao.insertMoveData(datalist);
	}

}
