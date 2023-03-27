package org.sixpack.semi.goal.model.service;

import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;

public interface GoalService {
	//해당일의 목표정보 조회
	public Goal selectGoal(Diary diary);
	//해당회원, 입력 날짜이전의 가장 최신정보 불러오기
	public Goal selectRecentGoal(Diary diary);
	
	//목표정보 입력
	public int insertGoalInfo(Goal goal);
	//목표정보 수정
	public int updateGoalInfo(Goal goal);



}
