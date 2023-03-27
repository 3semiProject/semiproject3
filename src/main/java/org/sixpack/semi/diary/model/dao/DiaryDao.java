package org.sixpack.semi.diary.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("diaryDao")
public class DiaryDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<DateData> selectWeekDiary(Diary diary) {
		List<DateData> list = session.selectList("diaryMapper.selectWeekDiary", diary);
		return (ArrayList<DateData>)list;
	}
	
	
	
}
