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

    public Goal selectGoal(Diary diary) {
        return session.selectOne("diaryMapper.selectGoal", diary);
    }

    public ArrayList<DateData> selectWeekDiary(Diary diary) {
        List<DateData> list = session.selectList("diaryMapper.selectWeekDiary", diary);
        return (ArrayList<DateData>) list;
    }

    public Diary selectOneDiary(Diary diary) {
        return session.selectOne("diaryMapper.selectOneDiary", diary);
    }

    public ArrayList<Diary> selectDayDiary(Diary diary) {
        List<Diary> list = session.selectList("diaryMapper.selectDayDiary", diary);
        return (ArrayList<Diary>) list;

    }


    public int insertFoodData(List<Food> datalist) {
        return session.update("insertDataMapper.insertFood", datalist);
    }

    public int insertMoveData(List<Move> datalist) {
        return session.update("insertDataMapper.insertMove", datalist);
    }
}
