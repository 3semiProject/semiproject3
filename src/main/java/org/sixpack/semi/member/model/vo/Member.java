package org.sixpack.semi.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

public class Member implements java.io.Serializable {
    private static final long serialVersionUID = -7412802581401323354L;

    //스프링에서 데이터베이스 테이블 컬럼명과 vo 클래스의 필드명을
    //일치시키면 마이바티스 매퍼의 resultMap 이 자동 작동됨
    //member.setUserId(rset.getString("userid"));

    private String userid;    //회원 아이디
    private String userpwd;    //회원 패스워드
    private String username;    //회원 이름
    private String gender;        //회원 성별
    private int age;            //회원 나이
    private String phone;        //회원 전화번호
    private String email;        //회원 이메일
    private java.sql.Date enroll_date;    //회원 가입날짜
    private java.sql.Date lastmodified;    //회원 정보 마지막 수정날짜
    private String signtype;
    private String admin;        //관리자 여부
    private String login_ok;        //로그인 가능 여부
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Member(String userid, String userpwd, String username, String gender, int age, String phone, String email,
			Date enroll_date, Date lastmodified, String signtype, String admin, String login_ok) {
		super();
		this.userid = userid;
		this.userpwd = userpwd;
		this.username = username;
		this.gender = gender;
		this.age = age;
		this.phone = phone;
		this.email = email;
		this.enroll_date = enroll_date;
		this.lastmodified = lastmodified;
		this.signtype = signtype;
		this.admin = admin;
		this.login_ok = login_ok;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public java.sql.Date getEnroll_date() {
		return enroll_date;
	}
	public void setEnroll_date(java.sql.Date enroll_date) {
		this.enroll_date = enroll_date;
	}
	public java.sql.Date getLastmodified() {
		return lastmodified;
	}
	public void setLastmodified(java.sql.Date lastmodified) {
		this.lastmodified = lastmodified;
	}
	public String getSigntype() {
		return signtype;
	}
	public void setSigntype(String signtype) {
		this.signtype = signtype;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getLogin_ok() {
		return login_ok;
	}
	public void setLogin_ok(String login_ok) {
		this.login_ok = login_ok;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Member [userid=" + userid + ", userpwd=" + userpwd + ", username=" + username + ", gender=" + gender
				+ ", age=" + age + ", phone=" + phone + ", email=" + email + ", enroll_date=" + enroll_date
				+ ", lastmodified=" + lastmodified + ", signtype=" + signtype + ", admin=" + admin + ", login_ok="
				+ login_ok + "]";
	}
    
}
