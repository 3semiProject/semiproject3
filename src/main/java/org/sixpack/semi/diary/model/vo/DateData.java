package org.sixpack.semi.diary.model.vo;

import java.sql.Date;

public class DateData implements java.io.Serializable{
	private static final long serialVersionUID = -2490410401228648121L;
	
	private java.sql.Date post_date;	//기준이되는 다이어리날짜
	private String user_id;		//작성자 : 본인확인용
	private int ago;	//기준일로 몇일 전인지, 몇일 뒤인지
	
	//weakbar와 calendar를 보여주기 위해 필요한 정보
	
	public DateData() {
		super();
	}

	public DateData(Date post_date, String user_id, int ago) {
		super();
		this.post_date = post_date;
		this.user_id = user_id;
		this.ago = ago;
	}

	public java.sql.Date getPost_date() {
		return post_date;
	}

	public void setPost_date(java.sql.Date post_date) {
		this.post_date = post_date;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getAgo() {
		return ago;
	}

	public void setAgo(int ago) {
		this.ago = ago;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "DateData [post_date=" + post_date + ", user_id=" + user_id + ", ago=" + ago + "]";
	}


	

	

	
}





