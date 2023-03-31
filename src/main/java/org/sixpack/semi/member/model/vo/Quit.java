package org.sixpack.semi.member.model.vo;

import java.sql.Date;

public class Quit {
	
	 	private String quit_user_id;			//회원아이디
	    private String quit_user_pw;			//회원패스워드
	    private String quit_user_name;		//회원이름
	    private String quit_user_nickname;	//회원닉네임
	    private String quit_phone;			//회원전화번호
	    private Date quit_birth;				//회원생일
	    private String quit_gender;			//회원성별
	    private String quit_email;			//회원이메일
	    private String quit_admin_ck;		//관리자여부
	    
	    public Quit() {}
	    
	    
		public Quit(String quit_user_id, String quit_user_pw, String quit_user_name, String quit_user_nickname,
				String quit_phone, Date quit_birth, String quit_gender, String quit_email, String quit_admin_ck) {
			super();
			this.quit_user_id = quit_user_id;
			this.quit_user_pw = quit_user_pw;
			this.quit_user_name = quit_user_name;
			this.quit_user_nickname = quit_user_nickname;
			this.quit_phone = quit_phone;
			this.quit_birth = quit_birth;
			this.quit_gender = quit_gender;
			this.quit_email = quit_email;
			this.quit_admin_ck = quit_admin_ck;
		}


		public String getQuit_user_id() {
			return quit_user_id;
		}


		public void setQuit_user_id(String quit_user_id) {
			this.quit_user_id = quit_user_id;
		}


		public String getQuit_user_pw() {
			return quit_user_pw;
		}


		public void setQuit_user_pw(String quit_user_pw) {
			this.quit_user_pw = quit_user_pw;
		}


		public String getQuit_user_name() {
			return quit_user_name;
		}


		public void setQuit_user_name(String quit_user_name) {
			this.quit_user_name = quit_user_name;
		}


		public String getQuit_user_nickname() {
			return quit_user_nickname;
		}


		public void setQuit_user_nickname(String quit_user_nickname) {
			this.quit_user_nickname = quit_user_nickname;
		}


		public String getQuit_phone() {
			return quit_phone;
		}


		public void setQuit_phone(String quit_phone) {
			this.quit_phone = quit_phone;
		}


		public Date getQuit_birth() {
			return quit_birth;
		}


		public void setQuit_birth(Date quit_birth) {
			this.quit_birth = quit_birth;
		}


		public String getQuit_gender() {
			return quit_gender;
		}


		public void setQuit_gender(String quit_gender) {
			this.quit_gender = quit_gender;
		}


		public String getQuit_email() {
			return quit_email;
		}


		public void setQuit_email(String quit_email) {
			this.quit_email = quit_email;
		}


		public String getQuit_admin_ck() {
			return quit_admin_ck;
		}


		public void setQuit_admin_ck(String quit_admin_ck) {
			this.quit_admin_ck = quit_admin_ck;
		}


		@Override
		public String toString() {
			return "Quit [quit_user_id=" + quit_user_id + ", quit_user_pw=" + quit_user_pw + ", quit_user_name="
					+ quit_user_name + ", quit_user_nickname=" + quit_user_nickname + ", quit_phone=" + quit_phone
					+ ", quit_birth=" + quit_birth + ", quit_gender=" + quit_gender + ", quit_email=" + quit_email
					+ ", quit_admin_ck=" + quit_admin_ck + "]";
		}

	    
	    
}
