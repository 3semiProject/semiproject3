package org.sixpack.semi.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.kakao.model.vo.Kakao;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.qna.model.vo.Qna;

public interface MemberService {
	//회원 id find for phone
	String selectFindIdPhone(Member member);
	//회원 id find for email
	String selectFindIdEmail(Member member);
	//회원 pw find for phone
	Member selectFindPwPhone(Member member);
	//회원 pw find for email
	Member selectFindPwEmail(Member member);
	Member selectProfile(Member member);
	Member selectNickname(Member member);
	Member selectMember(String user_id);
	int selectDupCheckId(String user_id);
	int selectDupCheckNick(String user_nickname);
	int selectDupCheckPhone(String phone);
	ArrayList<Member> selectMemberList();  // 수정필요
	int updateFindpwE(Member member);
	String SendEmail(Member member);
	int insertMember(Member member);
	int updatePw(Member member);
	int updateMember(Member member);
	int updateLoginok(Member member);
	int deleteMember(String user_id);
	//난수생성 메소드
	public String sendRandomMsg(String phone);
	//회원가입시 이미 가입된 전화번호 있는지 확인하는 메소드
	int selectPhoneCount(String phone);
	int insertQuitMember(Member member);
	ArrayList<Member> selectNewMemberList();
	
	//관리자 페이지
	int selectListCount();
	ArrayList<Member> selectList(Paging page);

	

	
}
