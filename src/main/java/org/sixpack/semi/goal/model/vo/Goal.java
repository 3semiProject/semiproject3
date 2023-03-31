package org.sixpack.semi.goal.model.vo;

import java.sql.Date;

public class Goal implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	//table 컬럼명 수정사항 적용.
	private String user_id;			//작성자 아이디
	private Date create_date;		// 등록날짜(매일)
	private Date goal_date;		// 목표 종료일
	private int energy_demand;		// 에너지 요구량
	private Double height;		// 키(cm)
	private Double current_weight;// 현재 체중(kg)
	private Double standard_weight;// 표준 체중(kg)
	private Double target_weight;	// 목표체중(kg)
	private int dday; //화면 d-day출력용
	
	public int getDday() {
		Long time = this.create_date.getTime()-this.goal_date.getTime();
		return (int)(time/(24*60*60*1000));
	}
	
	public Goal() {
		super();
	}

	public Goal(String user_id, Date create_date, Date goal_date, int energy_demand, Double height,
			Double current_weight, Double standard_weight, Double target_weight) {
		super();
		this.user_id = user_id;
		this.create_date = create_date;
		this.goal_date = goal_date;
		this.energy_demand = energy_demand;
		this.height = height;
		this.current_weight = current_weight;
		this.standard_weight = standard_weight;
		this.target_weight = target_weight;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public Date getGoal_date() {
		return goal_date;
	}

	public void setGoal_date(Date goal_date) {
		this.goal_date = goal_date;
	}

	public int getEnergy_demand() {
		return energy_demand;
	}

	public void setEnergy_demand(int energy_demand) {
		this.energy_demand = energy_demand;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Double getCurrent_weight() {
		return current_weight;
	}

	public void setCurrent_weight(Double current_weight) {
		this.current_weight = current_weight;
	}

	public Double getStandard_weight() {
		return standard_weight;
	}

	public void setStandard_weight(Double standard_weight) {
		this.standard_weight = standard_weight;
	}

	public Double getTarget_weight() {
		return target_weight;
	}

	public void setTarget_weight(Double target_weight) {
		this.target_weight = target_weight;
	}

	@Override
	public String toString() {
		return "Goal [user_id=" + user_id + ", create_date=" + create_date + ", goal_date=" + goal_date
				+ ", energy_demand=" + energy_demand + ", height=" + height + ", current_weight=" + current_weight
				+ ", standard_weight=" + standard_weight + ", target_weight=" + target_weight + "]";
	}
	
	

}
