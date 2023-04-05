package org.sixpack.semi.free.model.vo;

public class LikeFree implements java.io.Serializable{

	private static final long serialVersionUID = -5616137320136286269L;
	
	private String user_id;
	private int free_no;
	public LikeFree() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikeFree(String user_id, int free_no) {
		super();
		this.user_id = user_id;
		this.free_no = free_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getFree_no() {
		return free_no;
	}
	public void setFree_no(int free_no) {
		this.free_no = free_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "LikeFree [user_id=" + user_id + ", free_no=" + free_no + "]";
	}
}
