package org.sixpack.semi.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	// login 처리용 메소드
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, Model model) {
		logger.info("login.do : " + member);
		
		Member loginMember = memberService.selectLogin(member);

		if (loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 실패 : 아이디나 암호 확인하세요.<br>" + "또는 로그인 제한된 회원인지 관리자에게 문의하세요.");
			return "common/error";
		}
	}
	
	// logout 처리용 메소드
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		logger.info("logout.do" + session);
		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}

	}
	
	// 로그인 페이지 내보내기용 메소드
	@RequestMapping(value = "enrollPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage() {
		return "member/loginPage";
	}
	
	// ajax 통신으로 아이디 중복확인 요청 처리용 메소드
	@RequestMapping(value = "idChk.do", method = RequestMethod.POST) // 전송방식 틀리면 405 에러
	public void dupCheckIdMethod(@RequestParam("userid") String user_id, HttpServletResponse response)
			throws IOException {
		int idCount = memberService.selectDupCheckId(user_id);

		String returnStr = null;
		if (idCount == 0) {
			returnStr = "ok";
		} else {
			returnStr = "duple";
		}

		// response 를 이용해서 클라이언트와 출력스트림을 연결하고 값 보냄
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();

	}
	
	// ajax 통신으로 아이디 중복확인 요청 처리용 메소드
	@RequestMapping(value = "nickChk.do", method = RequestMethod.POST) // 전송방식 틀리면 405 에러
	public void dupCheckNickMethod(@RequestParam("user_nickname") String user_nickname, HttpServletResponse response)
			throws IOException {
		int idCount = memberService.selectDupCheckNick(user_nickname);

		String returnStr = null;
		if (idCount == 0) {
			returnStr = "ok";
		} else {
			returnStr = "duple";
		}

		// response 를 이용해서 클라이언트와 출력스트림을 연결하고 값 보냄
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();

	}
	
	// ajax 통신으로 아이디 중복확인 요청 처리용 메소드
	@RequestMapping(value = "phoneChk.do", method = RequestMethod.POST) // 전송방식 틀리면 405 에러
	public void dupCheckPhoneMethod(@RequestParam("phone") String phone, HttpServletResponse response)
			throws IOException {
		int idCount = memberService.selectDupCheckPhone(phone);

		String returnStr = null;
		if (idCount == 0) {
			returnStr = "ok";
		} else {
			returnStr = "duple";
		}

		// response 를 이용해서 클라이언트와 출력스트림을 연결하고 값 보냄
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();

	}
	
	// 회원가입 요청 처리용 메소드
	@RequestMapping(value = "enroll.do", method = RequestMethod.POST)
	public String memberinsertMethod(Member member, Model model) {
		logger.info("enroll.do : " + member);

		if (memberService.insertMember(member) > 0) {
			// 회원가입 성공
			return "common/main";
		} else {
			// 회원가입 실패
			model.addAttribute("message", "회원 가입 실패😞");
			return "common/error";
		}
	}
	@RequestMapping("findIdPhone.do")
	public String findIdPhoneMethod(HttpServletResponse response, Member member, Model model) {
		return null;
	}
	@RequestMapping("findIdEmail.do")
	public String findIdEmailMethod(HttpServletResponse response, Member member, Model model) {
		return null;
	}
	@RequestMapping("findPwId.do")
	public String findpwIMethod(HttpServletResponse response, Member member, Model model) {
		return null;
	}
	@RequestMapping("findPwEmailr.do")
	public String findpwEmailMethod(HttpServletResponse response, Member member, Model model) {
		return null;
	}
	@RequestMapping("findPwEmail.do")
	public String findpwEMethod(HttpServletResponse response, Member member, Model model) {
		return null;
	}
	@RequestMapping("sendEmail.do")
	public String sendEmailMethod(HttpServletResponse response, @RequestParam("email") String email) {
		return null;
	}
	@RequestMapping("ShowPfofile.do")
	public String showProfileMethod(Member member, Model model) {
		return null;
	}
	@RequestMapping("showNickname.do")
	public String showNicknameMethod(Member member, Model model) {
		return null;
	}
	
	// 회원정보 비밀번호 수정
	@RequestMapping(value = "updatePw.do", method = RequestMethod.POST)
	public String memberUpdateMethod(Member member, Model model) {
		logger.info("updatePw.do : " + member);

		if (memberService.updatePw(member) > 0) {
			// 수정이 성공했다면, 컨트롤러의 메소드를 직접 호출함
			// 필요시, 값을 전달할 수도 있음 : 쿼리스트링 사용함
			// ?이름=값&이름=값
			return "redirect:myinfo.do?user_pw=" + member.getUser_pw();
		} else {
			model.addAttribute("message", member.getUser_pw() + " : 회원 정보 수정 실패😞");
			return "common/error";
		}
	}
	
	// 마이페이지 클릭시 내 정보 보기 요청 처리용 메소드
	@RequestMapping("myinfo.do")
	public ModelAndView showMypageMethod(@RequestParam("user_id") String user_id, ModelAndView mv) {
		// 서비스로 아이디 전달하고, 해당 회원정보 받기
		logger.info(user_id);
		Member member = memberService.selectMember(user_id);

		if (member != null) {
			mv.addObject("member", member); // requestSetAttribute("member", member) 와 같음
			// Model 또는 ModelAndView 에 저장하는 것은
			// request.setAttribute("member", member); 와 같음
			mv.setViewName("member/myinfoPage");
		} else {
			mv.addObject("message", user_id + " : 회원 정보 조회 실패😞");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 회원정보 수정 처리용 : 수정 성공시 myinfoPage.jsp 로 이동함
	@RequestMapping(value = "updateMember.do", method = RequestMethod.POST)
	public String updateMemberMethod(Member member, Model model) {
		logger.info("updateMember.do : " + member);

		if (memberService.updateMember(member) > 0) {
			// 수정이 성공했다면, 컨트롤러의 메소드를 직접 호출함
			// 필요시, 값을 전달할 수도 있음 : 쿼리스트링 사용함
			// ?이름=값&이름=값
			return "redirect:myinfo.do?userid=" + member.getUser_id();
		} else {
			model.addAttribute("message", member.getUser_id() + " : 회원 정보 수정 실패😞");
			return "common/error";
		}
	}
	
	// 회원 탈퇴(삭제) 요청 처리용
	@RequestMapping("deleteMember.do")
	public String deleteMemberMethod(@RequestParam("user_id") String user_id, Model model) {
		logger.info("deleteMember.do: " + user_id);

		if (memberService.deleteMember(user_id) > 0) {
			// 회원 탈퇴 성공시 , 자동 로그아웃 처리해야 함
			// 컨트롤러 메소드에서 다른 [컨트롤러] 메소드 호출할 수 있음
			return "redirect:logout.do";
		} else {
			model.addAttribute("message", user_id + " : 회원 삭제 실패😞");
			return "common/error";
		}

	}
	
	// 회원 전체 출력???
	@RequestMapping("memberList.do")
	public String showMmeberListMethod(Model model) {
		ArrayList<Member> list = memberService.selectMemberList();

		if (list != null && list.size() > 0) {
			model.addAttribute("list", list);
			return "member/memberListView";
		} else {
			model.addAttribute("message", "회원 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}
	
}


