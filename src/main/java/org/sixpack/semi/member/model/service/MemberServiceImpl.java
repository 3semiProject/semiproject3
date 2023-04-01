package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.member.model.dao.MemberDao;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.member.model.vo.PhoneSns;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;

	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}

	@Override
	public Member selectFindIdPhone(Member member) {
		return memberDao.selectFindIdPhone(member);
	}

	@Override
	public Member selectFindIdEmail(Member member) {
		return memberDao.selectFindIdEmail(member);
	}

	@Override
	public Member selectFindPwId(Member member) {
		return memberDao.selectFindPwId(member);
	}

	@Override
	public Member selectFindPwEmail(Member member) {
		return memberDao.selectFindPwEmail(member);
	}

	@Override
	public Member selectProfile(Member member) {
		return memberDao.selectProfile(member);
	}

	@Override
	public Member selectNickname(Member member) {
		return memberDao.selectNickname(member);
	}

	@Override
	public Member selectMember(String user_id) {
		return memberDao.selectMember(user_id);
	}

	@Override
	public int updateFindpwE(Member member) {
		return memberDao.updateFindpwE(member);
	}

	@Override
	public String SendEmail(Member member) {
		return memberDao.SendEmail(member);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int updatePw(Member member) {
		return memberDao.updatePw(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String user_id) {
		return memberDao.deleteMember(user_id);
	}

	@Override
	public int selectDupCheckId(String user_id) {
		return memberDao.selectDupCheckId(user_id);
	}

	@Override
	public int selectDupCheckNick(String user_nickname) {
		return memberDao.selectDupCheckNick(user_nickname);
	}

	@Override
	public int selectDupCheckPhone(String phone) {
		return memberDao.selectDupCheckPhone(phone);
	}

	@Override  //수정필요
	public ArrayList<Member> selectMemberList() {
		return memberDao.selectMemberList();
	}

	
	//핸드폰 인증 난수생성 메소드
	@Override
	public String sendRandomMsg(String phone) {
		PhoneSns msg = new PhoneSns();
		
		//4자리 랜덤숫자 생성
		String randomNumber = Integer.toString((int)((Math.random() * (9999 - 1000 + 1)) + 1000));
		
		
		
		System.out.println("회원가입 문자 인증 : " + randomNumber);
		
		msg.send_msg(phone, randomNumber);
		
		return randomNumber;
	}

	@Override
	public int selectPhoneCount(String phone) {
		
		return memberDao.selectPhoneCount(phone);
	}
	
	//회원탈퇴시, 탈퇴테이블로 추가하는 메서드
	@Override
	public int insertQuitMember(Member member) {
		return  memberDao.insertQuitMember(member);
	}

	
	
}
