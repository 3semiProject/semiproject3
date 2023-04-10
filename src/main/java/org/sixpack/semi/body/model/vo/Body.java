package org.sixpack.semi.body.model.vo;

import java.sql.Date;

public class Body implements java.io.Serializable{
	private static final long serialVersionUID = -1367031958131982741L;
	//4.10 수정 : diary_no int
	private int diary_no;				 //다이어리번호
	private String user_id;				 //작성자아이디
	private Date body_post_date;		//등록날짜
	private double body_weight;				 //체중(kg)
	private double body_fat;					 //체지방량(g)
	private double body_muscle;				 //골격근량(g)
	private double body_waistline;				 //허리둘레(cm)
	private double body_bmi;					 //계산된 bmi
	private double body_bmr;					 //계산된 bmr(kcal)
	
	public Body() {
		super();
	}

	public Body(int diary_no, String user_id, Date body_post_date, double body_weight, double body_fat,
			double body_muscle, double body_waistline, double body_bmi, double body_bmr) {
		super();
		this.diary_no = diary_no;
		this.user_id = user_id;
		this.body_post_date = body_post_date;
		this.body_weight = body_weight;
		this.body_fat = body_fat;
		this.body_muscle = body_muscle;
		this.body_waistline = body_waistline;
		this.body_bmi = body_bmi;
		this.body_bmr = body_bmr;
	}

	@Override
	public String toString() {
		return "Body [diary_no=" + diary_no + ", user_id=" + user_id + ", body_post_date=" + body_post_date
				+ ", body_weight=" + body_weight + ", body_fat=" + body_fat + ", body_muscle=" + body_muscle
				+ ", body_waistline=" + body_waistline + ", body_bmi=" + body_bmi + ", body_bmr=" + body_bmr + "]";
	}

	public int getDiary_no() {
		return diary_no;
	}

	public void setDiary_no(int diary_no) {
		this.diary_no = diary_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getBody_post_date() {
		return body_post_date;
	}

	public void setBody_post_date(Date body_post_date) {
		this.body_post_date = body_post_date;
	}

	public double getBody_weight() {
		return body_weight;
	}

	public void setBody_weight(double body_weight) {
		this.body_weight = body_weight;
	}

	public double getBody_fat() {
		return body_fat;
	}

	public void setBody_fat(double body_fat) {
		this.body_fat = body_fat;
	}

	public double getBody_muscle() {
		return body_muscle;
	}

	public void setBody_muscle(double body_muscle) {
		this.body_muscle = body_muscle;
	}

	public double getBody_waistline() {
		return body_waistline;
	}

	public void setBody_waistline(double body_waistline) {
		this.body_waistline = body_waistline;
	}

	public double getBody_bmi() {
		return body_bmi;
	}

	public void setBody_bmi(double body_bmi) {
		this.body_bmi = body_bmi;
	}

	public double getBody_bmr() {
		return body_bmr;
	}

	public void setBody_bmr(double body_bmr) {
		this.body_bmr = body_bmr;
	}
	

}
