package org.sixpack.semi.qnaanswer.model.vo;

import java.sql.Date;

public class QnaAnswer {

	private int qna_answer_no;
	private int qna_answer_ref;
	private String qna_answer_title;
	private String user_id;
	private Date qna_answer_post_date;
	private int qna_answer_views;
	private String qna_answer_content;
	private String qna_answer_originfile;
	private String qna_answer_renamefile;
	private String qna_answer_private;
	
	public QnaAnswer() {
		super();
	}
	
	public QnaAnswer(int qna_answer_no, int qna_answer_ref, String qna_answer_title, String user_id,
			Date qna_answer_post_date, int qna_answer_views, String qna_answer_content, String qna_answer_originfile,
			String qna_answer_renamefile, String qna_answer_private) {
		super();
		this.qna_answer_no = qna_answer_no;
		this.qna_answer_ref = qna_answer_ref;
		this.qna_answer_title = qna_answer_title;
		this.user_id = user_id;
		this.qna_answer_post_date = qna_answer_post_date;
		this.qna_answer_views = qna_answer_views;
		this.qna_answer_content = qna_answer_content;
		this.qna_answer_originfile = qna_answer_originfile;
		this.qna_answer_renamefile = qna_answer_renamefile;
		this.qna_answer_private = qna_answer_private;
	}

	public int getQna_answer_no() {
		return qna_answer_no;
	}

	public void setQna_answer_no(int qna_answer_no) {
		this.qna_answer_no = qna_answer_no;
	}

	public int getQna_answer_ref() {
		return qna_answer_ref;
	}

	public void setQna_answer_ref(int qna_answer_ref) {
		this.qna_answer_ref = qna_answer_ref;
	}

	public String getQna_answer_title() {
		return qna_answer_title;
	}

	public void setQna_answer_title(String qna_answer_title) {
		this.qna_answer_title = qna_answer_title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getQna_answer_post_date() {
		return qna_answer_post_date;
	}

	public void setQna_answer_post_date(Date qna_answer_post_date) {
		this.qna_answer_post_date = qna_answer_post_date;
	}

	public int getQna_answer_views() {
		return qna_answer_views;
	}

	public void setQna_answer_views(int qna_answer_views) {
		this.qna_answer_views = qna_answer_views;
	}

	public String getQna_answer_content() {
		return qna_answer_content;
	}

	public void setQna_answer_content(String qna_answer_content) {
		this.qna_answer_content = qna_answer_content;
	}

	public String getQna_answer_originfile() {
		return qna_answer_originfile;
	}

	public void setQna_answer_originfile(String qna_answer_originfile) {
		this.qna_answer_originfile = qna_answer_originfile;
	}

	public String getQna_answer_renamefile() {
		return qna_answer_renamefile;
	}

	public void setQna_answer_renamefile(String qna_answer_renamefile) {
		this.qna_answer_renamefile = qna_answer_renamefile;
	}

	public String getQna_answer_private() {
		return qna_answer_private;
	}

	public void setQna_answer_private(String qna_answer_private) {
		this.qna_answer_private = qna_answer_private;
	}

	@Override
	public String toString() {
		return "QnaAnswer [qna_answer_no=" + qna_answer_no + ", qna_answer_ref=" + qna_answer_ref
				+ ", qna_answer_title=" + qna_answer_title + ", user_id=" + user_id + ", qna_answer_post_date="
				+ qna_answer_post_date + ", qna_answer_views=" + qna_answer_views + ", qna_answer_content="
				+ qna_answer_content + ", qna_answer_originfile=" + qna_answer_originfile + ", qna_answer_renamefile="
				+ qna_answer_renamefile + ", qna_answer_private=" + qna_answer_private + "]";
	}
	
	
}
