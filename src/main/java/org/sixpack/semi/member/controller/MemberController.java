package org.sixpack.semi.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.member.model.service.MemberService;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

@Controller  //xml 에 클래스를 controller 로 자동 등록해 줌
public class MemberController {
    //이 컨트롤로 안의 메소드들이 구동되었는지 확인하는 로그를
    //출력하기 위한 로그 객체를 생성
    private static final Logger logger =
            LoggerFactory.getLogger(MemberController.class);

    @Autowired  //자동 의존성주입(DI) : 자동 객체 생성됨
    private MemberService memberService;

    //웹 서비스 요청 하나당 메소드 하나씩 작성하는 방식임 *****
    //뷰 페이지 이동 처리용 ------------------------------------

    //로그인 페이지 내보내기용 메소드
    @RequestMapping(value = "loginPage.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String moveLoginPage() {
        return "member/loginPage";
    }


    //서비스와 연결되는 요청 처리용 ----------------------------

    //로그인 처리용 메소드 : Servlet 방식으로 처리
//	@RequestMapping(value="login.do", method=RequestMethod.POST)
//	public String loginMethod(HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		
//		//1. 전송온 값 꺼내기		
//		Member member = new Member();
//		member.setUserid(request.getParameter("userid"));
//		member.setUserpwd(request.getParameter("userpwd"));
//		
//		//2. 서비스 모델로 전송하고 결과 받기
//		Member loginMember = memberService.selectLogin(member);
//		
//		//3. 받은 결과를 가지고 성공/실패 페이지를 선택해서 리턴함
//		if(loginMember != null) {
//			//세션 생성
//			HttpSession session = request.getSession();
//			session.setAttribute("loginMember", loginMember);
//			return "common/main";
//		}else {
//			model.addAttribute("message", "로그인 실패!");
//			return "common/error";
//		}
//	}

    //로그인 처리용 메소드 : command 객체 사용
    //서버로 전송 온 parameter 값을 저장하는 객체를 command 객체라고 함
    //input 태그의 name 과 vo 객체의 필드명이 같으면 됨
    @RequestMapping(value = "login.do", method = RequestMethod.POST)
    public String loginMethod(Member member,
                              HttpSession session, SessionStatus status,
                              Model model) {
        logger.info("login.do : " + member);

        //서비스 모델로 전달하고 결과 받기
        Member loginMember = memberService.selectLogin(member);

        if (loginMember != null) {
            session.setAttribute("loginMember", loginMember);
            status.setComplete();  //로그인 요청 성공, 200 전송함
            return "common/main";
        } else {
            model.addAttribute("message",
                    "로그인 실패 : 아이디나 암호 확인하세요.<br>"
                            + "또는 로그인 제한된 회원인지 관리자에게 문의하세요.");
            return "common/error";
        }
    }

    @RequestMapping("logout.do")
    public String logoutMethod(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        //서비스 모델로 전달하고 결과 받기

        if (session != null) {
            session.invalidate();
            return "common/main";
        } else {
            model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
            return "common/error";
        }
    }

    @RequestMapping("enrollPage.do")
    public String moveEnrollMethod() {
        return "member/enrollPage";
    }


    @RequestMapping(value = "idchk.do", method = RequestMethod.POST)
    public void dupCheckIdMethod(@RequestParam("userid") String userid, HttpServletResponse response) throws IOException {
        int idCount = memberService.selectDupCheckId(userid);
        String returnStr = null;
        if (idCount == 0)
            returnStr = "ok";
        else
            returnStr = "no";


        // response 를 이용해서 클라이언트와 출력스트림을 연결하고 값 보냄
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.append(returnStr);
        out.flush();
        out.close();
    }

    // 회원가입 요청 처리용 메소드
    @RequestMapping(value = "enroll.do", method = RequestMethod.POST)
    public String memberInsertMethod(Member member, Model model) {

        logger.info("enroll.do : " + member);


        if (memberService.insertMember(member) > 0)
            return "common/main";
        else {
            //회원가입 실패시
            model.addAttribute("message", "회원가입 실패");
            return "common/error";
        }

    }

