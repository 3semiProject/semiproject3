package org.sixpack.semi.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.member.model.dao.MemberDao;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.member.model.vo.PhoneSns;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("MemberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	@Override	//회원 id find for phone
	public String selectFindIdPhone(Member member) {
		return memberDao.selectFindIdPhone(member);
	}
	//회원 id find for email
	@Override
	public String selectFindIdEmail(Member member) {
		return memberDao.selectFindIdEmail(member);
	}
	//회원 pw find for phone
	@Override
	public Member selectFindPwPhone(Member member) {
		return memberDao.selectFindPwPhone(member);
	}
	//회원 pw find for email
	@Override
	public Member selectFindPwEmail(Member member) {
		return memberDao.selectFindPwEmail(member);
	}
	
	//my post count
	@Override
	public int selectCountMyPost(String user_id) {
		return memberDao.selectCountMyPost(user_id);
	}
	
	//my reply count
	@Override
	public int selectCountMyReply(String user_id) {
		return memberDao.selectCountMyReply(user_id);
	}
	

	@Override
	public Member selectMember(String user_id) {
		return memberDao.selectMember(user_id);
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

	
	//핸드폰 인증 난수생성 메소드
	@Override
	public String sendRandomMsg(String phone) {
		PhoneSns msg = new PhoneSns();
		
		//4자리 랜덤숫자 생성
		String randomNumber = Integer.toString((int)((Math.random() * (9999 - 1000 + 1)) + 1000));
		
		
		
		System.out.println("다뮤니티 문자 인증 : [" + randomNumber + "]");
		
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
	
	//신규회원 조회용 메서드
	@Override
	public ArrayList<Member> selectNewMemberList() {
		return memberDao.selectNewMemberList();

	}

	@Override
	public int selectListCount() {
		return memberDao.selectListCount();
	}

	@Override
	public ArrayList<Member> selectList(Paging page) {
		return memberDao.selectList(page);
	}

	@Override
	public int updateLoginok(Member member) {
		return memberDao.updateLoginok(member);
	}

	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return memberDao.selectSearchListCount(countSearch);
	}

	@Override
	public ArrayList<Member> selectSearchId(Searchs searchs) {
		return memberDao.selectSearchId(searchs);
	}

	@Override
	public ArrayList<Member> selectSearchName(Searchs searchs) {
		return memberDao.selectSearchName(searchs);
	}

	@Override
	public ArrayList<Member> selectSearchNick(Searchs searchs) {
		return memberDao.selectSearchNick(searchs);
	}
	@Override
	public ArrayList<Member> selectSearchPhone(Searchs searchs) {
		return memberDao.selectSearchPhone(searchs);
	}

	@Override
	public ArrayList<Member> selectSearchEmail(Searchs searchs) {
		return memberDao.selectSearchEmail(searchs);
	}
	
	@Override
	public ArrayList<Member> selectSearchBirth(SearchDate searchDate) {
		return memberDao.selectSearchBirth(searchDate);
	}

	@Override
	public ArrayList<Member> selectSearchEnroll(SearchDate searchDate) {
		return memberDao.selectSearchEnroll(searchDate);
	}

	@Override
	public ArrayList<Member> selectSearchGender(Searchs searchs) {
		return memberDao.selectSearchGender(searchs);
	}

	@Override
	public ArrayList<Member> selectSearchLoginok(Searchs searchs) {
		return memberDao.selectSearchLoginok(searchs);
	}
	@Override
	public ArrayList<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int updateFindpwE(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public String SendEmail(Member member) {
		// TODO Auto-generated method stub
		return null;
	}
	
	








	
	
	
}
