package org.sixpack.semi.diary.model.vo;

import java.sql.Date;

public class DateData implements java.io.Serializable{
	private static final long serialVersionUID = -2490410401228648121L;
	
	private java.sql.Date date;	//작성일
	private String user_id;		//작성자 : 본인확인용
	private int day;			//일 : 화면출력용
	private int eats;	//식단다이어리 갯수 : 1>0이면 화면에 표시 주황
	private int acts;	//운동다이어리 갯수 : 1>0이면 화면에 표시 파랑
	private int bodys;	//체형다이어리 갯수 : 1>0이면 화면에 표시 핑크
	
	//weakbar와 calendar를 보여주기 위해 필요한 정보
	//ArrayLsit<Calendar>로 사용됨.
	
	//jsp에서 몇일인지 뽑으려면 datd에 대한 별도의 getter setter 만들어야함
	
	public DateData() {
		super();
	}
	public int getDay() {
		return this.day;
	}

	public void setDay(int day) {
		this.day = day;
	}
	public DateData(Date date, String user_id, int eats, int acts, int bodys, int day) {
		super();
		this.date = date;
		this.user_id = user_id;
		this.eats = eats;
		this.acts = acts;
		this.bodys = bodys;
		this.day = day;
	}
	public java.sql.Date getDate() {
		return date;
	}
	public void setDatek(java.sql.Date date) {
		this.date = date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getEats() {
		return eats;
	}
	public void setEats(int eats) {
		this.eats = eats;
	}
	public int getActs() {
		return acts;
	}
	public void setActs(int acts) {
		this.acts = acts;
	}
	public int getBodys() {
		return bodys;
	}
	public void setBodys(int bodys) {
		this.bodys = bodys;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

	

	
}





