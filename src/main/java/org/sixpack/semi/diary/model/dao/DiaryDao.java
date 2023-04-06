package org.sixpack.semi.diary.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Food;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("diaryDao")
public class DiaryDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public Goal selectlastGoal(Diary diary) {
		return session.selectOne("diaryMapper.selectlastGoal",diary);
	}
    public Goal selectGoal(Diary diary) {
        return session.selectOne("diaryMapper.selectGoal", diary);
    }

	public Goal selectCurrentGoal(Diary diary) {
		return session.selectOne("diaryMapper.selectCurrentGoal",diary);
	}

    public ArrayList<Diary> selectWeekDiary(Diary diary) {
        List<Diary> list = session.selectList("diaryMapper.selectWeekDiary", diary);
        return (ArrayList<Diary>) list;
    }

    public Diary selectOneDiary(Diary diary) {
        return session.selectOne("diaryMapper.selectOneDiary", diary);
    }

    public ArrayList<Diary> selectDayDiary(Diary diary) {
        List<Diary> list = session.selectList("diaryMapper.selectDayDiary", diary);
        return (ArrayList<Diary>) list;

	}
	public Diary selectMoveDiary(DateData move) {
		return session.selectOne("diaryMapper.selectMoveDiary", move);
	}



	
    public int insertFoodData(List<Food> datalist) {
        return session.update("insertDataMapper.insertFood", datalist);
    }

    public int insertMoveData(List<Move> datalist) {
        return session.update("insertDataMapper.insertMove", datalist);
    }
}
