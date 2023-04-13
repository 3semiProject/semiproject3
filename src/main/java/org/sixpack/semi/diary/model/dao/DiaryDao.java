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
        return session.selectOne("diaryMapper.selectlastGoal", diary);
    }

    public Goal selectGoal(Diary diary) {
        return session.selectOne("diaryMapper.selectGoal", diary);
    }

    public Goal selectCurrentGoal(Diary diary) {
        return session.selectOne("diaryMapper.selectCurrentGoal", diary);
    }

    public Goal selectTodayGoal(Diary diary) {
        return session.selectOne("diaryMapper.selectTodayGoal", diary);
    }

    public ArrayList<Diary> selectDayDiary(Diary diary) {
        List<Diary> list = session.selectList("diaryMapper.selectDayDiary", diary);
        return (ArrayList<Diary>) list;

    }


    //다이어리 작성
    public int getDiaryNo() {
        return session.selectOne("diaryMapper.getDiaryNo");
    }

    public int insertDiary(Diary diary) {
        return session.insert("diaryMapper.insertDiary", diary);
    }

    //다이어리 이동
    public Diary selectDiaryNo(int diary_no) {
        return session.selectOne("diaryMapper.selectDiaryNo", diary_no);
    }

    public Diary selectDiaryOne(Diary diary) {
		System.out.println("Dao 1");
        return session.selectOne("diaryMapper.selectDiaryOne", diary);
    }

    public Diary selectDiaryDate(DateData move) {
        return session.selectOne("diaryMapper.selectDiaryDate", move);
    }

    public ArrayList<Diary> selectWeekDiary(Diary diary) {
        List<Diary> list = session.selectList("diaryMapper.selectWeekDiary", diary);
        return (ArrayList<Diary>) list;
    }
    
    public int updateDiaryTime(Diary timeDiary) {
		return session.update("diaryMapper.updateDiaryTime", timeDiary);
	}


    public int insertFoodData(List<Food> datalist) {
        return session.update("insertDataMapper.insertFood", datalist);
    }

    public int insertMoveData(List<Move> datalist) {
        return session.update("insertDataMapper.insertMove", datalist);
    }
    
	public ArrayList<Diary> selectDiary(String user_id) {
		List<Diary> list = session.selectList("diaryMapper.selectDiary", user_id);
        return (ArrayList<Diary>) list;
	}


    public ArrayList<Diary> selectDiaryCalendar(String user_id) {
        List<Diary> list = session.selectList("diaryMapper.selectDiaryCalendar", user_id);
        return (ArrayList<Diary>) list;

    }
}
