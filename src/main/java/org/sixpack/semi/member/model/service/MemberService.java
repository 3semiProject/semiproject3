package org.sixpack.semi.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.member.model.vo.Member;

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




    //서치 메소드
    int selectSearchListCount(CountSearch countSearch);
    ArrayList<Member> selectSearchId(Searchs searchs);
    ArrayList<Member> selectSearchName(Searchs searchs);
    ArrayList<Member> selectSearchNick(Searchs searchs);
    ArrayList<Member> selectSearchPhone(Searchs searchs);
    ArrayList<Member> selectSearchEmail(Searchs searchs);
    ArrayList<Member> selectSearchEnroll(SearchDate searchDate);
    ArrayList<Member> selectSearchBirth(SearchDate searchDate);
    ArrayList<Member> selectSearchGender(Searchs searchs);
    ArrayList<Member> selectSearchLoginok(Searchs searchs);

}
