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
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage() {
		return "member/loginPage";
	}

	// 회원가입 페이지 내보내기용 메소드
	@RequestMapping(value = "enrollPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	//회원정보 수정페이지ㅣ 내보내기용 메소드
	@RequestMapping("updateMove.do")
	public String updateMovePage(@RequestParam("user_id") String user_id, Model model) {
		
		logger.info("user_id : " + user_id);
		Member member = (Member)memberService.selectMember(user_id);
		
		if(member != null) {
			model.addAttribute("member", member);
			return "member/updatePage";
		}else {
			model.addAttribute("message", member + " : 회원정보 조회 실패!");
			return "common/error";
		}
	}
	
	//회원정보 수정 페이지 요청 전, 비밀번호 체크 팝업창
	@RequestMapping(value = "pwCheckPopUp.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView movePwCheckPopUp(@RequestParam("user_id") String user_id, ModelAndView mv) {
		Member member = (Member)memberService.selectMember(user_id);
		
		if (member != null) {
			mv.addObject("user_id", user_id);
			mv.addObject("user_nickname", member.getUser_nickname());
			mv.setViewName("member/pwCheckPopUp");
		} else {
			mv.addObject("message", user_id+ " : 회원 정보 수정 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
//	//회원정보 수정 페이지 요청 전, 비밀번호 체크 팝업창
//	@RequestMapping(value = "pwCheckPopUp.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public ModelAndView movePwCheckPopUp(@RequestParam("user_id") String user_id, ModelAndView mv) {
//		Member member = (Member)memberService.selectMember(user_id);
//		
//		if (member != null) {
//			mv.addObject("member", member.getUser_pw()); // requestSetAttribute("member", member) 와 같음
//			// Model 또는 ModelAndView 에 저장하는 것은
//			// request.setAttribute("member", member); 와 같음
//			mv.setViewName("member/pwCheckPopUp");
//		} else {
//			mv.addObject("message", user_id+ " : 회원 정보 수정 실패");
//			mv.setViewName("common/error");
//		}
//		
//		return mv;
//	}
	
	//---------------------------------------------
	// ajax 통신으로 아이디 중복확인 요청 처리용 메소드
	@RequestMapping(value = "idChk.do",  method = { RequestMethod.GET, RequestMethod.POST }) // 전송방식 틀리면 405 에러
	public void dupCheckIdMethod(@RequestParam("user_id") String user_id, HttpServletResponse response)
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

	
	
	// ajax 통신으로 닉네임 중복확인 요청 처리용 메소드
	@RequestMapping(value = "nickChk.do",  method = { RequestMethod.GET, RequestMethod.POST }) // 전송방식 틀리면 405 에러
	public void dupCheckNickMethod(@RequestParam("user_nickname") String user_nickname, HttpServletResponse response)
			throws IOException {
		int nickCount = memberService.selectDupCheckNick(user_nickname);

		String returnStr = null;
		if (nickCount == 0) {
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
	
	//ajax 통신으로 핸드폰 인증번호 요청 처리용 메소드(naver cloud)
	@RequestMapping(value = "authNumber.do",  method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String phoneAuth(@RequestParam("phone") String phone, HttpSession session) {

	    try { // 이미 가입된 전화번호가 있으면
	        if(memberService.selectPhoneCount(phone) > 0) 
	            return "no"; 
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    String code = memberService.sendRandomMsg(phone);
	    session.setAttribute("randomNum", code);
	    
	    return "ok";
	}

	

//	// ajax 통신으로 핸드폰 인증번호 요청 처리용 메소드
//	@RequestMapping(value = "authNumber.do", method = RequestMethod.POST) // 전송방식 틀리면 405 에러
//	@ResponseBody
//	public String authPhoneMethod(@RequestParam("phone") String phone)
//
//
//		System.out.println("실행전 : " +phone);
//
//		String api_key = "NCSL0GK6MED8AM1K";
//		String api_secret = "TH5SWZ2TULUDGTVY6COZLAH8XNQXGHL6";
//		Message coolsms = new Message(api_key, api_secret);
//		System.out.println("asdfasdf" + coolsms);
//
//		// param(to, from, type, text)
//		HashMap<String, String> params = new HashMap<String, String>();
//		params.put("to", phone); // 수신번호
//		params.put("from", "01095326547"); // 발신번호
//		params.put("type", "SMS");
//		params.put("text", "[인증번호]\n" + randomNumber + "\n입니다.");
//		params.put("app_version", "test app 1.2"); // application name and version
//
//		try {
//			JSONObject obj = (JSONObject) coolsms.send(params);
//			System.out.println(obj.toString());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//			return Integer.toString(randomNumber);
//	}

	// 회원가입 요청 처리용 메소드
	@RequestMapping(value = "enroll.do",  method = { RequestMethod.GET, RequestMethod.POST })
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
	
	// 회원정보 비밀번호 확인
	@RequestMapping(value = "selectPw.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectPwMethod(@RequestParam("user_pw") String user_pw, @RequestParam("user_id") String user_id, Model model) {;
	
	logger.info("user_id : " + user_id);
		Member member = memberService.selectMember(user_id);
	
		if (member != null) {
			if(member.getUser_pw().equals(user_pw)) {
				model.addAttribute("member", member);
			return "member/updatePage";
				
			}else{
				model.addAttribute("message", member.getUser_nickname() + "님 비밀번호 입력이 잘 못 되었습니다.");
				return "common/redirectErrorPage";
			}
		} else {
			model.addAttribute("message", member.getUser_nickname() + "님 회원 정보 불러오기 실패!😞");
			return "common/error";
		}
	}
	
	
	

	// 회원정보 비밀번호 수정
	@RequestMapping(value = "updatePw.do", method = { RequestMethod.GET, RequestMethod.POST })
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
	@RequestMapping(value = "myinfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView showMypageMethod(@RequestParam("user_id") String user_id, ModelAndView mv) {
		// 서비스로 아이디 전달하고, 해당 회원정보 받기
		
		logger.info("user_id : " + user_id);
		Member member = (Member)memberService.selectMember(user_id);
		
		if (member != null) {
			mv.addObject("member", member); // requestSetAttribute("member", member) 와 같음
			// Model 또는 ModelAndView 에 저장하는 것은
			// request.setAttribute("member", member); 와 같음
			mv.setViewName("member/myinfoPage");
		} else {
			mv.addObject("message", user_id+ " : 회원 정보 조회 실패😞");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 회원정보 수정 처리용 : 수정 성공시 myinfoPage.jsp 로 이동함
	@RequestMapping(value = "updateMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateMemberMethod(Member member, Model model) {

		if (memberService.updateMember(member) > 0) {
			// 수정이 성공했다면, 컨트롤러의 메소드를 직접 호출함
			// 필요시, 값을 전달할 수도 있음 : 쿼리스트링 사용함
			// ?이름=값&이름=값
			return "redirect:myinfo.do?user_id=" + member.getUser_id();
		} else {
			model.addAttribute("message", member.getUser_id() + " : 회원 정보 수정 실패😞");
			return "common/error";
		}
	}
	
//	//회원정보 수정 처리용 : 수정 성공시 myinfoPage.jsp 로 이동
//	@RequestMapping(value="mupdate.do", method = RequestMethod.POST)
//	public String memberUpdateMethod(Member member, Model model,
//									@RequestParam("origin_userpwd") String originUserpwd) {
//		logger.info("mupdate.do : " + member);
//		
//		//새로운 암호 전송 받을 시, 패스워드 암호화 처리
//		//사용시 공백 자동 제거되게해야 오류 발생 안됨
//		String user_pw = member.getUser_pw().trim();
//		if(userpwd != null && userpwd.length() > 0) {//userpwd에 값이 들어왔다면,
//			//암호화된 기존의 패스워드 !== 새로운 패스워드
//			if(!this.bcryptPasswordEncder.matches(user_pw, originUserpwd)) {
//				//member에 새로운 패스워드 암호화해서 기록
//				member.setUserpwd(bcryptPasswordEncoder.encode(userpwd));
//			}
//			
//		} else {	//새 암호가 들어오지 않은 경우
//			//새로운 패스워드 값이 존재하지 않을 시, member에 원래 패스워드 기록
//			member.setUserpwd(originUserpwd); //기존의 패스워드 암호화가 이미 된 상태라 새로 암호화할 필요 없음
//
//		}
//		
//		
//		if(memberService.updateMember(member) > 0) {	//처리된 행의 갯수가 1개이상이냐
//			//수정 성공시, 컨트롤러의 메소드를 직접 호출 처리
//			//필요시, 값을 전달 가능 : 쿼리스트링 사용.
//			//queryString : ?name=value&name=value
//			return "redirect:myinfo.do?userid=" + member.getUserid();
//		} else {
//			model.addAttribute("message", member.getUserid() + " : 회원 정보 수정 실패!");
//			return "common/error";
//		}
//	}
//	

	// 회원 탈퇴(삭제) 요청 처리용
	@RequestMapping(value = "deleteMember.do", method = { RequestMethod.GET, RequestMethod.POST })
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
