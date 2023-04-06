package org.sixpack.semi.log.model.vo;

//import java.sql.Date;

public class Log {
	
	private String user_id;
	private String visit_ip;
	//private Date visit_time;
	private String visit_time;
	
	public Log() {
		super();
	}

	public Log(String user_id, String visit_ip, String visit_time) {
		super();
		this.user_id = user_id;
		this.visit_ip = visit_ip;
		this.visit_time = visit_time;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getVisit_ip() {
		return visit_ip;
	}

	public void setVisit_ip(String visit_ip) {
		this.visit_ip = visit_ip;
	}

	public String getVisit_time() {
		return visit_time;
	}

	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}

	@Override
	public String toString() {
		return "Log [user_id=" + user_id + ", visit_ip=" + visit_ip + ", visit_time=" + visit_time + "]";
	}
	
	

//	public Log(String user_id, String visit_ip, Date visit_time) {
//		super();
//		this.user_id = user_id;
//		this.visit_ip = visit_ip;
//		this.visit_time = visit_time;
//	}
//
//	public String getUser_id() {
//		return user_id;
//	}
//
//	public void setUser_id(String user_id) {
//		this.user_id = user_id;
//	}
//
//	public String getVisit_ip() {
//		return visit_ip;
//	}
//
//	public void setVisit_ip(String visit_ip) {
//		this.visit_ip = visit_ip;
//	}
//
//	public Date getVisit_time() {
//		return visit_time;
//	}
//
//	public void setVisit_time(Date visit_time) {
//		this.visit_time = visit_time;
//	}
//
//	@Override
//	public String toString() {
//		return "Log [user_id=" + user_id + ", visit_ip=" + visit_ip + ", visit_time=" + visit_time + "]";
//	}

	
}
