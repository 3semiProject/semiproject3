package org.sixpack.semi.notice.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable {
	
	private static final long serialVersionUID = -5186065698359976362L;
	private int notice_no;				//공지사항 글번호
	private String notice_title;		//공지사항 제목
	private String user_id;				//공지사항 작성자
	private Date write_notice_date;		//공지사항 작성일
	private int notice_views;			//공지사항 조회수
	private String notice_content;		//공지사항 글내용
	private String notice_originfile;	//공지사항 원본파일
	private String notice_renamefile;	//공지사항 수정파일
	private String notice_initlink;		//공지사항 링크
	
	public Notice() {
		super();
	}

	public Notice(int notice_no, String notice_title, String user_id, Date write_notice_date, int notice_views,
			String notice_content, String notice_originfile, String notice_renamefile, String notice_initlink) {
		super();
		this.notice_no = notice_no;
		this.notice_title = notice_title;
		this.user_id = user_id;
		this.write_notice_date = write_notice_date;
		this.notice_views = notice_views;
		this.notice_content = notice_content;
		this.notice_originfile = notice_originfile;
		this.notice_renamefile = notice_renamefile;
		this.notice_initlink = notice_initlink;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getWrite_notice_date() {
		return write_notice_date;
	}

	public void setWrite_notice_date(Date write_notice_date) {
		this.write_notice_date = write_notice_date;
	}

	public int getNotice_views() {
		return notice_views;
	}

	public void setNotice_views(int notice_views) {
		this.notice_views = notice_views;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getNotice_originfile() {
		return notice_originfile;
	}

	public void setNotice_originfile(String notice_originfile) {
		this.notice_originfile = notice_originfile;
	}

	public String getNotice_renamefile() {
		return notice_renamefile;
	}

	public void setNotice_renamefile(String notice_renamefile) {
		this.notice_renamefile = notice_renamefile;
	}

	public String getNotice_initlink() {
		return notice_initlink;
	}

	public void setNotice_initlink(String notice_initlink) {
		this.notice_initlink = notice_initlink;
	}

	@Override
	public String toString() {
		return "Notice [notice_no=" + notice_no + ", notice_title=" + notice_title + ", user_id=" + user_id
				+ ", write_notice_date=" + write_notice_date + ", notice_views=" + notice_views + ", notice_content="
				+ notice_content + ", notice_originfile=" + notice_originfile + ", notice_renamefile="
				+ notice_renamefile + ", notice_initlink=" + notice_initlink + "]";
	}

}
