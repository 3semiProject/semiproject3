package org.sixpack.semi.hotnew.model.vo;

public class LikeHotNew implements java.io.Serializable{

	private static final long serialVersionUID = 8160788602114338291L;
	
	private String user_id;
	private int hotNew_no;
	public LikeHotNew() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikeHotNew(String user_id, int hotNew_no) {
		super();
		this.user_id = user_id;
		this.hotNew_no = hotNew_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getHotNew_no() {
		return hotNew_no;
	}
	public void setHotNew_no(int hotNew_no) {
		this.hotNew_no = hotNew_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "LikeHotNew [user_id=" + user_id + ", hotNew_no=" + hotNew_no + "]";
	}
	
}
