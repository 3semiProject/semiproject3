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
    public Goal selectTodayGoal(Diary diary) {
        return diaryDao.selectTodayGoal(diary);
    }

    @Override
    public Diary selectDiaryNo(int diary_no) {
        return diaryDao.selectDiaryNo(diary_no);
    }

    @Override
    public Diary selectDiaryOne(Diary diary) {
		System.out.println("Service 1");
        return diaryDao.selectDiaryOne(diary);
    }

    @Override
    public Diary selectDiaryDate(DateData move) {
        return diaryDao.selectDiaryDate(move);
    }

    @Override
    public ArrayList<Diary> selectWeekDiary(Diary diary) {
        return diaryDao.selectWeekDiary(diary);
    }


    @Override
    public ArrayList<Diary> selectDayDiary(Diary diary) {
        return diaryDao.selectDayDiary(diary);
    }


    @Override
    public int getDiaryNo() {
        return diaryDao.getDiaryNo();
    }

    @Override
    public int insertDiary(Diary diary) {
        return diaryDao.insertDiary(diary);
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
    public int insertFoodData(List<Food> datalist) {
        return diaryDao.insertFoodData(datalist);
    }

    @Override
    public int insertMoveData(List<Move> datalist) {
        return diaryDao.insertMoveData(datalist);
    }

	@Override
	public ArrayList<Diary> selectDiary(String user_id) {
		return diaryDao.selectDiary(user_id);
	}
    @Override
    public ArrayList<Diary> selectDiaryCalendar(String user_id) {
        return diaryDao.selectDiaryCalendar(user_id);
    }


}
