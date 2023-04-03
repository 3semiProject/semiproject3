package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.member.model.vo.Member;

public interface MemberService {
	Member selectFindIdPhone(Member member);
	Member selectFindIdEmail(Member member);
	Member selectFindPwId(Member member);
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
	int deleteMember(String user_id);
	//난수생성 메소드
	public String sendRandomMsg(String phone);
	//회원가입시 이미 가입된 전화번호 있는지 확인하는 메소드
	int selectPhoneCount(String phone);
	int insertQuitMember(Member member);
	
}
