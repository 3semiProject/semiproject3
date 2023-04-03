package org.sixpack.semi.tip.model.vo;

public class LikeTip implements java.io.Serializable{

	private static final long serialVersionUID = -5995612230264499962L;
	
	private String user_id;
	private int tip_no;
	public LikeTip() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikeTip(String user_id, int tip_no) {
		super();
		this.user_id = user_id;
		this.tip_no = tip_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getTip_no() {
		return tip_no;
	}
	public void setTip_no(int tip_no) {
		this.tip_no = tip_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "LikeTip [user_id=" + user_id + ", tip_no=" + tip_no + "]";
	}
	
}
