package org.sixpack.semi.member.model.vo;

public class SessionConfigVO {
	private String user_id;
	private String user_name;
	private String email;
	private String user_nickname;
	private String sns_id;
	
	public SessionConfigVO() {
		super();
	}

	public SessionConfigVO(String user_id, String user_name, String email, String user_nickname, String sns_id) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.email = email;
		this.user_nickname = user_nickname;
		this.sns_id = sns_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getSns_id() {
		return sns_id;
	}

	public void setSns_id(String sns_id) {
		this.sns_id = sns_id;
	}

	@Override
	public String toString() {
		return "SessionConfigVO [user_id=" + user_id + ", user_name=" + user_name + ", email=" + email
				+ ", user_nickname=" + user_nickname + ", sns_id=" + sns_id + "]";
	}
	
}
