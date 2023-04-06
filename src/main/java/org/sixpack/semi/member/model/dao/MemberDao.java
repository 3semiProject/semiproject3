package org.sixpack.semi.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.hotnew.model.vo.HotNew;
import org.sixpack.semi.member.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;


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
		return session.selectOne("memberMapper.selectMember", user_id);
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
		return session.insert("memberMapper.insertMember", member);

	}

	public int updatePw(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateMember(Member member) {
		return session.update("memberMapper.updateMember", member);
	}

	public int updateMember(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectDupCheckId(String user_id) {
		return session.selectOne("memberMapper.selectDupCheckId", user_id.toUpperCase());
	}

	public int selectDupCheckNick(String user_nickname) {
		return session.selectOne("memberMapper.selectDupCheckNick", user_nickname);
	}

	public int selectDupCheckPhone(String phone) {
		// TODO Auto-generated method stub
		return 0;
	}

	public ArrayList<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	//회원가입시 해당 핸드폰 번호가 존재하는지 확인하는 메소드
	public int selectPhoneCount(String phone) {
		return session.selectOne("memberMapper.selectPhoneCount", phone);
	}
	
	//회원탈퇴시, 탈퇴테이블로 추가하는 메서드
	public int insertQuitMember(Member member) {
		return session.insert("quitMapper.insertQuitMember", member);
	}

	//회원탈퇴시, 기본테이블 null값으로 변경(delete 대신 null처리 pk라서 삭제가 불가능함)
	public int deleteMember(String user_id) {
		return session.update("memberMapper.deleteMember", user_id);
	}
	
	//새회원 리스트 출력. admin main에 출력되는 list
	public ArrayList<Member> selectNewMemberList() {
		List<Member> list = session.selectList("memberMapper.selectNewMemberList");
		return (ArrayList<Member>)list;
	}



}
