package org.sixpack.semi.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.banner.model.service.BannerService;
import org.sixpack.semi.bfaf.model.service.BfafService;
import org.sixpack.semi.event.model.service.EventService;
import org.sixpack.semi.eyebody.model.service.EyebodyService;
import org.sixpack.semi.faq.model.service.FaqService;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.hotnew.model.service.HotNewService;
import org.sixpack.semi.log.model.service.LogService;
import org.sixpack.semi.member.model.service.MemberService;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.notice.model.service.NoticeService;
import org.sixpack.semi.qna.model.service.QnaService;
import org.sixpack.semi.tip.model.service.TipService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private MemberService memberService;
	
	//관리자 전용 board
	@Autowired
	private NoticeService noticeService; //notice
	@Autowired
	private EventService eventService;	// event
	
	
	//고객센터
	@Autowired
	private QnaService qnaService;	//qna
	@Autowired
	private FaqService faqServie;	//faq
	
	//banner
	@Autowired
	private BannerService bannerService; //youtube, article
	
	//log
	@Autowired
	private LogService logService; //접속자수 관리 log
	
	
	//boards
	@Autowired
	private HotNewService hotNewService;
	@Autowired
	private FreeService freeService;
	@Autowired
	private TipService tipService;
	@Autowired
	private EyebodyService eyebodyService;
	@Autowired
	private BfafService bfafService;
	
	
	//페이지 전송용 메소드
	@RequestMapping(value="boardMgt.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String moveBoardMgtPage() {
		return "admin/boardMgtPage";
	}
	

	
	
	
	
	
	
	
	//------------------------------------------------------------
	
	
	//기능관련 메소드
	
	//main view top&분석
	@RequestMapping(value="newMember.do", method={ RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String newMemberMethod() throws UnsupportedEncodingException {
		ArrayList<Member> list = memberService.selectNewMemberList();
		logger.info("newMember.do : " + list.size());
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(Member member : list) {
			JSONObject job = new JSONObject();
			job.put("user_id", member.getUser_id());
			job.put("user_name", URLEncoder.encode(member.getUser_name(), "utf-8"));
			job.put("user_nickname", URLEncoder.encode(member.getUser_nickname(), "utf-8"));
			job.put("phone", member.getPhone());
			job.put("birth", member.getBirth().toString());
			job.put("gender", member.getGender());
			job.put("email", member.getEmail());
			job.put("join_date", member.getJoin_date().toString());
			
			//8가지 리스트에 넣어요.
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	
	
	
	
	//회원 작성 총 게시물 카운트 메소드
	@RequestMapping(value="adminBox.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String adminBoxShowMethod(Model model) {
		//오늘 접속자 수
		String visitorsT = Integer.toString(logService.visitCount());
		
		//월 접속자 수(해당 달 총 접속자수=> 데일리로 누적됨)
		String visitorsM = Integer.toString(logService.visitCountMonth());
		
		//월평균 접속자 수(한달 평균 접속자수)
		String visitorsAvg = Integer.toString(logService.visitCountAvg());
		
		
		//총게시물 수 
		//String postCount = hotNewService.selectTotalPostCount();
		
		
		//총 코멘트수
		//String commentCount = hotNewService.selectTotalCommentCount();
		
		
		//map이든 list든 받아서 넘겨주고 프론트단에서 출력하기
//		Map<String, String> countBox = new HashedMap ();
//		countBox.put("visitorsT", visitorsT);
//		countBox.put("visitorsM", visitorsM);
//		countBox.put("visitorsAvg", visitorsAvg);
//		
//		model.addAttribute("countBox", countBox);
		
		model.addAttribute("visitorsT", visitorsT);
		model.addAttribute("visitorsM", visitorsM);
		model.addAttribute("visitorsAvg", visitorsAvg);
		
		logger.info("adminBox.do 실행");
		return "common/mainbox";
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}