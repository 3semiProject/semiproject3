package org.sixpack.semi.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.banner.model.service.BannerService;
import org.sixpack.semi.bfaf.model.service.BfafService;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.bfaf.model.vo.LikeBfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange2;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.event.model.service.EventService;
import org.sixpack.semi.event.model.vo.Event;
import org.sixpack.semi.eyebody.model.service.EyebodyService;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.eyebody.model.vo.LikeEyebody;
import org.sixpack.semi.faq.model.service.FaqService;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.free.model.vo.LikeFree;
import org.sixpack.semi.hotnew.model.service.HotNewService;
import org.sixpack.semi.hotnew.model.vo.HotNew;
import org.sixpack.semi.log.model.service.LogService;
import org.sixpack.semi.member.model.service.MemberService;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.notice.model.service.NoticeService;
import org.sixpack.semi.notice.model.vo.Notice;
import org.sixpack.semi.qna.model.service.QnaService;
import org.sixpack.semi.tip.model.service.TipService;
import org.sixpack.semi.tip.model.vo.LikeTip;
import org.sixpack.semi.tip.model.vo.Tip;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller("adminController")
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
	@ResponseBody
	public String adminBoxShowMethod(HttpServletResponse response) {
		//오늘 접속자 수
		String visitorsT = Integer.toString(logService.visitCount());
		
		//월 접속자 수(해당 달 총 접속자수=> 데일리로 누적됨)
		String visitorsM = Integer.toString(logService.visitCountMonth());
		
		//월평균 접속자 수(한달 평균 접속자수)
		//월접속자수를 view단에서 일수로 나누기. => if문 사용
		// <c:if test="new Date().substring(4, 6) == '02'">
		 Date date = new Date();
		 String visitorsAvg;
		 if(date.toString().substring(4, 6) == "02") {
			visitorsAvg  = Integer.toString(logService.visitCountMonth()/28);
		 }else if(date.toString().substring(4, 6) == "04" || date.toString().substring(4, 6) == "06" ||
				 date.toString().substring(4, 6) == "09" || date.toString().substring(4, 6) == "11") {
				visitorsAvg  = Integer.toString(logService.visitCountMonth()/30);

		 }else {
				visitorsAvg  = Integer.toString(logService.visitCountMonth()/31);

		 }

		//총게시물 수 
		String postCount = String.valueOf(freeService.selectListCount() + tipService.selectListCount() 
						+ eyebodyService.selectListCount() + bfafService.selectListCount());
 		
		
		//총 유해게시물 수
		String blackPostCount;
		
		//mimiType
		response.setContentType("application/json; charset=utf-8");
		
		JSONObject job = new JSONObject();
		
		job.put("visitorsT", visitorsT);
		job.put("visitorsM", visitorsM);
		job.put("visitorsAvg", visitorsAvg);
		job.put("postCount", postCount);
		
		
		
//		map이든 list든 받아서 넘겨주고 프론트단에서 출력하기
//		Map<String, String> countBox = new HashedMap ();
//		countBox.put("visitorsT", visitorsT);
//		countBox.put("visitorsM", visitorsM);
		//countBox.put("visitorsAvg", visitorsAvg);
//		
//		model.addAttribute("countBox", countBox);
//		
//		model.addAttribute("visitorsT", "100");
//		model.addAttribute("visitorsM", visitorsM);
		//model.addAttribute("visitorsAvg", visitorsAvg);
		//PrintWriter out = response.getWriter();
//		
//		out.append(visitorsT);
//		out.append(visitorsM);
//		out.flush();
//		out.close();
		logger.info("adminBox.do 실행");
		
		
		return job.toJSONString();
		
	}
	
	

	//게시글 통합관리에서 각 보드별 전체 목록보기 요청 처리용
		@RequestMapping("adminBoardList.do")
		@ResponseBody
		public ModelAndView adminBoardList(@RequestParam(name = "page", required = false) String page,
											 @RequestParam(name = "option", required = false) String option,
											 ModelAndView mv) {
			
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			int limit = 10;
			int listCount = 0;
			Paging paging = null;
			
//			switch (option) {
//			case "black": listCount = hotNewService.selectListCount(); 
//						paging = new Paging(listCount, currentPage, limit);
//						paging.calculator();
//						ArrayList<HotNew> list = hotNewService.hotSelectList(paging);
//						break;
//			case "hot": listCount = hotNewService.selectListCount(); 
//						paging = new Paging(listCount, currentPage, limit);
//						paging.calculator();
//						list = hotNewService.hotSelectList(paging);
//						break;
//			case "new": listCount = hotNewService.selectListCount();
//						paging = new Paging(listCount, currentPage, limit);
//						paging.calculator();
//						list = hotNewService.newSelectList(paging);
//						break;			
//			case "free": listCount = freeService.selectListCount();
//						paging = new Paging(listCount, currentPage, limit);
//						paging.calculator();
//						ArrayList<Free> list = hotNewService.newSelectList(paging);
//						break;	
//			case "tip": listCount = tipService.selectListCount(); break;
//			case "eye": listCount = eyebodyService.selectListCount(); break;
//			case "bf": listCount = bfafService.selectListCount(); break;
//			case "notice": listCount = noticeService.selectListCount(); break;
//			case "event": listCount = eventService.selectListCount(); break;
//
//			}
			
			ArrayList list = new ArrayList();
			if(option == "black") {
				listCount = hotNewService.selectListCount(); 
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = hotNewService.hotSelectList(paging);
			}
			if(option == "hot") {
				listCount = hotNewService.selectListCount(); 
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = hotNewService.hotSelectList(paging);
			}
			if(option == "new") {
				listCount = hotNewService.selectListCount(); 
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = hotNewService.newSelectList(paging);
			}
			if(option == "free") {
				listCount = freeService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = freeService.selectList(paging);
			}
			if(option == "tip") {
				listCount = tipService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = tipService.selectList(paging);
			}
			if(option == "eye") {
				listCount = eyebodyService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = eyebodyService.selectList(paging);
			}
			if(option == "bf") {
				listCount = bfafService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = bfafService.selectList(paging);
			}
			if(option == "notice") {
				listCount = noticeService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = noticeService.selectList(paging);
			}
			if(option == "event") {
				listCount = eventService.selectListCount();
				paging = new Paging(listCount, currentPage, limit);
				paging.calculator();
				list = eventService.selectList(paging);
			}
			
			//JSONObject sendJson = new JSONObject();
			//JSONObject job = new JSONObject();
			
			if(list != null && list.size() > 0) {
				//JSONArray jarr = new JSONArray();
				
				//job.put("list", list);
				//job.put("paging", paging);
				
//				jarr.add(job);	
			
				mv.addObject("list", list);
				mv.addObject("paging", paging);
				mv.addObject("option", option);
				
				mv.setViewName("admin/boardMgtPage");
			}else {
				mv.addObject("message", "등록된 공지사항 정보가 없습니다.");
				mv.setViewName("common/error");
			}
			return mv;
			
			//return sendJson.toJSONString(job);
	}
	
	
	
	
