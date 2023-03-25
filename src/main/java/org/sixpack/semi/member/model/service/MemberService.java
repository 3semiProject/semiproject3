package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.member.model.vo.Member;

public interface MemberService {
	Member selectLogin(Member member);
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
	
}
