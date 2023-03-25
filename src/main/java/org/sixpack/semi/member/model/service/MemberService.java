package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.member.model.vo.Member;

//스프링에서는 모델의 서비스 클래스는 인터페이스로 만들도록 정해져 있음
public interface MemberService {
    Member selectLogin(Member member);

    ArrayList<Member> selectList();

    int insertMember(Member member);

    int updateMember(Member member);

    int deleteMember(String userid);

    int selectDupCheckId(String userid);

    Member selectMember(String userid);

    int updateLoginok(Member member);

    ArrayList<Member> selectSearchUserid(String keyword);

    ArrayList<Member> selectSearchGender(String keyword);

    ArrayList<Member> selectSearchAge(int age);

    ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate);

    ArrayList<Member> selectSearchLoginOK(String keyword);

}
