package org.sixpack.semi.bfaf.model.vo;

public class LikeBfaf implements java.io.Serializable{

	private static final long serialVersionUID = 5647533727151483398L;
	
	private String user_id;
	private int bfaf_no;
	public LikeBfaf() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikeBfaf(String user_id, int bfaf_no) {
		super();
		this.user_id = user_id;
		this.bfaf_no = bfaf_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getBfaf_no() {
		return bfaf_no;
	}
	public void setBfaf_no(int bfaf_no) {
		this.bfaf_no = bfaf_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "LikeBfaf [user_id=" + user_id + ", bfaf_no=" + bfaf_no + "]";
	}
	
}
