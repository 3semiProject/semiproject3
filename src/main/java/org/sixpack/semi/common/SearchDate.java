package org.sixpack.semi.common;

import java.io.Serializable;
import java.sql.Date;

//@Component("searchDate")
public class SearchDate implements Serializable {

    private static final long serialVersionUID = 2253546582582684455L;

    private Date start;
    private Date end;
	public SearchDate() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SearchDate(Date start, Date end) {
		super();
		this.start = start;
		this.end = end;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "SearchDate [start=" + start + ", end=" + end + "]";
	}
}