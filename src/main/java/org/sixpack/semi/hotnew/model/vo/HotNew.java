package org.sixpack.semi.hotnew.model.vo;

import java.sql.Date;

public class HotNew implements java.io.Serializable {

	private static final long serialVersionUID = -1297400148926748531L;
	
	private int hotnew_no;	//글번호	NUMBER
	private String hotnew_name;	//글제목	VARCHAR2(200 BYTE)
	private String user_id;	//작성자	VARCHAR2(50 BYTE)
	private java.sql.Date write_hotnew_date;	//작성일	DATE
	private int click_hotnew_no;	//조회수	NUMBER
	private String hotnew_value;	//글내용	VARCHAR2(4000 BYTE)
	private String originfile_hotnew;	//파일원본이름	VARCHAR2(200 BYTE)
	private String renamefile_hotnew;	//파일수정이름	VARCHAR2(200 BYTE)
	private int ref;	//원글참조번호	NUMBER
	private int reply_ref;	//댓글참조번호	NUMBER
	private int reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int reply_seq;	//댓글순번	NUMBER
	private int like_no; //좋아요수	NUMBER
	private int rnum;
	public HotNew() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HotNew(int hotnew_no, String hotnew_name, String user_id, Date write_hotnew_date, int click_hotnew_no,
			String hotnew_value, String originfile_hotnew, String renamefile_hotnew, int ref, int reply_ref,
			int reply_lev, int reply_seq, int like_no, int rnum) {
		super();
		this.hotnew_no = hotnew_no;
		this.hotnew_name = hotnew_name;
		this.user_id = user_id;
		this.write_hotnew_date = write_hotnew_date;
		this.click_hotnew_no = click_hotnew_no;
		this.hotnew_value = hotnew_value;
		this.originfile_hotnew = originfile_hotnew;
		this.renamefile_hotnew = renamefile_hotnew;
		this.ref = ref;
		this.reply_ref = reply_ref;
		this.reply_lev = reply_lev;
		this.reply_seq = reply_seq;
		this.like_no = like_no;
		this.rnum = rnum;
	}
	public int getHotnew_no() {
		return hotnew_no;
	}
	public void setHotnew_no(int hotnew_no) {
		this.hotnew_no = hotnew_no;
	}
	public String getHotnew_name() {
		return hotnew_name;
	}
	public void setHotnew_name(String hotnew_name) {
		this.hotnew_name = hotnew_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public java.sql.Date getWrite_hotnew_date() {
		return write_hotnew_date;
	}
	public void setWrite_hotnew_date(java.sql.Date write_hotnew_date) {
		this.write_hotnew_date = write_hotnew_date;
	}
	public int getClick_hotnew_no() {
		return click_hotnew_no;
	}
	public void setClick_hotnew_no(int click_hotnew_no) {
		this.click_hotnew_no = click_hotnew_no;
	}
	public String getHotnew_value() {
		return hotnew_value;
	}
	public void setHotnew_value(String hotnew_value) {
		this.hotnew_value = hotnew_value;
	}
	public String getOriginfile_hotnew() {
		return originfile_hotnew;
	}
	public void setOriginfile_hotnew(String originfile_hotnew) {
		this.originfile_hotnew = originfile_hotnew;
	}
	public String getRenamefile_hotnew() {
		return renamefile_hotnew;
	}
	public void setRenamefile_hotnew(String renamefile_hotnew) {
		this.renamefile_hotnew = renamefile_hotnew;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getReply_ref() {
		return reply_ref;
	}
	public void setReply_ref(int reply_ref) {
		this.reply_ref = reply_ref;
	}
	public int getReply_lev() {
		return reply_lev;
	}
	public void setReply_lev(int reply_lev) {
		this.reply_lev = reply_lev;
	}
	public int getReply_seq() {
		return reply_seq;
	}
	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
	}
	public int getLike_no() {
		return like_no;
	}
	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "HotNew [hotnew_no=" + hotnew_no + ", hotnew_name=" + hotnew_name + ", user_id=" + user_id
				+ ", write_hotnew_date=" + write_hotnew_date + ", click_hotnew_no=" + click_hotnew_no
				+ ", hotnew_value=" + hotnew_value + ", originfile_hotnew=" + originfile_hotnew + ", renamefile_hotnew="
				+ renamefile_hotnew + ", ref=" + ref + ", reply_ref=" + reply_ref + ", reply_lev=" + reply_lev
				+ ", reply_seq=" + reply_seq + ", like_no=" + like_no + ", rnum=" + rnum + "]";
	}
	
}