    // 마이페이지 클릭시 내 정보 보기 요청 처리용 메소드
    // 리턴 타입은 String, ModelAndView 사용가능
    @RequestMapping(value = "myinfo.do")
    public ModelAndView memberDetailMethod(
            @RequestParam("userid") String userid, ModelAndView mv) {

        // 서비스로 아이디 전달하고, 해당 회원정보 받기
        Member member = memberService.selectMember(userid);

        if (member != null) {
            mv.addObject("member", member);
            // request.setAttribute("member", member);

            mv.setViewName("member/myinfoPage");
        } else {
            mv.addObject("message", userid + " : 회원 정보 조회 실패");
            mv.setViewName("common/error");

        }

        return mv;
    }


    @RequestMapping("moveup.do")
    public String moveUpdatePageMethod(
            @RequestParam String userid, Model model
    ) {
        Member member = memberService.selectMember(userid);

        if (member != null) {
            model.addAttribute("member", member);
            return "member/updatePage";
        } else {
            model.addAttribute("message", userid + " : 회원조회 실패");
            return "common/error";
        }
    }

    @RequestMapping(value = "mupdate.do", method = RequestMethod.POST)
    public String memberUpdateMethod(Member member, Model model) {

        logger.info("member.do : " + member);
        if (memberService.updateMember(member) > 0) {
            return "redirect:myinfo.do?userid=" + member.getUserid();

        } else {
            model.addAttribute("message", "회원정보 수정 실패");
            return "common/error";
        }
    }


    @RequestMapping("mdel.do")
    public String memberDeleteMethod(@RequestParam("userid") String userid, Model model) {
        logger.info("mde.do : " + userid);

        if (memberService.deleteMember(userid) > 0) {
            // 회원 탈퇴 성공시
            // 컨트롤러 메소드에서 다른 컨트롤러 메소드 호출 가능
            return "redirect:logout.do";

        } else {
            // 회원 탈퇴 실패시
            model.addAttribute("message", "회원 탈퇴 오류");
            return "common/error";
        }
    }

    @RequestMapping("mlist.do")
    public String memberListViewMethod(Model model) {
        ArrayList<Member> list = memberService.selectList();
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "member/memberListView";
        } else {
            model.addAttribute("message", "회원 정보가 존재하지 않습니다");
            return "common/error";
        }
    }

    @RequestMapping("loginok.do")
    public String loginOKMethod(Member member, Model model) {
        logger.info("loginok.do : " + member.getUserid() + ", " + member.getLogin_ok());
        if (memberService.updateLoginok(member) > 0)
            return "redirect:mlist.do";
        else {
            model.addAttribute("message", "로그인 제한 처리 오류 발생");
            return "common/error";
        }
    }

    @RequestMapping("msearch.do")
    public String memberSearchMethod(HttpServletRequest request, Model model) {
        logger.info("msearch.do : " + request);

        String action = request.getParameter("action");
        String keyword = null;
        String beginDate = null;
        String endDate = null;

        if (action.equals("enroll_date")) {
            beginDate = request.getParameter("begin");
            endDate = request.getParameter("end");

        } else {
            keyword = request.getParameter("keyword");
        }
        ArrayList<Member> list = null;
        switch (action) {
            case "id":
                list = memberService.selectSearchUserid(keyword);
                break;
            case "gender":
                list = memberService.selectSearchGender(keyword);
                break;
            case "age":
                list = memberService.selectSearchAge(Integer.parseInt(keyword));
                break;
            case "enroll_date":
                list = memberService.selectSearchEnrollDate(
                        new SearchDate(Date.valueOf(beginDate), Date.valueOf(endDate)));
                break;
            case "login_ok":
                list = memberService.selectSearchLoginOK(keyword);
                break;
        }
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "member/memberListView";
        } else {
            model.addAttribute("message", " 검색에 대한 결과가 존재하지 않습니다");
            return "common/error";
        }
    }

}










