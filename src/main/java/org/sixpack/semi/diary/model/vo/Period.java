package org.sixpack.semi.diary.model.vo;

import java.util.Date;

public class Period implements java.io.Serializable{
	private static final long serialVersionUID = -424010746028138159L;
	private Diary diary;	//userid를 담음
	private Date begin;		//조회 시작일
	private Date end;		//조회 종료일
	
	
	public Period() {
		super();
	}
	public Period(Diary diary, Date begin, Date end) {
		super();
		this.diary = diary;
		this.begin = begin;
		this.end = end;
	}
	@Override
	public String toString() {
		return "Period [diary=" + diary + ", begin=" + begin + ", end=" + end + "]";
	}
	public Diary getDiary() {
		return diary;
	}
	public void setDiary(Diary diary) {
		this.diary = diary;
	}
	public Date getBegin() {
		return begin;
	}
	public void setBegin(Date begin) {
		this.begin = begin;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	
	
	
	

}
