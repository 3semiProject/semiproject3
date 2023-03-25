package org.sixpack.semi.banner.model.vo;

import java.sql.Date;

public class Banner {

	private int number_no;
	private String user_id;
	private Date banner_post_date;
	private Date banner_last_post_date;
	private String banner_title;
	private String banner_item;
	private String banner_link_adrress;
	private String banner_img;
	
	public Banner() {
		super();
	}

	public Banner(int number_no, String user_id, Date banner_post_date, Date banner_last_post_date,
			String banner_title, String banner_item, String banner_link_adrress, String banner_img) {
		super();
		this.number_no = number_no;
		this.user_id = user_id;
		this.banner_post_date = banner_post_date;
		this.banner_last_post_date = banner_last_post_date;
		this.banner_title = banner_title;
		this.banner_item = banner_item;
		this.banner_link_adrress = banner_link_adrress;
		this.banner_img = banner_img;
	}

	public int getNumber_no() {
		return number_no;
	}

	public void setNumber_no(int number_no) {
		this.number_no = number_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getBanner_post_date() {
		return banner_post_date;
	}

	public void setBanner_post_date(Date banner_post_date) {
		this.banner_post_date = banner_post_date;
	}

	public Date getBanner_last_post_date() {
		return banner_last_post_date;
	}

	public void setBanner_last_post_date(Date banner_last_post_date) {
		this.banner_last_post_date = banner_last_post_date;
	}

	public String getBanner_title() {
		return banner_title;
	}

	public void setBanner_title(String banner_title) {
		this.banner_title = banner_title;
	}

	public String getBanner_item() {
		return banner_item;
	}

	public void setBanner_item(String banner_item) {
		this.banner_item = banner_item;
	}

	public String getBanner_link_adrress() {
		return banner_link_adrress;
	}

	public void setBanner_link_adrress(String banner_link_adrress) {
		this.banner_link_adrress = banner_link_adrress;
	}

	public String getBanner_img() {
		return banner_img;
	}

	public void setBanner_img(String banner_img) {
		this.banner_img = banner_img;
	}

	@Override
	public String toString() {
		return "AdminBanner [number_no=" + number_no + ", user_id=" + user_id + ", banner_post_date=" + banner_post_date
				+ ", banner_last_post_date=" + banner_last_post_date + ", banner_title=" + banner_title
				+ ", banner_item=" + banner_item + ", banner_link_adrress=" + banner_link_adrress + ", banner_img="
				+ banner_img + "]";
	}
	
	
}