//	
//	//게시글 검색용
//		@RequestMapping(value="adminSearch.do", method={ RequestMethod.GET, RequestMethod.POST })
//		public ModelAndView noitceSearchMethod(
//				@RequestParam(name = "page", required = false, defaultValue = "1") String page,
//				@RequestParam("searchtype") String searchtype,
//				@RequestParam("keyword") String keyword,
//				/* HttpServletRequest request, */ ModelAndView mv) {
////			String searchtype = request.getParameter("searchtype");
////			String keyword = request.getParameter("keyword");
//			
//			CountSearch countSearch = new CountSearch(searchtype, keyword);
//			
//			int currentPage = 1;
//			if(page != null) {
//				currentPage = Integer.parseInt(page);
//			}
//			
//			int limit = 10;
//			int listCount = noticeService.selectSearchListCount(countSearch);
//			Searchs searchs = new Searchs(listCount, currentPage, limit);
//			searchs.calculator();
//			
//			searchs.setSearchtype(searchtype);
//			searchs.setKeyword(keyword);
//			
//			ArrayList<Notice> list;
//			
//			if(searchtype.equals("nname")) {
//				list = noticeService.selectSearchTitle(searchs);
//				if(list != null && list.size() > 0) {
//					mv.addObject("list", list);
//					mv.addObject("searchs", searchs);
//					
//					mv.setViewName("notice/noticeListView2");
//				}
//			}else if(searchtype.equals("ncontent")) {
//				list = noticeService.selectSearchContent(searchs);
//				if(list != null && list.size() > 0) {
//					mv.addObject("list", list);
//					mv.addObject("searchs", searchs);
//					
//					mv.setViewName("notice/noticeListView2");
//				}
//			}else if(searchtype.equals("nid")) {
//				list = noticeService.selectSearchWriter(searchs);
//				if(list != null && list.size() > 0) {
//					mv.addObject("list", list);
//					mv.addObject("searchs", searchs);
//					
//					mv.setViewName("notice/noticeListView2");
//				}
//			}else {
//				mv.addObject("message", currentPage + "로 검색된 공지글 정보가 없습니다.");
//				mv.setViewName("common/error");
//			}
//			return mv;
//		}
		
		
	//[유해게시물관리]----------------------------------------------------------	
		
		
		
		
