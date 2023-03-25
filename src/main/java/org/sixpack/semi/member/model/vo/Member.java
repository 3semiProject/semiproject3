package org.sixpack.semi.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
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

}
