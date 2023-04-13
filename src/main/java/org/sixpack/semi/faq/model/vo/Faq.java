package org.sixpack.semi.faq.model.vo;

import java.sql.Date;

public class Faq {

	private int faq_no;				//FAQ 글번호
	private String faq_title;		//FAQ 제목
	private String user_id;			//FAQ 작성자
	private Date faq_post_date;		//FAQ 작성일
	private int faq_views;			//FAQ 조회수
	private String faq_content;		//FAQ 글내용
	private String faq_cat;			//FAQ 카테고리
	
	public Faq() {
		super();
	}

	public Faq(int faq_no, String faq_title, String user_id, Date faq_post_date, int faq_views, String faq_content,
			String faq_cat) {
		super();
		this.faq_no = faq_no;
		this.faq_title = faq_title;
		this.user_id = user_id;
		this.faq_post_date = faq_post_date;
		this.faq_views = faq_views;
		this.faq_content = faq_content;
		this.faq_cat = faq_cat;
	}

	public int getFaq_no() {
		return faq_no;
	}

	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}

	public String getFaq_title() {
		return faq_title;
	}

	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getFaq_post_date() {
		return faq_post_date;
	}

	public void setFaq_post_date(Date faq_post_date) {
		this.faq_post_date = faq_post_date;
	}

	public int getFaq_views() {
		return faq_views;
	}

	public void setFaq_views(int faq_views) {
		this.faq_views = faq_views;
	}

	public String getFaq_content() {
		return faq_content;
	}

	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}

	public String getFaq_cat() {
		return faq_cat;
	}

	public void setFaq_cat(String faq_cat) {
		this.faq_cat = faq_cat;
	}

	@Override
	public String toString() {
		return "Faq [faq_no=" + faq_no + ", faq_title=" + faq_title + ", user_id=" + user_id + ", faq_post_date="
				+ faq_post_date + ", faq_views=" + faq_views + ", faq_content=" + faq_content + ", faq_cat=" + faq_cat
				+ "]";
	}


	
	

}
