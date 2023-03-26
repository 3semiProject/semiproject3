package org.sixpack.semi.diary.model.service;

import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.model.vo.Diary;

public interface DiaryService {

	int insertDiary(Diary diary);

	Act selectOneDiary(Diary diary);

	int deleteOneDiary(Diary diary);
}
