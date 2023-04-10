package org.sixpack.semi.goal.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("goalDao")

public class GoalDao {

    @Autowired
    private SqlSessionTemplate session; //의존성 주입됨(DI)


    public Goal selectRecentGoal(String diary) {
        return session.selectOne("diaryMapper.selectlastGoal", diary);
    }
}