//		
//	public ModelAndView hormFulPost(@RequestParam(name = "page", required = false) String page, ModelAndView mv){
//		   int currentPage = 1;
//		      if (page != null) {
//		         currentPage = Integer.parseInt(page);
//		      }
//
//		      int limit = 10;
//		      int listCount = freeService.selectListCount();
//		      Paging paging = new Paging(listCount, currentPage, limit);
//
//		      ArrayList<Free> list = freeService.selectList(paging);
//		      if (list != null && list.size() > 0) {
//		         mv.addObject("list", list);
//		         mv.addObject("paging", paging);
//
//		         mv.setViewName("admin/adminFree");
//		      } else {
//		         mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
//		         mv.setViewName("common/error");
//		      }
//		
//		
//		
//		
//		
//		
//		return mv;
//	}
		
		

//	
	//----------------------------------------------------------	
	// hotnewdetail.do
	@RequestMapping(value = "adHotnewdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectDetailMethod(@RequestParam("hotnew_no") int hotnew_no, Model model, HttpSession session,
			@RequestParam("hotnew_name") String hotnew_name, @RequestParam("user_id") String user_id) {
		HotNew hotnew = new HotNew();
		hotnew.setHotnew_no(hotnew_no);
		hotnew.setHotnew_name(hotnew_name);
		hotnew.setUser_id(user_id);
		System.out.println(hotnew);
		if (hotNewService.selectFree(hotnew) != null) {
			return "redirect:freedetail.do?free_no=" + hotnew.getHotnew_no() + "&user_id="
					+ ((Member) session.getAttribute("loginMember")).getUser_id();
		} else if (hotNewService.selectTip(hotnew) != null) {
			return "redirect:tipdetail.do?tip_no=" + hotnew.getHotnew_no() + "&user_id="
					+ ((Member) session.getAttribute("loginMember")).getUser_id();
		} else if (hotNewService.selectEyebody(hotnew) != null) {
			return "redirect:eyebodydetail.do?eyebody_no=" + hotnew.getHotnew_no() + "&user_id="
					+ ((Member) session.getAttribute("loginMember")).getUser_id();
		} else if (hotNewService.selectBfaf(hotnew) != null) {
			return "redirect:bfafdetail.do?bfaf_no=" + hotnew.getHotnew_no() + "&user_id="
					+ ((Member) session.getAttribute("loginMember")).getUser_id();
		} else {
			model.addAttribute("message", hotnew.getHotnew_no() + "번 게시물 조회 실패");
			return "common/error";
		}

	}

	// hot list view
	@RequestMapping("adHotlist.do")
	public ModelAndView hotListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = hotNewService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();

		ArrayList<HotNew> list = hotNewService.hotSelectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("admin/adminHot");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}

	@RequestMapping(value = "adHotsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView hotSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = hotNewService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<HotNew> list;
		if (searchtype.equals("hotname")) {
			list = hotNewService.hotSelectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminHot2");
			}
		} else if (searchtype.equals("hotvalue")) {
			list = hotNewService.hotSelectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminHot2");
			}
		} else if (searchtype.equals("hotid")) {
			list = hotNewService.hotSelectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminHot2");
			}
		}
		if (mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("admin/adminHot2");
			return mv;
		} else {
			return mv;
		}
	}

	@RequestMapping(value = "adNewsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView newSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = hotNewService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<HotNew> list;
		if (searchtype.equals("newname")) {
			list = hotNewService.hotSelectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminNew2");
			}
		} else if (searchtype.equals("newvalue")) {
			list = hotNewService.hotSelectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminNew2");
			}
		} else if (searchtype.equals("newid")) {
			list = hotNewService.hotSelectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("admin/adminNew2");
			}
		}
		if (mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("admin/adminNew2");
			return mv;
		} else {
			return mv;
		}
	}

	@RequestMapping("adNewlist.do")
	public ModelAndView newListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = hotNewService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();

		ArrayList<HotNew> list = hotNewService.newSelectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("admin/adminNew");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
