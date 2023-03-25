package org.sixpack.semi.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.member.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public Member selectLogin(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectFindIdPhone(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectFindIdEmail(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectFindPwId(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectFindPwEmail(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectProfile(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectNickname(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectMember(String user_id) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateFindpwE(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public String SendEmail(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updatePw(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateMember(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectDupCheckId(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectDupCheckNick(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectDupCheckPhone(String phone) {
		// TODO Auto-generated method stub
		return 0;
	}

	public ArrayList<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

}
