package org.sixpack.semi.qna.model.vo;

import java.sql.Date;

public class Qna {
	
	private int qna_no;				//qna 번호
	private String qna_title;		//qna 제목
	private String user_id;			//qna 작성자
	private Date qna_post_date;		//qna 작성일
	private int qna_views;			//qna 조회수
	private String qna_content;		//qna내용
	private String qna_originfile;	//qna답변원본파일
	private String qna_renamefile;	//qna수정파일
	private String qna_private;		//qna공개여부
	private int qna_lev;			//qna답글단계(원글:1, 답글:2, 대답글:3)
	private int qna_ref;			//qna원글번호
	private int qna_seq;			//qna답글순번
	private int qna_reply_ref;		//qna답글번호
	
	
	
	public Qna() {
		super();
	}



	public Qna(int qna_no, String qna_title, String user_id, Date qna_post_date, int qna_views, String qna_content,
			String qna_originfile, String qna_renamefile, String qna_private, int qna_lev, int qna_ref, int qna_seq,
			int qna_reply_ref) {
		super();
		this.qna_no = qna_no;
		this.qna_title = qna_title;
		this.user_id = user_id;
		this.qna_post_date = qna_post_date;
		this.qna_views = qna_views;
		this.qna_content = qna_content;
		this.qna_originfile = qna_originfile;
		this.qna_renamefile = qna_renamefile;
		this.qna_private = qna_private;
		this.qna_lev = qna_lev;
		this.qna_ref = qna_ref;
		this.qna_seq = qna_seq;
		this.qna_reply_ref = qna_reply_ref;
	}



	public int getQna_no() {
		return qna_no;
	}



	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}



	public String getQna_title() {
		return qna_title;
	}



	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public Date getQna_post_date() {
		return qna_post_date;
	}



	public void setQna_post_date(Date qna_post_date) {
		this.qna_post_date = qna_post_date;
	}



	public int getQna_views() {
		return qna_views;
	}



	public void setQna_views(int qna_views) {
		this.qna_views = qna_views;
	}



	public String getQna_content() {
		return qna_content;
	}



	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}



	public String getQna_originfile() {
		return qna_originfile;
	}



	public void setQna_originfile(String qna_originfile) {
		this.qna_originfile = qna_originfile;
	}



	public String getQna_renamefile() {
		return qna_renamefile;
	}



	public void setQna_renamefile(String qna_renamefile) {
		this.qna_renamefile = qna_renamefile;
	}



	public String getQna_private() {
		return qna_private;
	}



	public void setQna_private(String qna_private) {
		this.qna_private = qna_private;
	}



	public int getQna_lev() {
		return qna_lev;
	}



	public void setQna_lev(int qna_lev) {
		this.qna_lev = qna_lev;
	}



	public int getQna_ref() {
		return qna_ref;
	}



	public void setQna_ref(int qna_ref) {
		this.qna_ref = qna_ref;
	}



	public int getQna_seq() {
		return qna_seq;
	}



	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}



	public int getQna_reply_ref() {
		return qna_reply_ref;
	}



	public void setQna_reply_ref(int qna_reply_ref) {
		this.qna_reply_ref = qna_reply_ref;
	}



	@Override
	public String toString() {
		return "Qna [qna_no=" + qna_no + ", qna_title=" + qna_title + ", user_id=" + user_id + ", qna_post_date="
				+ qna_post_date + ", qna_views=" + qna_views + ", qna_content=" + qna_content + ", qna_originfile="
				+ qna_originfile + ", qna_renamefile=" + qna_renamefile + ", qna_private=" + qna_private + ", qna_lev="
				+ qna_lev + ", qna_ref=" + qna_ref + ", qna_seq=" + qna_seq + ", qna_reply_ref=" + qna_reply_ref + "]";
	}


	

	
	
	
}	