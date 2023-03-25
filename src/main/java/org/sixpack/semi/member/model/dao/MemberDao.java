package org.sixpack.semi.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.member.model.vo.Member;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("memberDao")
public class MemberDao {
    //마이바티스 매퍼 파일에 쿼리문 별도로 작성함
    //root-context.xml 에 생성된 마이바티스 매퍼 연결 객체를 사용함
    @Autowired  //root-context.xml 에서 생성한 객체와 자동 연결
    private SqlSessionTemplate session;  //의존성 주입됨(DI)

    public Member selectLogin(Member member) {
        return session.selectOne("memberMapper.selectLogin", member);
    }


    public ArrayList<Member> selectList() {
        List<Member> list = session.selectList("memberMapper.selectList");
        return (ArrayList<Member>) list;
    }


    public int insertMember(Member member) {
        return session.insert("memberMapper.insertMember", member);
    }


    public int updateMember(Member member) {
        return session.update("memberMapper.updateMember", member);
    }


    public int deleteMember(String userid) {
        return session.delete("memberMapper.deleteMember", userid);
    }

    public int selectDupCheckId(String userid) {
        return session.selectOne("memberMapper.selectDupCheckId", userid);
    }

    public Member selectMember(String userid) {
        return session.selectOne("memberMapper.selectMember", userid);
    }

    public int updateLoginok(Member member) {
        return session.update("memberMapper.updateLoginok", member);
    }

    public ArrayList<Member> selectSearchUserid(String keyword) {
        List<Member> list = session.selectList("memberMapper.selectSearchUserid", keyword);
        return (ArrayList<Member>) list;
    }


    public ArrayList<Member> selectSearchGender(String keyword) {
        List<Member> list = session.selectList("memberMapper.selectSearchGender", keyword);
        return (ArrayList<Member>) list;
    }

    public ArrayList<Member> selectSearchAge(int age) {
        List<Member> list = session.selectList("memberMapper.selectSearchAge", age);
        return (ArrayList<Member>) list;
    }

    public ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate) {
        List<Member> list = session.selectList("memberMapper.selectSearchEnrollDate", searchDate);
        return (ArrayList<Member>) list;
    }

    public ArrayList<Member> selectSearchLoginOK(String keyword) {
        List<Member> list = session.selectList("memberMapper.selectSearchLoginOK", keyword);
        return (ArrayList<Member>) list;
    }
}