//[free]----------------------------------------------------	
	
	  // 리스트
	   @RequestMapping(value = "adFreelist.do", method = { RequestMethod.GET, RequestMethod.POST })
	   @ResponseBody
	   public ModelAndView freeListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
	      int currentPage = 1;
	      if (page != null) {
	         currentPage = Integer.parseInt(page);
	      }

	      int limit = 10;
	      int listCount = freeService.selectListCount();
	      Paging paging = new Paging(listCount, currentPage, limit);

	      ArrayList<Free> list = freeService.selectList(paging);
	      if (list != null && list.size() > 0) {
	         mv.addObject("list", list);
	         mv.addObject("paging", paging);

	         mv.setViewName("admin/adminFree");
	      } else {
	         mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
	         mv.setViewName("common/error");
	      }
	      return mv;
	   }
	
	   //검색
	   @RequestMapping(value = "adFreesearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public ModelAndView freeSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
	         HttpServletRequest request, ModelAndView mv) {
	      String searchtype = request.getParameter("searchtype");
	      String keyword = request.getParameter("keyword");

	      CountSearch countSearch = new CountSearch(searchtype, keyword);

	      int currentPage = 1;
	      if (page != null) {
	         currentPage = Integer.parseInt(page);
	      }

	      int limit = 10;
	      int listCount = freeService.selectSearchListCount(countSearch);
	      Searchs searchs = new Searchs(listCount, currentPage, limit);

	      searchs.setSearchtype(searchtype);
	      searchs.setKeyword(keyword);

	      ArrayList<Free> list;
	      if (searchtype.equals("fname")) {
	         list = freeService.selectSearchTitle(searchs);
	         if (list != null && list.size() > 0) {
	            mv.addObject("list", list);
	            mv.addObject("searchs", searchs);

	            mv.setViewName("admin/adminFree2");
	         }
	      } else if (searchtype.equals("fvalue")) {
	         list = freeService.selectSearchValue(searchs);
	         if (list != null && list.size() > 0) {
	            mv.addObject("list", list);
	            mv.addObject("searchs", searchs);

	            mv.setViewName("admin/adminFree2");
	         }
	      } else if (searchtype.equals("fid")) {
	         list = freeService.selectSearchWriter(searchs);
	         if (list != null && list.size() > 0) {
	            mv.addObject("list", list);
	            mv.addObject("searchs", searchs);

	            mv.setViewName("admin/adminFree2");
	         }
	      }
	      
	      if(mv.isEmpty()) {
	         mv.addObject("searchs", searchs);
	         mv.setViewName("admin/adminFree2");
	         return mv;
	      }else {
	         return mv;
	      }
	   }
	


	   // 댓글,대댓글 삭제 처리용
	   @RequestMapping(value = "adFreerepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public String freeRepDeleteMethod(@RequestParam("freeno") int freeno, Free free, Model model) {
	      if (freeService.deleteReple(free) > 0) {
	         return "redirect:adminFree.do?free_no=" + freeno;
	      } else {
	         model.addAttribute("message", "게시글 삭제 실패!");
	         return "common/error";
	      }
	   }


	   // 원글 삭제 처리용
	   @RequestMapping(value = "adFreedelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public String freedeleteMethod(@RequestParam("free_no") int free_no, Model model) {
	      if (freeService.deleteFreeBoard(free_no) > 0) {
	         return "redirect:adminFreelist.do";
	      } else {
	         model.addAttribute("message", "게시글 삭제 실패!");
	         return "common/error";
	      }
	   }

	   // 게시글 상세보기 처리용
	   @RequestMapping(value = "adFreedetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public ModelAndView adFreedDetailMethod(ModelAndView mv, @RequestParam("free_no") int free_no,
	         @RequestParam(name = "user_id", required = false) String user_id,
	         @RequestParam(name = "page", required = false) String page) {
	      int currentPage = 1;
	      if (page != null) {
	         currentPage = Integer.parseInt(page);
	      }

	      // 조회수 1 증가 처리
	      freeService.updateBoardReadcount(free_no);

	      // 해당 게시글 조회
	      ArrayList<Free> list = freeService.selectRepleList(free_no);
	      Free free = freeService.selectBoard(free_no);
	      Free free2 = new Free();
	      free2.setUser_id(user_id);
	      free2.setFree_no(free_no);
	      
	      LikeFree likeFree =   freeService.selectLikeFree(free2);
	      
	      if (list != null) {
	         mv.addObject("list", list);
	      }
	      
	      if(likeFree != null) {
	         mv.addObject("likeFree", likeFree);
	      }

	      if (free != null) {
	         if(free.getOriginfile_free() != null) {
	            String[] ofiles = free.getOriginfile_free().split(" ");
	            String[] rfiles = free.getRenamefile_free().split(" ");
	            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
	            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
	            mv.addObject("ofile", ofile);
	            mv.addObject("rfile", rfile);
	         }
	         mv.addObject("free", free);
	         mv.addObject("currentPage", currentPage);

	         mv.setViewName("admin/freeDetailView");
	      } else {
	         mv.addObject("message", free_no + "번 게시글 조회 실패!");
	         mv.setViewName("common/error");
	      }

	      return mv;
	   }

	   // 첨부파일 다운로드 요청 처리용
	   @RequestMapping(value = "adFreedown.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public ModelAndView adFreeFileDownMethod(ModelAndView mv, HttpServletRequest request,
	         @RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
	      // 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
	      String savePath = request.getSession().getServletContext().getRealPath("resources/free_upfiles");

	      // 저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
	      File renameFile = new File(savePath + "\\" + renameFileName);
	      // 파일 다운시 내보낼 원래 이름의 파일 객체 생성함
	      File originFile = new File(originalFileName);

	      // 파일 다운로드 뷰로 전달할 정보 저장
	      mv.setViewName("filedown"); // 등록된 파일다운로드 뷰의 id명
	      mv.addObject("renameFile", renameFile);
	      mv.addObject("originFile", originFile);

	      return mv;
	   }

	  
