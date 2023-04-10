package org.sixpack.semi.kakao.controller;

import java.util.HashMap;

import org.sixpack.semi.kakao.model.service.KakaoService;
import org.sixpack.semi.member.controller.MemberController;
import org.sixpack.semi.member.model.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value="/member/*")
public class KakaoController {
    private KakaoService kakaoService;
    private MemberService memberService;
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

//    @RequestMapping("kakao_login.do")
//    public String kakaoLogin() {
//        StringBuffer loginUrl = new StringBuffer();
//        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
//        loginUrl.append("3205654a3e1700ef0d67201d929a9c56"); 
//        loginUrl.append("&redirect_uri=");
//        loginUrl.append("http://localhost:8889/semi/kakao_login.do"); 
//        loginUrl.append("&response_type=code");
//        
//        return "redirect:"+loginUrl.toString();
//    }
//    	private final static String K_CLIENT_ID = 
//    			"3205654a3e1700ef0d67201d929a9c56";
//    	//카카오 개발자에 등록된 로그인용 redirect uri
//    	private final static String K_REDIRECT_URI = 
//    			"http://localhost:8889/semi/kakao_callback.do";
    	
    	@RequestMapping(value="kakao_callback.do", method=RequestMethod.GET)
    	public String kakaoLogin(@RequestParam(value = "code", required = false) String code) throws Exception {
    		System.out.println("#########" + code);
    		String access_Token = kakaoService.getAccessToken(code);
    		HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
    		System.out.println("###access_Token#### : " + access_Token);
    		System.out.println("###nickname#### : " + userInfo.get("nickname"));
    		System.out.println("###email#### : " + userInfo.get("email"));
    		return "redirect:/";
        	}

    	
    	
    	
    	
    	//카카오 로그인 요청시 카카오 로그인 페이지로 이동 url 리턴용
//    	public String getAuthorizationUrl(HttpSession session) {
//    		String kakaoURL = 
//    				"https://kauth.kakao.com/oauth/authorize?"
//    				+ "client_id=" + K_CLIENT_ID 
//    				+ "&redirect_uri=" + K_REDIRECT_URI
//    				+ "&response_type=code";
//    		
//    		return kakaoURL;
//    	}
//    
//    @RequestMapping(value = "kakao_callback.do", method = RequestMethod.GET)
//    public String redirectkakao(@RequestParam String code, HttpSession session) throws IOException {
//            System.out.println(code);
//            
//            //접속토큰 get
//            String kakaoToken = kakaoService.getReturnAccessToken(code);
//            
//            //접속자 정보 get
//            Map<String,Object> result = kakaoService.getUserInfo(kakaoToken);
//            System.out.println("컨트롤러 출력"+result.get("nickname")+result.get("email"));
//            SessionConfigVO configVO =new SessionConfigVO();
//            configVO.setUser_name((String)result.get("nickname"));
//            configVO.setUser_id((String)result.get("email"));
//            
//            
//            session.setAttribute("sessionConfigVO", configVO);
//            /*로그아웃 처리 시, 사용할 토큰 값*/
//            session.setAttribute("kakaoToken", kakaoToken);
//        return "redirect:/";
//    }

//    @RequestMapping(value="/login/logout_proc")
//    public String logout(ModelMap modelMap, HttpSession session)throws IOException {
////        if(SystemUtil.EmptyCheck((String)session.getAttribute("kakaoToken"))){
////        }else {
////            kakaoService.getLogout((String)session.getAttribute("kakaoToken"));
////        }
////        session.setAttribute("sessionConfigVO", null);
////        HashMap<String, String> message = new HashMap<>();
////        message.put("title", "로그아웃");
////        message.put("script", "location.href='/'");
////        message.put("msg", "로그아웃 되었습니다");
////        message.put("type","alert");
////        modelMap.addAttribute("message",message);
////        return "/comm/alert_message";
//    }

}
