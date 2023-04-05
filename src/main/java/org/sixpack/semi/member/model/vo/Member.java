package org.sixpack.semi.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable{

	private static final long serialVersionUID = -5501979043866700812L;
	
	private String user_id;			//회원아이디
    private String user_pw;			//회원패스워드
    private String user_name;		//회원이름
    private String user_nickname;	//회원닉네임
    private String phone;			//회원전화번호
    private Date birth;				//회원생일
    private String gender;			//회원성별
    private String email;			//회원이메일
    private String admin_ck;		//관리자여부
    private String profile_originfile;	//프로필원본파일
    private String profile_renamefile;	//프로필수정파일
    


    public Member() {
        super();
    }



	public Member(String user_id, String user_pw, String user_name, String user_nickname, String phone, Date birth,
			String gender, String email, String admin_ck, String profile_originfile, String profile_renamefile) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_nickname = user_nickname;
		this.phone = phone;
		this.birth = birth;
		this.gender = gender;
		this.email = email;
		this.admin_ck = admin_ck;
		this.profile_originfile = profile_originfile;
		this.profile_renamefile = profile_renamefile;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getUser_pw() {
		return user_pw;
	}



	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}



	public String getUser_nickname() {
		return user_nickname;
	}



	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public Date getBirth() {
		return birth;
	}



	public void setBirth(Date birth) {
		this.birth = birth;
	}



	public String getGender() {
		return gender;
	}



	public void setGender(String gender) {
		this.gender = gender;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getAdmin_ck() {
		return admin_ck;
	}



	public void setAdmin_ck(String admin_ck) {
		this.admin_ck = admin_ck;
	}



	public String getProfile_originfile() {
		return profile_originfile;
	}



	public void setProfile_originfile(String profile_originfile) {
		this.profile_originfile = profile_originfile;
	}



	public String getProfile_renamefile() {
		return profile_renamefile;
	}



	public void setProfile_renamefile(String profile_renamefile) {
		this.profile_renamefile = profile_renamefile;
	}



	@Override
	public String toString() {
		return "Member [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_nickname="
				+ user_nickname + ", phone=" + phone + ", birth=" + birth + ", gender=" + gender + ", email=" + email
				+ ", admin_ck=" + admin_ck + ", profile_originfile=" + profile_originfile + ", profile_renamefile="
				+ profile_renamefile + "]";
	}

   

}
