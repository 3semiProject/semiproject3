package org.sixpack.semi.goal.model.vo;

import java.sql.Date;

public class Goal {
	
	private Date goal_date;			// 등록날짜(매일)
	private Date goal_end_date;		// 목표 종료일
	private int goal_activity;		// 에너지 요구량
	private int goal_height;		// 키(cm)
	private int goal_current_weight;// 현재 체중(kg)
	private int goal_standard_weight;// 표준 체중(kg)
	private int goal_target_weight;	// 목표체중(kg)
	
	protected Goal() {
		super();
	}

	protected Goal(Date goal_date, Date goal_end_date, int goal_activity, int goal_height, int goal_current_weight,
			int goal_standard_weight, int goal_target_weight) {
		super();
		this.goal_date = goal_date;
		this.goal_end_date = goal_end_date;
		this.goal_activity = goal_activity;
		this.goal_height = goal_height;
		this.goal_current_weight = goal_current_weight;
		this.goal_standard_weight = goal_standard_weight;
		this.goal_target_weight = goal_target_weight;
	}	

	@Override
	public String toString() {
		return "GoalInfo [goal_date=" + goal_date + ", goal_end_date=" + goal_end_date + ", goal_activity="
				+ goal_activity + ", goal_height=" + goal_height + ", goal_current_weight=" + goal_current_weight
				+ ", goal_standard_weight=" + goal_standard_weight + ", goal_target_weight=" + goal_target_weight + "]";
	}

	public Date getGoal_date() {
		return goal_date;
	}

	public void setGoal_date(Date goal_date) {
		this.goal_date = goal_date;
	}

	public Date getGoal_end_date() {
		return goal_end_date;
	}

	public void setGoal_end_date(Date goal_end_date) {
		this.goal_end_date = goal_end_date;
	}

	public int getGoal_activity() {
		return goal_activity;
	}

	public void setGoal_activity(int goal_activity) {
		this.goal_activity = goal_activity;
	}

	public int getGoal_height() {
		return goal_height;
	}

	public void setGoal_height(int goal_height) {
		this.goal_height = goal_height;
	}

	public int getGoal_current_weight() {
		return goal_current_weight;
	}

	public void setGoal_current_weight(int goal_current_weight) {
		this.goal_current_weight = goal_current_weight;
	}

	public int getGoal_standard_weight() {
		return goal_standard_weight;
	}

	public void setGoal_standard_weight(int goal_standard_weight) {
		this.goal_standard_weight = goal_standard_weight;
	}

	public int getGoal_target_weight() {
		return goal_target_weight;
	}

	public void setGoal_target_weight(int goal_target_weight) {
		this.goal_target_weight = goal_target_weight;
	}
	
	
	
}
