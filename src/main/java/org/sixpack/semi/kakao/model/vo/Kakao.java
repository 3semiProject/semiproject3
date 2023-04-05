package org.sixpack.semi.kakao.model.vo;

import java.sql.Date;

import org.sixpack.semi.member.model.vo.Member;

public class Kakao extends Member implements java.io.Serializable {

	private static final long serialVersionUID = -2031609834215865353L;
	
	private String kakao_id;			//kakao 아이디
	private String kakao_secret; 		//secret
	private String kakao_scope;			//scope
	private String kakao_name; 			//user_name
	private Date kakao_birth;			//user_birth
	private String email;				//email

	public Kakao() {}

	public Kakao(String kakao_id, String kakao_secret, String kakao_scope, String kakao_name, Date kakao_birth,
			String email) {
		super();
		this.kakao_id = kakao_id;
		this.kakao_secret = kakao_secret;
		this.kakao_scope = kakao_scope;
		this.kakao_name = kakao_name;
		this.kakao_birth = kakao_birth;
		this.email = email;
	}

	public String getKakao_id() {
		return kakao_id;
	}

	public void setKakao_id(String kakao_id) {
		this.kakao_id = kakao_id;
	}

	public String getKakao_secret() {
		return kakao_secret;
	}

	public void setKakao_secret(String kakao_secret) {
		this.kakao_secret = kakao_secret;
	}

	public String getKakao_scope() {
		return kakao_scope;
	}

	public void setKakao_scope(String kakao_scope) {
		this.kakao_scope = kakao_scope;
	}

	public String getKakao_name() {
		return kakao_name;
	}

	public void setKakao_name(String kakao_name) {
		this.kakao_name = kakao_name;
	}

	public Date getKakao_birth() {
		return kakao_birth;
	}

	public void setKakao_birth(Date kakao_birth) {
		this.kakao_birth = kakao_birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Kakao [kakao_id=" + kakao_id + ", kakao_secret=" + kakao_secret + ", kakao_scope=" + kakao_scope
				+ ", kakao_name=" + kakao_name + ", kakao_birth=" + kakao_birth + ", email=" + email + "]";
	}
	
	
}
