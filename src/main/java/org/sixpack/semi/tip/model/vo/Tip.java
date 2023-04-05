package org.sixpack.semi.tip.model.vo;

import java.sql.Date;

public class Tip implements java.io.Serializable {

	private static final long serialVersionUID = 193916612440032201L;
	
	private int tip_no;	//글번호	NUMBER
	private String tip_name;	//글제목	VARCHAR2(200 BYTE)
	private String user_id;	//작성자	VARCHAR2(50 BYTE)
	private Date write_tip_date;	//작성일	DATE
	private int click_tip_no;	//조회수	NUMBER
	private String tip_value;	//글내용	VARCHAR2(4000 BYTE)
	private String originfile_tip;	//파일원본이름	VARCHAR2(200 BYTE)
	private String renamefile_tip;	//파일수정이름	VARCHAR2(200 BYTE)
	private int tip_ref;	//원글참조번호	NUMBER
	private int tip_reply_ref;	//댓글참조번호	NUMBER
	private int tip_reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int tip_reply_seq;	//댓글순번	NUMBER
	private int tip_like_no; //좋아요수	NUMBER
	public Tip() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Tip(int tip_no, String tip_name, String user_id, Date write_tip_date, int click_tip_no, String tip_value,
			String originfile_tip, String renamefile_tip, int tip_ref, int tip_reply_ref, int tip_reply_lev,
			int tip_reply_seq, int tip_like_no) {
		super();
		this.tip_no = tip_no;
		this.tip_name = tip_name;
		this.user_id = user_id;
		this.write_tip_date = write_tip_date;
		this.click_tip_no = click_tip_no;
		this.tip_value = tip_value;
		this.originfile_tip = originfile_tip;
		this.renamefile_tip = renamefile_tip;
		this.tip_ref = tip_ref;
		this.tip_reply_ref = tip_reply_ref;
		this.tip_reply_lev = tip_reply_lev;
		this.tip_reply_seq = tip_reply_seq;
		this.tip_like_no = tip_like_no;
	}
	public int getTip_no() {
		return tip_no;
	}
	public void setTip_no(int tip_no) {
		this.tip_no = tip_no;
	}
	public String getTip_name() {
		return tip_name;
	}
	public void setTip_name(String tip_name) {
		this.tip_name = tip_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getWrite_tip_date() {
		return write_tip_date;
	}
	public void setWrite_tip_date(Date write_tip_date) {
		this.write_tip_date = write_tip_date;
	}
	public int getClick_tip_no() {
		return click_tip_no;
	}
	public void setClick_tip_no(int click_tip_no) {
		this.click_tip_no = click_tip_no;
	}
	public String getTip_value() {
		return tip_value;
	}
	public void setTip_value(String tip_value) {
		this.tip_value = tip_value;
	}
	public String getOriginfile_tip() {
		return originfile_tip;
	}
	public void setOriginfile_tip(String originfile_tip) {
		this.originfile_tip = originfile_tip;
	}
	public String getRenamefile_tip() {
		return renamefile_tip;
	}
	public void setRenamefile_tip(String renamefile_tip) {
		this.renamefile_tip = renamefile_tip;
	}
	public int getTip_ref() {
		return tip_ref;
	}
	public void setTip_ref(int tip_ref) {
		this.tip_ref = tip_ref;
	}
	public int getTip_reply_ref() {
		return tip_reply_ref;
	}
	public void setTip_reply_ref(int tip_reply_ref) {
		this.tip_reply_ref = tip_reply_ref;
	}
	public int getTip_reply_lev() {
		return tip_reply_lev;
	}
	public void setTip_reply_lev(int tip_reply_lev) {
		this.tip_reply_lev = tip_reply_lev;
	}
	public int getTip_reply_seq() {
		return tip_reply_seq;
	}
	public void setTip_reply_seq(int tip_reply_seq) {
		this.tip_reply_seq = tip_reply_seq;
	}
	public int getTip_like_no() {
		return tip_like_no;
	}
	public void setTip_like_no(int tip_like_no) {
		this.tip_like_no = tip_like_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Tip [tip_no=" + tip_no + ", tip_name=" + tip_name + ", user_id=" + user_id + ", write_tip_date="
				+ write_tip_date + ", click_tip_no=" + click_tip_no + ", tip_value=" + tip_value + ", originfile_tip="
				+ originfile_tip + ", renamefile_tip=" + renamefile_tip + ", tip_ref=" + tip_ref + ", tip_reply_ref="
				+ tip_reply_ref + ", tip_reply_lev=" + tip_reply_lev + ", tip_reply_seq=" + tip_reply_seq
				+ ", tip_like_no=" + tip_like_no + "]";
	}
	
}
