package org.sixpack.semi.diary.model.service;

import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.stereotype.Service;

@Service("diaryService")
public class DiaryServiceImpl implements DiaryService {

	@Override
	public int insertDiary(Diary diary) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Act selectOneDiary(Diary diary) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteOneDiary(Diary diary) {
		// TODO Auto-generated method stub
		return 0;
	}
}
