package org.sixpack.semi.hotnew.model.vo;

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
	private String initlink_free;	//링크저장이름	VARCHAR2(200 BYTE)
	private int ref;	//원글참조번호	NUMBER
	private int reply_ref;	//댓글참조번호	NUMBER
	private int reply_lev;	//원글:1 댓글:2 대댓글:3	NUMBER
	private int reply_seq;	//댓글순번	NUMBER
	private int like_no; //좋아요수	NUMBER
	
}
