package org.sixpack.semi.qna.model.vo;

import java.sql.Date;

public class Qna {
	
	private int qna_no;
	private String qna_title;
	private String user_id;
	private Date qna_post_date;
	private int qna_views;
	private String qna_content;
	private String qna_originfile;
	private String qna_renamefile;
	private String qna_private;
	
	public Qna() {
		super();
	}

	public Qna(int qna_no, String qna_title, String user_id, Date qna_post_date, int qna_views,
			String qna_content, String qna_originfile, String qna_renamefile, String qna_private) {
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

	@Override
	public String toString() {
		return "MemberQna [qna_no=" + qna_no + ", qna_title=" + qna_title + ", user_id=" + user_id + ", qna_post_date="
				+ qna_post_date + ", qna_views=" + qna_views + ", qna_content=" + qna_content + ", qna_originfile="
				+ qna_originfile + ", qna_renamefile=" + qna_renamefile + ", qna_private=" + qna_private + "]";
	}
	
}	