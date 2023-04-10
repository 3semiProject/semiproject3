package org.sixpack.semi.goal.model.service;

import org.sixpack.semi.goal.model.dao.GoalDao;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("goalService")
public class GoalServiceImpl implements GoalService {

	@Autowired
	private GoalDao goalDao;

	@Override
	public Goal selectRecentGoal(String diary) {
		return goalDao.selectRecentGoal(diary);
	}

	@Override
	public int insertGoalInfo(Goal goal) {
		return 0;
	}

	@Override
	public int updateGoalInfo(Goal goal) {
		return 0;
	}
}
