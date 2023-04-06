package org.sixpack.semi.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.kakao.model.service.KakaoService;
import org.sixpack.semi.member.model.service.MemberService;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	//암호화
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncder;
	
	//이메일 인증 api
	@Autowired
    private JavaMailSender mailSender;
	
	//소셜로그인 카카오 api
	@Autowired
	private KakaoService kakaoService;


	// login 처리용 메소드
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(@RequestParam("user_id") String user_id, @RequestParam("user_pw") String user_pw, Model model,
			HttpSession session) {
		logger.info("login.do : " + user_id);
		
		//로그인 요청한 회원의 아이디 존재유무 체크 및 변수에 저장
		Member loginMember = memberService.selectMember(user_id);
		logger.info(loginMember.getProfile_renamefile());
		if (loginMember != null && this.bcryptPasswordEncder.matches(user_pw, loginMember.getUser_pw())) {
			session.setAttribute("loginMember", loginMember);
			logger.info(loginMember.getUser_id());
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


//	// 소셜로그인이 포함된 로그인 페이지 내보내기용 메소드
//	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public String moveLoginPage(Model model, HttpSession session) {
//		// 카카오 로그인 접속을 위한 인증 url 정보 생성
//		String kakaoAuthURL = KakaoController.getAuthorizationUrl(session);
//
//		// 네이버 로그인 접속을 위한 인증 url 정보 생성
//		String naverAuthURL = KakaoController.getAuthorizationUrl(session);
//
//		// 구글 로그인 접속을 위한 인증 url 정보 생성
//		String googleAuthURL = KakaoController.getAuthorizationUrl(session);
//
//		// 모델에 각각의 url 정보 저장
//		model.addAttribute("kakaourl", kakaoAuthURL);
//		model.addAttribute("googleourl", googleAuthURL);
//		model.addAttribute("naverurl", naverAuthURL);
//
//		return "member/loginPage";
//	}
//
//	// 카카오 로그인 요청 처리용
//	// (카카오 로그인 클릭시 전달된 kakaourl 에 의해 실행됨)
//	@RequestMapping(value = "kcallback.do", produces = "application/json", method = { RequestMethod.GET,
//			RequestMethod.POST })
//	public String kakaoLogin(@RequestParam String code,
//			Model model, HttpSession session) {
//		logger.info("0. kcallback.do : " + code);
//
//		//로그인 결과값을 node에 담아줌
//		JsonNode node = KakaoController.getAccessToken(code);
//		logger.info("1. kcallback.do : " + node);
//		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
//		JsonNode accessToken = node.get("access_token");
//		logger.info("2. kcallback.do : " + accessToken);
//		// 사용자 정보 추출
//		JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
//		logger.info("3. kcallback.do : " + userInfo);
//
//		// db table 에 기록할 회원정보 추출함 : 카카오 회원가입시
//		//userInfo 에서 properties 정보 추출
//		JsonNode properties = node.get("properties");
//		logger.info("4. kcallback.do : " + properties);
//
//		JsonNode kakao_account = userInfo.path("kakao_account");
//		String kid = userInfo.path("id").asText();
//		logger.info("5. kcallback.do : " + kakao_account);
//
//		//등록된 카카오 회원 테이블에서 회원 정보 조회해 옴
//		Kakao kmember =
//				kakaoService.selectKakaoLogin(kid);
//
//		Member loginMember = null;
//
//		//처음 로그인 요청시 카카오 회원 테이블에 회원 정보 저장
//		if(kmember == null) {
//			Kakao kakao = new Kakao();
//			//properties 에서 하나씩 꺼내서 member 에 저장 처리
//			kakao.setKakao_id(kid);
//			kakao.setKakao_name((String)properties.get("kakao_name").asText());
//			kakao.setEmail((String)kakao_account.get("email").asText());
//
//			logger.info("6. kcallback.do : " + kakao);
//
//			kakaoService.insertKakaoMember(kakao);
//			loginMember = kakao;
//		}else {
//			loginMember = kmember;
//		}
//
//		if (loginMember != null) {
//			// 카카오 로그인 성공시
//			session.setAttribute("loginMember", loginMember);
//			return "redirect:main.do";
//		} else {
//			model.addAttribute("message", "카카오 로그인 실패!");
//			return "common/error";
//		}
//	}
//
//	// 네이버 로그인 요청 처리용
//	// (네이버 로그인 클릭시 전달된 naverurl 에 의해 실행됨)
//	@RequestMapping(value = "ncallback.do",
//			method = { RequestMethod.GET, 	RequestMethod.POST })
//	public String naverLogin(Model model, HttpSession session) {
//
//		Member loginMember = null;
//
//		if (loginMember != null) {
//			// 카카오 로그인 성공시
//			session.setAttribute("loginMember", loginMember);
//			return "redirect:main.do";
//		} else {
//			model.addAttribute("message", "카카오 로그인 실패!");
//			return "common/error";
//		}
//	}
//
//	// 구글 로그인 요청 처리용
//	// (구글 로그인 클릭시 전달된 googleurl 에 의해 실행됨)
//	@RequestMapping(value = "gcallback.do",
//			method = { RequestMethod.GET, 	RequestMethod.POST })
//	public String googleLogin(
//			Model model, HttpSession session) {
//
//		Member loginMember = null;
//
//		if (loginMember != null) {
//			// 카카오 로그인 성공시
//			session.setAttribute("loginMember", loginMember);
//			return "redirect:main.do";
//		} else {
//			model.addAttribute("message", "카카오 로그인 실패!");
//			return "common/error";
//		}
//	}

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
	
	
	// 회원탈퇴 페이지 내보내기용 메소드
	@RequestMapping(value = "deletePage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView moveDeletePage(@RequestParam("user_id") String user_id, ModelAndView mv) {
		Member member = memberService.selectMember(user_id);
		
		mv.addObject("member", member);
		mv.setViewName("member/deletePage");
		
		return mv;
	}
	
	
	//------------------------------------------------------------------------------------------
	
	//회원정보 수정 페이지 요청 전, 비밀번호 체크 팝업창 내보내기용 메소드
	@RequestMapping(value = "pwCheckPopUp.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView movePwCheckPopUp(/*@RequestParam("user_id") String user_id,*/ ModelAndView mv, HttpSession session) {
		Member member = ((Member)session.getAttribute("loginMember"));
				//(Member)memberService.selectMember(user_id)
				String user_id = member.getUser_id();
		//Member member = (Member)memberService.selectMember(user_id);
		
		if (member != null) {
			mv.addObject("user_id", user_id);
			mv.addObject("user_nickname", member.getUser_nickname());
			mv.setViewName("member/pwCheckPopUp");
		}
//		} else {
//			mv.addObject("user_id", user_id);
////			mv.setViewName("common/error");
//			mv.setViewName("redirect:myinfo.do?user_id=" + user_id);
//		}
		
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
	
	// ajax 통신으로 핸드폰 인증번호 요청 처리용 메소드(naver cloud)
	@RequestMapping(value = "authNumber.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String phoneAuth(@RequestParam("phone") String phone, HttpSession session) {

		try { // 이미 가입된 전화번호가 있으면
			if (memberService.selectPhoneCount(phone) > 0)
				return "0";
		} catch (Exception e) {
			e.printStackTrace();
		}

		String code = memberService.sendRandomMsg(phone);
		return code;
	}


	// 회원가입 요청 처리용 메소드
	@RequestMapping(value = "enroll.do",  method = { RequestMethod.GET, RequestMethod.POST })
	public String memberinsertMethod(Member member, Model model) {
		logger.info("enroll.do : " + member);
		member.setUser_pw(bcryptPasswordEncder.encode(member.getUser_pw()));
		
		   logger.info("after encode : " + member.getUser_pw());
		     logger.info("length : " + member.getUser_pw().length());
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
	
	// 회원정보 수정 전 비밀번호 확인
	@RequestMapping(value = "selectPw.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView selectPwMethod(@RequestParam("user_pw") String user_pw, @RequestParam("user_id") String user_id, ModelAndView mv) {;
	
	logger.info("user_id : " + user_id);
		Member member = memberService.selectMember(user_id);
	
		if (member != null) {
			if(this.bcryptPasswordEncder.matches(user_pw, member.getUser_pw())) {
				mv.addObject("member", member);
				mv.setViewName("member/updatePage"); 
				
			}else{
				mv.addObject("message", member.getUser_nickname() + "님 비밀번호 입력이 잘못되었습니다.");
				mv.setViewName("common/redirectErrorPage");
			}
		} else {
			mv.addObject("message", member.getUser_nickname() + "님 회원 정보 불러오기 실패!😞");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	
	
//	// 회원정보 비밀번호 수정
//	@RequestMapping(value = "updatePw.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public String memberUpdateMethod(Member member, Model model) {
//		logger.info("updatePw.do : " + member);
//
//		if (memberService.updatePw(member) > 0) {
//			// 수정이 성공했다면, 컨트롤러의 메소드를 직접 호출함
//			// 필요시, 값을 전달할 수도 있음 : 쿼리스트링 사용함
//			// ?이름=값&이름=값
//			return "redirect:myinfo.do?user_pw=" + member.getUser_pw();
//		} else {
//			model.addAttribute("message", member.getUser_pw() + " : 회원 정보 수정 실패😞");
//			return "common/error";
//		}
//	}

	// 마이페이지 클릭시 내 정보 보기 요청 처리용 메소드
	@RequestMapping(value = "myinfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView showMypageMethod(/*@RequestParam("user_id") String user_id,*/ ModelAndView mv, HttpSession session) {
		// 서비스로 아이디 전달하고, 해당 회원정보 받기
		String user_id = ((Member)session.getAttribute("loginMember")).getUser_id();
				
		//String user_id = request.getParameter("user_id");
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
//
//	// 회원정보 수정 처리용 : 수정 성공시 myinfoPage.jsp 로 이동함
//	@RequestMapping(value = "updateMember.do", method = { RequestMethod.GET, RequestMethod.POST })
//	public String updateMemberMethod(Member member, Model model) {
//
//		if (memberService.updateMember(member) > 0) {
//			// 수정이 성공했다면, 컨트롤러의 메소드를 직접 호출함
//			// 필요시, 값을 전달할 수도 있음 : 쿼리스트링 사용함
//			// ?이름=값&이름=값
//			return "redirect:myinfo.do?user_id=" + member.getUser_id();
//		} else {
//			model.addAttribute("message", member.getUser_id() + " : 회원 정보 수정 실패😞");
//			return "common/error";
//		}
//	}
	
	//회원정보 수정 처리용 : 수정 성공시 myinfoPage.jsp 로 이동
	@RequestMapping(value="mupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String memberUpdateMethod(@RequestParam("user_id") String user_id, @RequestParam("user_pw") String new_user_pw,
									@RequestParam("phone") String new_phone, @RequestParam("email") String new_email,
									@RequestParam(name="upProfile", required = false) MultipartFile newProfile
									 ,Model model, HttpServletRequest request) {
		
		Member member = memberService.selectMember(user_id);
		String origin_user_pw = member.getUser_pw();
		String origin_phone = member.getPhone();
		String origin_email = member.getPhone();
		
		//프로필 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath(
							"resources/profile_upfiles");
		
		logger.info("origin_user_pw : " + origin_user_pw);
		logger.info("new_user_pw : " + new_user_pw);
		logger.info("new_phone : " + new_phone);
		logger.info("new_email : " + new_email);
		logger.info(newProfile.toString());
		
		//새로운 프로필 존재시,
		if(!newProfile.isEmpty()) {
			
			//기존 프로필 존재시,
			if(member.getProfile_originfile() != null) {
				new File(savePath +"/" + member.getProfile_renamefile()).delete();
				member.setProfile_originfile(null);
				member.setProfile_renamefile(null);
			}
			
			//프로필이름 추출하기
			String profileName = newProfile.getOriginalFilename();
			
			//이름 중복으로 덮어쓰기 방지하기 위해 이름 변경하기
			if(profileName != null && profileName.length() > 0) {
				String renameProfile = FileNameChange.change(profileName, "yyyyMMddHHmmss");
				
				//check
				logger.info("profile name check : " + profileName +
						"renaming profile : " + renameProfile);
				
				//폴더에 저장
				try {
					newProfile.transferTo(new File(
							savePath + "/" + renameProfile));
				}catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "프로필 첨부파일 저장 실패!");
					return "common/error";
				}
				//db 저장
				member.setProfile_originfile(profileName);
				member.setProfile_renamefile(renameProfile);
			}
		}
		
		
		//새로운 암호 전송 받을 시, 패스워드 암호화 처리
//		//사용시 공백 자동 제거되게해야 오류 발생 안됨
//		String user_pw = member.getUser_pw().trim();
		new_user_pw = new_user_pw.trim();
		new_phone = new_phone.trim();
		new_email = new_email.trim();
		
		//새로운 비밀번호 입력시,
		if(new_user_pw != null && new_user_pw.length() > 0) {//userpwd에 값이 들어왔다면,
			//암호화된 기존의 패스워드 !== 새로운 패스워드O
			if(!this.bcryptPasswordEncder.matches(new_user_pw, origin_user_pw)) {
				//member에 새로운 패스워드 암호화해서 기록
				member.setUser_pw(bcryptPasswordEncder.encode(new_user_pw));
			}
	
			logger.info(member.getUser_pw());
		} else {	//새 암호가 들어오지 않은 경우
			//새로운 패스워드 값이 존재하지 않을 시, member에 원래 패스워드 기록
			member.setUser_pw(origin_user_pw); //기존의 패스워드 암호화가 이미 된 상태라 새로 암호화할 필요 없음
		

		}
		
		//새로운 핸드폰번호 입력시,
		if(new_phone != null && new_phone.length() > 0) {//phone에 값이 들어왔다면,
			member.setPhone(new_phone);

			
		} else {	//새 phone 들어오지 않은 경우
			//phone null, member에 원래 phone 기록
			member.setPhone(origin_phone); 
		

		}
		
		//새로운 이메일 입력시,
		if(new_email != null && new_email.length() > 0) {//email에 값이 들어왔다면,
			member.setEmail(new_email);
			
			
		} else {	//새 email 들어오지 않은 경우
			//email null, member에 원래 email 기록
			member.setEmail(origin_email); 
			

		}
		
		if(memberService.updateMember(member) > 0) {	//처리된 행의 갯수가 1개이상이냐
			//수정 성공시, 컨트롤러의 메소드를 직접 호출 처리
			//필요시, 값을 전달 가능 : 쿼리스트링 사용.
			//queryString : ?name=value&name=value
			return "redirect:myinfo.do?user_id=" + member.getUser_id();
		} else {
			model.addAttribute("message", member.getUser_nickname() + " : 회원 정보 수정 실패!");
			return "common/error";
		}
	}
	
	
	
	

	// 회원 탈퇴(삭제) 요청 처리용
	@RequestMapping(value = "deleteMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView deleteMemberMethod(@RequestParam("user_id") String user_id, ModelAndView mv) {
		logger.info("deleteMember.do: " + user_id);
		Member member = memberService.selectMember(user_id);
		
			if(member != null) { //해당 유저 존재시,
			if (memberService.deleteMember(user_id) > 0) {	//해당 멤버 삭제
				if(memberService.insertQuitMember(member) > 0) {	//해당 멤버의 정보를 삭제테이블로 이동
					logger.info(user_id + "님 삭제 테이블로 이동 성공!");
				} else {
					logger.info(user_id + "님 삭제 테이블로 이동 실패!");
				}
			// 회원 탈퇴 성공시 , 자동 로그아웃 처리해야 함
			// 컨트롤러 메소드에서 다른 [컨트롤러] 메소드 호출할 수 있음
				mv.addObject("message", user_id + "님 안녕히 가세요😞");
				mv.setViewName("redirect:logout.do");
		} else {
			mv.addObject("message", user_id + " : 회원 삭제 실패😞");
			mv.setViewName("common/error");
		}
		}
			return mv;

	}

	
	
	
	
//	---------------------------------------------------------------------------
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
	
//------------------------------------------------------------------------------
    /* 이메일 인증 */
    @RequestMapping(value="mailCheck.do", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        logger.info("이메일 데이터 전송 확인");
        logger.info("인증번호 : " + email);
        
        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        logger.info("인증번호 : " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "hjm8686@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "다뮤니티를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        return num;
        
    }

}
