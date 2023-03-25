package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.member.model.dao.MemberDao;
import org.sixpack.semi.member.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//스프링에서는 서비스 모델 클래스는 서비스 인터페이스를 상속받아서
//만들도록 되어 있음
@Service("memberService")  //xml 자동 등록 처리됨
public class MemberServiceImpl implements MemberService {

    //DAO 와 연결 처리
    @Autowired  //자동 DI 처리됨 : 자동 객체 생성됨
            MemberDao memberDao;

    @Override
    public Member selectLogin(Member member) {
        return memberDao.selectLogin(member);
    }

    @Override
    public ArrayList<Member> selectList() {
        return memberDao.selectList();
    }

    @Override
    public int insertMember(Member member) {
        return memberDao.insertMember(member);
    }

    @Override
    public int updateMember(Member member) {
        return memberDao.updateMember(member);
    }

    @Override
    public int deleteMember(String userid) {
     return memberDao.deleteMember(userid);
    }

    @Override
    public int selectDupCheckId(String userid) {
        return memberDao.selectDupCheckId(userid);
    }

    @Override
    public Member selectMember(String userid) {
        return memberDao.selectMember(userid);
    }

    @Override
    public int updateLoginok(Member member) {
        return memberDao.updateLoginok(member);
    }

    @Override
    public ArrayList<Member> selectSearchUserid(String keyword) {
        return memberDao.selectSearchUserid(keyword);
    }

    @Override
    public ArrayList<Member> selectSearchGender(String keyword) {
        return memberDao.selectSearchGender(keyword);
    }

    @Override
    public ArrayList<Member> selectSearchAge(int age) {
        return memberDao.selectSearchAge(age);
    }

    @Override
    public ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate) {
        return memberDao.selectSearchEnrollDate(searchDate);
    }

    @Override
    public ArrayList<Member> selectSearchLoginOK(String keyword) {
        return memberDao.selectSearchLoginOK(keyword);
    }
}
