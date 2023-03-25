package org.sixpack.semi.bfaf.model.vo;

import java.sql.Date;

public class Bfaf implements java.io.Serializable {

	private static final long serialVersionUID = -899539095571702483L;
	
	private int bfaf_no;	//글번호	NUMBER
	private String bfaf_name;	//글제목	VARCHAR2(200 BYTE)
	private String user_id;	//작성자	VARCHAR2(50 BYTE)
	private java.sql.Date write_bfaf_date;	//작성일	DATE
	private int click_bfaf_no;	//조회수	NUMBER
	private String bfaf_value;	//글내용	VARCHAR2(4000 BYTE)
	private String originfile_bfaf;	//파일원본이름	VARCHAR2(200 BYTE)
	private String renamefile_bfaf;	//파일수정이름	VARCHAR2(200 BYTE)
	private String initlink_bfaf;	//링크저장이름	VARCHAR2(200 BYTE)
	private int bfaf_ref;	//원글참조번호	NUMBER
	private int bfaf_reply_ref;	//댓글참조번호	NUMBER
	private int bfaf_reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int bfaf_reply_seq;	//댓글순번	NUMBER
	private int bfaf_like_no; //좋아요수	NUMBER
	
	public Bfaf() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Bfaf(int bfaf_no, String bfaf_name, String user_id, Date write_bfaf_date, int click_bfaf_no,
			String bfaf_value, String originfile_bfaf, String renamefile_bfaf, String initlink_bfaf, int bfaf_ref,
			int bfaf_reply_ref, int bfaf_reply_lev, int bfaf_reply_seq, int bfaf_like_no) {
		super();
		this.bfaf_no = bfaf_no;
		this.bfaf_name = bfaf_name;
		this.user_id = user_id;
		this.write_bfaf_date = write_bfaf_date;
		this.click_bfaf_no = click_bfaf_no;
		this.bfaf_value = bfaf_value;
		this.originfile_bfaf = originfile_bfaf;
		this.renamefile_bfaf = renamefile_bfaf;
		this.initlink_bfaf = initlink_bfaf;
		this.bfaf_ref = bfaf_ref;
		this.bfaf_reply_ref = bfaf_reply_ref;
		this.bfaf_reply_lev = bfaf_reply_lev;
		this.bfaf_reply_seq = bfaf_reply_seq;
		this.bfaf_like_no = bfaf_like_no;
	}

	public int getBfaf_no() {
		return bfaf_no;
	}

	public void setBfaf_no(int bfaf_no) {
		this.bfaf_no = bfaf_no;
	}

	public String getBfaf_name() {
		return bfaf_name;
	}

	public void setBfaf_name(String bfaf_name) {
		this.bfaf_name = bfaf_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public java.sql.Date getWrite_bfaf_date() {
		return write_bfaf_date;
	}

	public void setWrite_bfaf_date(java.sql.Date write_bfaf_date) {
		this.write_bfaf_date = write_bfaf_date;
	}

	public int getClick_bfaf_no() {
		return click_bfaf_no;
	}

	public void setClick_bfaf_no(int click_bfaf_no) {
		this.click_bfaf_no = click_bfaf_no;
	}

	public String getBfaf_value() {
		return bfaf_value;
	}

	public void setBfaf_value(String bfaf_value) {
		this.bfaf_value = bfaf_value;
	}

	public String getOriginfile_bfaf() {
		return originfile_bfaf;
	}

	public void setOriginfile_bfaf(String originfile_bfaf) {
		this.originfile_bfaf = originfile_bfaf;
	}

	public String getRenamefile_bfaf() {
		return renamefile_bfaf;
	}

	public void setRenamefile_bfaf(String renamefile_bfaf) {
		this.renamefile_bfaf = renamefile_bfaf;
	}

	public String getInitlink_bfaf() {
		return initlink_bfaf;
	}

	public void setInitlink_bfaf(String initlink_bfaf) {
		this.initlink_bfaf = initlink_bfaf;
	}

	public int getBfaf_ref() {
		return bfaf_ref;
	}

	public void setBfaf_ref(int bfaf_ref) {
		this.bfaf_ref = bfaf_ref;
	}

	public int getBfaf_reply_ref() {
		return bfaf_reply_ref;
	}

	public void setBfaf_reply_ref(int bfaf_reply_ref) {
		this.bfaf_reply_ref = bfaf_reply_ref;
	}

	public int getBfaf_reply_lev() {
		return bfaf_reply_lev;
	}

	public void setBfaf_reply_lev(int bfaf_reply_lev) {
		this.bfaf_reply_lev = bfaf_reply_lev;
	}

	public int getBfaf_reply_seq() {
		return bfaf_reply_seq;
	}

	public void setBfaf_reply_seq(int bfaf_reply_seq) {
		this.bfaf_reply_seq = bfaf_reply_seq;
	}

	public int getBfaf_like_no() {
		return bfaf_like_no;
	}

	public void setBfaf_like_no(int bfaf_like_no) {
		this.bfaf_like_no = bfaf_like_no;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Bfaf [bfaf_no=" + bfaf_no + ", bfaf_name=" + bfaf_name + ", user_id=" + user_id + ", write_bfaf_date="
				+ write_bfaf_date + ", click_bfaf_no=" + click_bfaf_no + ", bfaf_value=" + bfaf_value
				+ ", originfile_bfaf=" + originfile_bfaf + ", renamefile_bfaf=" + renamefile_bfaf + ", initlink_bfaf="
				+ initlink_bfaf + ", bfaf_ref=" + bfaf_ref + ", bfaf_reply_ref=" + bfaf_reply_ref + ", bfaf_reply_lev="
				+ bfaf_reply_lev + ", bfaf_reply_seq=" + bfaf_reply_seq + ", bfaf_like_no=" + bfaf_like_no + "]";
	}
	
	
}
