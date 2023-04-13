package org.sixpack.semi.event.model.vo;

import java.sql.Date;

public class Event implements java.io.Serializable{
	
	private int event_no;				//이벤트 글번호
	private String event_title;			//이벤트 제목
	private String user_id;				//이벤트 작성자
	private Date write_event_date;		//이벤트 작성일
	private int event_views;			//이벤트 조회수
	private String event_content;		//이벤트 글내용
	private String event_originfile;	//이벤트 원본파일
	private String event_renamefile;	//이벤트 수정파일
	
	public Event() {
		super();
	}

	public Event(int event_no, String event_title, String user_id, Date write_event_date, int event_views,
			String event_content, String event_originfile, String event_renamefile) {
		super();
		this.event_no = event_no;
		this.event_title = event_title;
		this.user_id = user_id;
		this.write_event_date = write_event_date;
		this.event_views = event_views;
		this.event_content = event_content;
		this.event_originfile = event_originfile;
		this.event_renamefile = event_renamefile;
	}

	public int getEvent_no() {
		return event_no;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}

	public String getEvent_title() {
		return event_title;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getWrite_event_date() {
		return write_event_date;
	}

	public void setWrite_event_date(Date write_event_date) {
		this.write_event_date = write_event_date;
	}

	public int getEvent_views() {
		return event_views;
	}

	public void setEvent_views(int event_views) {
		this.event_views = event_views;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public String getEvent_originfile() {
		return event_originfile;
	}

	public void setEvent_originfile(String event_originfile) {
		this.event_originfile = event_originfile;
	}

	public String getEvent_renamefile() {
		return event_renamefile;
	}

	public void setEvent_renamefile(String event_renamefile) {
		this.event_renamefile = event_renamefile;
	}

	@Override
	public String toString() {
		return "Event [event_no=" + event_no + ", event_title=" + event_title + ", user_id=" + user_id
				+ ", write_event_date=" + write_event_date + ", event_views=" + event_views + ", event_content="
				+ event_content + ", event_originfile=" + event_originfile + ", event_renamefile=" + event_renamefile
				+ "]";
	}

	
}
