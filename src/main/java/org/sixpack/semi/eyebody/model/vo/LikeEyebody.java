package org.sixpack.semi.eyebody.model.vo;

public class LikeEyebody implements java.io.Serializable{

	private static final long serialVersionUID = 3568923195884604977L;
	
	private String user_id;
	private int eyebody_no;
	public LikeEyebody() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikeEyebody(String user_id, int eyebody_no) {
		super();
		this.user_id = user_id;
		this.eyebody_no = eyebody_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getEyebody_no() {
		return eyebody_no;
	}
	public void setEyebody_no(int eyebody_no) {
		this.eyebody_no = eyebody_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "LikeEyebody [user_id=" + user_id + ", eyebody_no=" + eyebody_no + "]";
	}
	
}
