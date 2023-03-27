package org.sixpack.semi.diary.model.service;

import java.util.ArrayList;

import org.sixpack.semi.diary.model.dao.DiaryDao;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("diaryService")
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	private DiaryDao diaryDao;

	@Override
	public Diary selectOneDiary(Diary diary) {
		return null;
	}

	@Override
	public ArrayList<Diary> selectDayDiary(Diary diary) {
		return null;
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
	public ArrayList<DateData> selectWeekDiary(Diary diary) {
		return diaryDao.selectWeekDiary(diary);
	}
}
