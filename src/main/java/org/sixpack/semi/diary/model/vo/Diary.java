package org.sixpack.semi.diary.model.vo;

import java.sql.Date;

public class Diary implements java.io.Serializable{
	private static final long serialVersionUID = 185627232181389972L;
	
	private String user_id;					//작성자 아이디
	private java.sql.Date diary_post_date;	//작성일시
	private int diary_no;				//다이어리번호
	private String diary_catagory;				//카테고리
	private String diary_memo;				//메모
	private String diary_image;				//이미지 링크
	public Diary() {
		super();
	}	
	protected Diary(String user_id, Date diary_post_date, int diary_no, String diary_catagory, String diary_memo,
			String diary_image) {
		super();
		this.user_id = user_id;
		this.diary_post_date = diary_post_date;
		this.diary_no = diary_no;
		this.diary_catagory = diary_catagory;
		this.diary_memo = diary_memo;
		this.diary_image = diary_image;
	}

	@Override
	public String toString() {
		return "Diary [user_id=" + user_id + ", diary_post_date=" + diary_post_date + ", diary_no=" + diary_no
				+ ", diary_catagory=" + diary_catagory + ", diary_memo=" + diary_memo + ", diary_image=" + diary_image
				+ "]";
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public java.sql.Date getDiary_post_date() {
		return diary_post_date;
	}
	public void setDiary_post_date(java.sql.Date diary_post_date) {
		this.diary_post_date = diary_post_date;
	}

	public int getDiary_no() {
		return diary_no;
	}
	public void setDiary_no(int diary_no) {
		this.diary_no = diary_no;
	}
	public String getDiary_catagory() {
		return diary_catagory;
	}
	public void setDiary_catagory(String diary_catagory) {
		this.diary_catagory = diary_catagory;
	}
	public String getDiary_memo() {
		return diary_memo;
	}
	public void setDiary_memo(String diary_memo) {
		this.diary_memo = diary_memo;
	}
	public String getDiary_image() {
		return diary_image;
	}
	public void setDiary_image(String diary_image) {
		this.diary_image = diary_image;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

	

}

