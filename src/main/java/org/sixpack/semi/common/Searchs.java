package org.sixpack.semi.common;

public class Searchs extends Paging implements java.io.Serializable {
	private static final long serialVersionUID = 848374754136325690L;
	
	private String searchtype;
	private String keyword;
	
	public Searchs(int listCount, int currentPage, int limit) {
		super(listCount, currentPage, limit);
		// TODO Auto-generated constructor stub
	}
	public Searchs(int listCount, int currentPage, int limit, String searchtype, String keyword) {
		super(listCount, currentPage, limit);
		this.searchtype = searchtype;
		this.keyword = keyword;
	}
	public String getSearchtype() {
		return searchtype;
	}
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Searchs [searchtype=" + searchtype + ", keyword=" + keyword + "]";
	}
	
}
