package org.sixpack.semi.goal.model.service;

import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.stereotype.Service;

@Service("goalService")
public class GoalServiceImpl implements GoalService {

	@Override
	public Goal selectGoal(Diary diary) {
		return null;
	}

	@Override
	public Goal selectRecentGoal(Diary diary) {
		return null;
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
