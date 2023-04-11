package org.sixpack.semi.common;

import java.io.Serializable;
import java.sql.Date;

//@Component("searchDate")
public class SearchDate implements Serializable {

    private static final long serialVersionUID = 2253546582582684455L;

    private Date begin;
    private Date end;

    public SearchDate() {
		super();
	}

	public SearchDate(Date begin, Date end) {
		super();
		this.begin = begin;
		this.end = end;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SearchDate [begin=" + begin + ", end=" + end + "]";
	}


}