//[tip]----------------------------------------------------	
	   
	// 리스트
		@RequestMapping(value = "adTiplist.do", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public ModelAndView tipListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = tipService.selectListCount();
			Paging paging = new Paging(listCount, currentPage, limit);

			ArrayList<Tip> list = tipService.selectList(paging);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("paging", paging);

				mv.setViewName("admin/adminTip");
			} else {
				mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
				mv.setViewName("common/error");
			}
			return mv;
		}

		// 검색
		@RequestMapping(value = "adTipsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView tipSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
				HttpServletRequest request, ModelAndView mv) {
			String searchtype = request.getParameter("searchtype");
			String keyword = request.getParameter("keyword");

			CountSearch countSearch = new CountSearch(searchtype, keyword);

			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = tipService.selectSearchListCount(countSearch);
			Searchs searchs = new Searchs(listCount, currentPage, limit);

			searchs.setSearchtype(searchtype);
			searchs.setKeyword(keyword);

			ArrayList<Tip> list;
			if (searchtype.equals("tname")) {
				list = tipService.selectSearchTitle(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminTip2");
				}
			} else if (searchtype.equals("tvalue")) {
				list = tipService.selectSearchValue(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminTip2");
				}
			} else if (searchtype.equals("tid")) {
				list = tipService.selectSearchWriter(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminTip2");
				}
			}
			if(mv.isEmpty()) {
				mv.addObject("searchs", searchs);
				mv.setViewName("admin/adminTip2");
				return mv;
			}else {
				return mv;
			}
		}  
	   
	   
		// 댓글,대댓글 삭제 처리용
		@RequestMapping(value = "adTiprepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String tipRepDeleteMethod(@RequestParam("tipno") int tipno, Tip tip, Model model) {
			if (tipService.deleteReple(tip) > 0) {
				return "redirect:adTipdetail.do?tip_no=" + tipno;
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}
	   
	   
		// 원글 삭제 처리용
		@RequestMapping(value = "adTipdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String tipdeleteMethod(@RequestParam("tip_no") int tip_no, Model model) {
			if (tipService.deleteTipBoard(tip_no) > 0) {
				return "redirect:adminTip.do";
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}

		// 게시글 상세보기 처리용
		   @RequestMapping(value = "adTipdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
		   public ModelAndView tipDetailMethod(ModelAndView mv, @RequestParam("tip_no") int tip_no,
		         @RequestParam(name = "user_id", required = false) String user_id,
		         @RequestParam(name = "page", required = false) String page) {
		      int currentPage = 1;
		      if (page != null) {
		         currentPage = Integer.parseInt(page);
		      }

		      // 조회수 1 증가 처리
		      tipService.updateBoardReadcount(tip_no);

		      // 해당 게시글 조회
		      ArrayList<Tip> list = tipService.selectRepleList(tip_no);
		      Tip tip = tipService.selectBoard(tip_no);
		      Tip tip2 = new Tip();
		      tip2.setUser_id(user_id);
		      tip2.setTip_no(tip_no);
		      
		      LikeTip likeTip =   tipService.selectLikeTip(tip2);
		      
		      if (list != null) {
		         mv.addObject("list", list);
		      }
		      
		      if(likeTip != null) {
		         mv.addObject("likeTip", likeTip);
		      }

		      if (tip != null) {
		         if(tip.getOriginfile_tip() != null) {
		            String[] ofiles = tip.getOriginfile_tip().split(" ");
		            String[] rfiles = tip.getRenamefile_tip().split(" ");
		            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
		            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
		            mv.addObject("ofile", ofile);
		            mv.addObject("rfile", rfile);
		         }
		         mv.addObject("tip", tip);
		         mv.addObject("currentPage", currentPage);

		         mv.setViewName("admin/tipDetailView");
		      } else {
		         mv.addObject("message", tip_no + "번 게시글 조회 실패!");
		         mv.setViewName("common/error");
		      }

		      return mv;
		   }

		// 첨부파일 다운로드 요청 처리용
		@RequestMapping(value = "adTipdown.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView tipFileDownMethod(ModelAndView mv, HttpServletRequest request,
				@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
			// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
			String savePath = request.getSession().getServletContext().getRealPath("resources/tip_upfiles");

			// 저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
			File renameFile = new File(savePath + "\\" + renameFileName);
			// 파일 다운시 내보낼 원래 이름의 파일 객체 생성함
			File originFile = new File(originalFileName);

			// 파일 다운로드 뷰로 전달할 정보 저장
			mv.setViewName("filedown"); // 등록된 파일다운로드 뷰의 id명
			mv.addObject("renameFile", renameFile);
			mv.addObject("originFile", originFile);

			return mv;
		}
	   
//[tip]----------------------------------------------------	
		   	   
		// 리스트
		@RequestMapping(value = "adEyelist.do", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public ModelAndView eyebodyListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = eyebodyService.selectListCount();
			Paging paging = new Paging(listCount, currentPage, limit);

			ArrayList<Eyebody> list = eyebodyService.selectList(paging);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("paging", paging);

				mv.setViewName("admin/adminEye");
			} else {
				mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
				mv.setViewName("common/error");
			}
			return mv;
		}

		// 검색
		@RequestMapping(value = "adEyebodysearch.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView eyebodySearchMethod(
				@RequestParam(name = "page", required = false, defaultValue = "1") String page, HttpServletRequest request,
				ModelAndView mv) {
			String searchtype = request.getParameter("searchtype");
			String keyword = request.getParameter("keyword");

			CountSearch countSearch = new CountSearch(searchtype, keyword);

			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = eyebodyService.selectSearchListCount(countSearch);
			Searchs searchs = new Searchs(listCount, currentPage, limit);

			searchs.setSearchtype(searchtype);
			searchs.setKeyword(keyword);

			ArrayList<Eyebody> list;
			if (searchtype.equals("ebname")) {
				list = eyebodyService.selectSearchTitle(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminEye2");
				}
			} else if (searchtype.equals("ebvalue")) {
				list = eyebodyService.selectSearchValue(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminEye2");
				}
			} else if (searchtype.equals("ebid")) {
				list = eyebodyService.selectSearchWriter(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminEye2");
				}
			}
			if(mv.isEmpty()) {
				mv.addObject("searchs", searchs);
				mv.setViewName("admin/adminEye2");
				return mv;
			}else {
				return mv;
			}
		}  
	   
	   
		// 댓글,대댓글 삭제 처리용
		@RequestMapping(value = "adEyebodyrepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String eyebodyRepDeleteMethod(@RequestParam("eyebodyno") int eyebodyno, Eyebody eyebody, Model model) {
			if (eyebodyService.deleteReple(eyebody) > 0) {
				return "redirect:adEyebodydetail.do?eyebody_no=" + eyebodyno;
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}
	   
		// 원글 삭제 처리용
		@RequestMapping(value = "adEyebodydelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String eyebodydeleteMethod(@RequestParam("eyebody_no") int eyebody_no, Model model) {
			if (eyebodyService.deleteEyebodyBoard(eyebody_no) > 0) {
				return "redirect:adEyelist.do";
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}

		// 게시글 상세보기 처리용
		   @RequestMapping(value = "adEyebodydetail.do", method = { RequestMethod.GET, RequestMethod.POST })
		   public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("eyebody_no") int eyebody_no,
		         @RequestParam(name = "user_id", required = false) String user_id,
		         @RequestParam(name = "page", required = false) String page) {
		      int currentPage = 1;
		      if (page != null) {
		         currentPage = Integer.parseInt(page);
		      }

		      // 조회수 1 증가 처리
		      eyebodyService.updateBoardReadcount(eyebody_no);

		      // 해당 게시글 조회
		      ArrayList<Eyebody> list = eyebodyService.selectRepleList(eyebody_no);
		      Eyebody eyebody = eyebodyService.selectBoard(eyebody_no);
		      Eyebody eyebody2 = new Eyebody();
		      eyebody2.setUser_id(user_id);
		      eyebody2.setEyebody_no(eyebody_no);
		      
		      LikeEyebody likeEyebody =   eyebodyService.selectLikeEyebody(eyebody2);
		      
		      if (list != null) {
		         mv.addObject("list", list);
		      }
		      
		      if(likeEyebody != null) {
		         mv.addObject("likeEyebody", likeEyebody);
		      }

		      if (eyebody != null) {
		         if(eyebody.getOriginfile_eyebody() != null) {
		            String[] ofiles = eyebody.getOriginfile_eyebody().split(" ");
		            String[] rfiles = eyebody.getRenamefile_eyebody().split(" ");
		            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
		            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
		            mv.addObject("ofile", ofile);
		            mv.addObject("rfile", rfile);
		         }
		         mv.addObject("eyebody", eyebody);
		         mv.addObject("currentPage", currentPage);

		         mv.setViewName("admin/eyebodyDetailView");
		      } else {
		         mv.addObject("message", eyebody_no + "번 게시글 조회 실패!");
		         mv.setViewName("common/error");
		      }

		      return mv;
		   }

		// 첨부파일 다운로드 요청 처리용
		@RequestMapping(value = "adEyebodydown.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adEyefileDownMethod(ModelAndView mv, HttpServletRequest request,
				@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
			// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
			String savePath = request.getSession().getServletContext().getRealPath("resources/eyebody_upfiles");

			// 저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
			File renameFile = new File(savePath + "\\" + renameFileName);
			// 파일 다운시 내보낼 원래 이름의 파일 객체 생성함
			File originFile = new File(originalFileName);

			// 파일 다운로드 뷰로 전달할 정보 저장
			mv.setViewName("filedown"); // 등록된 파일다운로드 뷰의 id명
			mv.addObject("renameFile", renameFile);
			mv.addObject("originFile", originFile);

			return mv;
		}
	   
	   
//[bfaf]-----------------------------------------------------------	   
		// 리스트
		@RequestMapping(value = "adBFlist.do", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public ModelAndView bfafListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = bfafService.selectListCount();
			Paging paging = new Paging(listCount, currentPage, limit);

			ArrayList<Bfaf> list = bfafService.selectList(paging);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("paging", paging);

				mv.setViewName("admin/adminBF");
			} else {
				mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
				mv.setViewName("common/error");
			}
			return mv;
		}

		// 검색
		@RequestMapping(value = "adBfafsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView bfafSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
				HttpServletRequest request, ModelAndView mv) {
			String searchtype = request.getParameter("searchtype");
			String keyword = request.getParameter("keyword");

			CountSearch countSearch = new CountSearch(searchtype, keyword);

			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			int limit = 10;
			int listCount = bfafService.selectSearchListCount(countSearch);
			Searchs searchs = new Searchs(listCount, currentPage, limit);

			searchs.setSearchtype(searchtype);
			searchs.setKeyword(keyword);

			ArrayList<Bfaf> list;
			if (searchtype.equals("baname")) {
				list = bfafService.selectSearchTitle(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminBF2");
				}
			} else if (searchtype.equals("bavalue")) {
				list = bfafService.selectSearchValue(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminBF2");
				}
			} else if (searchtype.equals("baid")) {
				list = bfafService.selectSearchWriter(searchs);
				if (list != null && list.size() > 0) {
					mv.addObject("list", list);
					mv.addObject("searchs", searchs);

					mv.setViewName("admin/adminBF2");
				}
			} 
			
			if(mv.isEmpty()) {
				mv.addObject("searchs", searchs);
				mv.setViewName("admin/adminBF2");
				return mv;
			}else {
				return mv;
			}
		}   
	   
	   
		// 댓글,대댓글 삭제 처리용
		@RequestMapping(value = "adBfafrepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String bfafRepDeleteMethod(@RequestParam("bfafno") int bfafno, Bfaf bfaf, Model model) {
			if (bfafService.deleteReple(bfaf) > 0) {
				return "redirect:adBFlist.do?bfaf_no=" + bfafno;
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}
	   
		// 원글 삭제 처리용
		@RequestMapping(value = "abBfafdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String bfafdeleteMethod(@RequestParam("bfaf_no") int bfaf_no, Model model) {
			if (bfafService.deleteBfafBoard(bfaf_no) > 0) {
				return "redirect:adBFlist.do";
			} else {
				model.addAttribute("message", "게시글 삭제 실패!");
				return "common/error";
			}
		}
	   
	   
	   
	   
		// 게시글 상세보기 처리용
		   @RequestMapping(value = "adBfafdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
		   public ModelAndView adBFDetailMethod(ModelAndView mv, @RequestParam("bfaf_no") int bfaf_no,
		         @RequestParam(name = "user_id", required = false) String user_id,
		         @RequestParam(name = "page", required = false) String page) {
		      int currentPage = 1;
		      if (page != null) {
		         currentPage = Integer.parseInt(page);
		      }

		      // 조회수 1 증가 처리
		      bfafService.updateBoardReadcount(bfaf_no);

		      // 해당 게시글 조회
		      ArrayList<Bfaf> list = bfafService.selectRepleList(bfaf_no);
		      Bfaf bfaf = bfafService.selectBoard(bfaf_no);
		      Bfaf bfaf2 = new Bfaf();
		      bfaf2.setUser_id(user_id);
		      bfaf2.setBfaf_no(bfaf_no);
		      
		      LikeBfaf likeBfaf =   bfafService.selectLikeBfaf(bfaf2);
		      
		      if (list != null) {
		         mv.addObject("list", list);
		      }
		      
		      if(likeBfaf != null) {
		         mv.addObject("likeBfaf", likeBfaf);
		      }

		      if (bfaf != null) {
		         if(bfaf.getOriginfile_bfaf() != null) {
		            String[] ofiles = bfaf.getOriginfile_bfaf().split(" ");
		            String[] rfiles = bfaf.getRenamefile_bfaf().split(" ");
		            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
		            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
		            mv.addObject("ofile", ofile);
		            mv.addObject("rfile", rfile);
		         }
		         mv.addObject("bfaf", bfaf);
		         mv.addObject("currentPage", currentPage);

		         mv.setViewName("admin/bfafDetailView");
		      } else {
		         mv.addObject("message", bfaf_no + "번 게시글 조회 실패!");
		         mv.setViewName("common/error");
		      }

		      return mv;
		   }

		// 첨부파일 다운로드 요청 처리용
		@RequestMapping(value = "adBfafdown.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
				@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
			// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
			String savePath = request.getSession().getServletContext().getRealPath("resources/bfaf_upfiles");

			// 저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
			File renameFile = new File(savePath + "\\" + renameFileName);
			// 파일 다운시 내보낼 원래 이름의 파일 객체 생성함
			File originFile = new File(originalFileName);

			// 파일 다운로드 뷰로 전달할 정보 저장
			mv.setViewName("filedown"); // 등록된 파일다운로드 뷰의 id명
			mv.addObject("renameFile", renameFile);
			mv.addObject("originFile", originFile);

			return mv;
		}
	   
	
	
	

}