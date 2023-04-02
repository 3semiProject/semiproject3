package org.sixpack.semi.eyebody.model.vo;

import java.sql.Date;

public class Eyebody {
	private int eyebody_no;	//글번호	NUMBER
	private String eyebody_name;	//글제목	VARCHAR2(200 BYTE)
	private String user_id;	//작성자	VARCHAR2(50 BYTE)
	private java.sql.Date write_eyebody_date;	//작성일	DATE
	private int click_eyebody_no;	//조회수	NUMBER
	private String eyebody_value;	//글내용	VARCHAR2(4000 BYTE)
	private String originfile_eyebody;	//파일원본이름	VARCHAR2(200 BYTE)
	private String renamefile_eyebody;	//파일수정이름	VARCHAR2(200 BYTE)
	private int eyebody_ref;	//원글참조번호	NUMBER
	private int eyebody_reply_ref;	//댓글참조번호	NUMBER
	private int eyebody_reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int eyebody_reply_seq;	//댓글순번	NUMBER
	private int eyebody_like_no; //좋아요수	NUMBER
	public Eyebody() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Eyebody(int eyebody_no, String eyebody_name, String user_id, Date write_eyebody_date, int click_eyebody_no,
			String eyebody_value, String originfile_eyebody, String renamefile_eyebody, int eyebody_ref,
			int eyebody_reply_ref, int eyebody_reply_lev, int eyebody_reply_seq, int eyebody_like_no) {
		super();
		this.eyebody_no = eyebody_no;
		this.eyebody_name = eyebody_name;
		this.user_id = user_id;
		this.write_eyebody_date = write_eyebody_date;
		this.click_eyebody_no = click_eyebody_no;
		this.eyebody_value = eyebody_value;
		this.originfile_eyebody = originfile_eyebody;
		this.renamefile_eyebody = renamefile_eyebody;
		this.eyebody_ref = eyebody_ref;
		this.eyebody_reply_ref = eyebody_reply_ref;
		this.eyebody_reply_lev = eyebody_reply_lev;
		this.eyebody_reply_seq = eyebody_reply_seq;
		this.eyebody_like_no = eyebody_like_no;
	}
	public int getEyebody_no() {
		return eyebody_no;
	}
	public void setEyebody_no(int eyebody_no) {
		this.eyebody_no = eyebody_no;
	}
	public String getEyebody_name() {
		return eyebody_name;
	}
	public void setEyebody_name(String eyebody_name) {
		this.eyebody_name = eyebody_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public java.sql.Date getWrite_eyebody_date() {
		return write_eyebody_date;
	}
	public void setWrite_eyebody_date(java.sql.Date write_eyebody_date) {
		this.write_eyebody_date = write_eyebody_date;
	}
	public int getClick_eyebody_no() {
		return click_eyebody_no;
	}
	public void setClick_eyebody_no(int click_eyebody_no) {
		this.click_eyebody_no = click_eyebody_no;
	}
	public String getEyebody_value() {
		return eyebody_value;
	}
	public void setEyebody_value(String eyebody_value) {
		this.eyebody_value = eyebody_value;
	}
	public String getOriginfile_eyebody() {
		return originfile_eyebody;
	}
	public void setOriginfile_eyebody(String originfile_eyebody) {
		this.originfile_eyebody = originfile_eyebody;
	}
	public String getRenamefile_eyebody() {
		return renamefile_eyebody;
	}
	public void setRenamefile_eyebody(String renamefile_eyebody) {
		this.renamefile_eyebody = renamefile_eyebody;
	}
	public int getEyebody_ref() {
		return eyebody_ref;
	}
	public void setEyebody_ref(int eyebody_ref) {
		this.eyebody_ref = eyebody_ref;
	}
	public int getEyebody_reply_ref() {
		return eyebody_reply_ref;
	}
	public void setEyebody_reply_ref(int eyebody_reply_ref) {
		this.eyebody_reply_ref = eyebody_reply_ref;
	}
	public int getEyebody_reply_lev() {
		return eyebody_reply_lev;
	}
	public void setEyebody_reply_lev(int eyebody_reply_lev) {
		this.eyebody_reply_lev = eyebody_reply_lev;
	}
	public int getEyebody_reply_seq() {
		return eyebody_reply_seq;
	}
	public void setEyebody_reply_seq(int eyebody_reply_seq) {
		this.eyebody_reply_seq = eyebody_reply_seq;
	}
	public int getEyebody_like_no() {
		return eyebody_like_no;
	}
	public void setEyebody_like_no(int eyebody_like_no) {
		this.eyebody_like_no = eyebody_like_no;
	}
	@Override
	public String toString() {
		return "Eyebody [eyebody_no=" + eyebody_no + ", eyebody_name=" + eyebody_name + ", user_id=" + user_id
				+ ", write_eyebody_date=" + write_eyebody_date + ", click_eyebody_no=" + click_eyebody_no
				+ ", eyebody_value=" + eyebody_value + ", originfile_eyebody=" + originfile_eyebody
				+ ", renamefile_eyebody=" + renamefile_eyebody + ", eyebody_ref=" + eyebody_ref + ", eyebody_reply_ref="
				+ eyebody_reply_ref + ", eyebody_reply_lev=" + eyebody_reply_lev + ", eyebody_reply_seq="
				+ eyebody_reply_seq + ", eyebody_like_no=" + eyebody_like_no + "]";
	}
	
}