package org.sixpack.semi.free.model.vo;

import java.sql.Date;

public class Free implements java.io.Serializable{

	private static final long serialVersionUID = -1800938506768686466L;
	
	private int free_no;	//글번호	NUMBER
	private String free_name;	//글제목	VARCHAR2(200 BYTE)
	private String user_id;	//작성자	VARCHAR2(50 BYTE)
	private java.sql.Date write_free_date;	//작성일	DATE
	private int click_free_no;	//조회수	NUMBER
	private String free_value;	//글내용	VARCHAR2(4000 BYTE)
	private String originfile_free;	//파일원본이름	VARCHAR2(200 BYTE)
	private String renamefile_free;	//파일수정이름	VARCHAR2(200 BYTE)
	private int free_ref;	//원글참조번호	NUMBER
	private int free_reply_ref;	//댓글참조번호	NUMBER
	private int free_reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int free_reply_seq;	//댓글순번	NUMBER
	private int free_like_no; //좋아요수	NUMBER
	public Free() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Free(int free_no, String free_name, String user_id, Date write_free_date, int click_free_no,
			String free_value, String originfile_free, String renamefile_free, int free_ref,
			int free_reply_ref, int free_reply_lev, int free_reply_seq, int free_like_no) {
		super();
		this.free_no = free_no;
		this.free_name = free_name;
		this.user_id = user_id;
		this.write_free_date = write_free_date;
		this.click_free_no = click_free_no;
		this.free_value = free_value;
		this.originfile_free = originfile_free;
		this.renamefile_free = renamefile_free;
		this.free_ref = free_ref;
		this.free_reply_ref = free_reply_ref;
		this.free_reply_lev = free_reply_lev;
		this.free_reply_seq = free_reply_seq;
		this.free_like_no = free_like_no;
	}
	@Override
	public String toString() {
		return "Free [free_no=" + free_no + ", free_name=" + free_name + ", user_id=" + user_id + ", write_free_date="
				+ write_free_date + ", click_free_no=" + click_free_no + ", free_value=" + free_value
				+ ", originfile_free=" + originfile_free + ", renamefile_free=" + renamefile_free 
				+ ", free_ref=" + free_ref + ", free_reply_ref=" + free_reply_ref + ", free_reply_lev="
				+ free_reply_lev + ", free_reply_seq=" + free_reply_seq + ", free_like_no=" + free_like_no + "]";
	}
	public int getFree_no() {
		return free_no;
	}
	public void setFree_no(int free_no) {
		this.free_no = free_no;
	}
	public String getFree_name() {
		return free_name;
	}
	public void setFree_name(String free_name) {
		this.free_name = free_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public java.sql.Date getWrite_free_date() {
		return write_free_date;
	}
	public void setWrite_free_date(java.sql.Date write_free_date) {
		this.write_free_date = write_free_date;
	}
	public int getClick_free_no() {
		return click_free_no;
	}
	public void setClick_free_no(int click_free_no) {
		this.click_free_no = click_free_no;
	}
	public String getFree_value() {
		return free_value;
	}
	public void setFree_value(String free_value) {
		this.free_value = free_value;
	}
	public String getOriginfile_free() {
		return originfile_free;
	}
	public void setOriginfile_free(String originfile_free) {
		this.originfile_free = originfile_free;
	}
	public String getRenamefile_free() {
		return renamefile_free;
	}
	public void setRenamefile_free(String renamefile_free) {
		this.renamefile_free = renamefile_free;
	}
	public int getFree_ref() {
		return free_ref;
	}
	public void setFree_ref(int free_ref) {
		this.free_ref = free_ref;
	}
	public int getFree_reply_ref() {
		return free_reply_ref;
	}
	public void setFree_reply_ref(int free_reply_ref) {
		this.free_reply_ref = free_reply_ref;
	}
	public int getFree_reply_lev() {
		return free_reply_lev;
	}
	public void setFree_reply_lev(int free_reply_lev) {
		this.free_reply_lev = free_reply_lev;
	}
	public int getFree_reply_seq() {
		return free_reply_seq;
	}
	public void setFree_reply_seq(int free_reply_seq) {
		this.free_reply_seq = free_reply_seq;
	}
	public int getFree_like_no() {
		return free_like_no;
	}
	public void setFree_like_no(int free_like_no) {
		this.free_like_no = free_like_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
