package org.sixpack.semi.hotnew.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.hotnew.model.service.HotNewService;
import org.sixpack.semi.hotnew.model.vo.HotNew;
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
public class HotNewController {
private static final Logger logger = LoggerFactory.getLogger(HotNewController.class);
	
	@Autowired
	private HotNewService hotNewService;
	//hotnewdetail.do
	@RequestMapping(value="hotnewdetail.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String selectDetailMethod(@RequestParam("hotnew_no") int hotnew_no, Model model,
			HttpSession session, @RequestParam(name= "user_id", required=false) String user_id,
			@RequestParam("hotnew_name") String hotnew_name) {
		HotNew hotnew = new HotNew();
		
		hotnew.setHotnew_no(hotnew_no);
		hotnew.setHotnew_name(hotnew_name);
		hotnew.setUser_id(user_id);
		System.out.println(hotnew);
		if(hotNewService.selectFree(hotnew) != null) {
			if((Member)session.getAttribute("loginMember") != null) {
				return "redirect:freedetail.do?free_no=" + hotnew.getHotnew_no() 
						+ "&user_id=" + ((Member)session.getAttribute("loginMember")).getUser_id();
			}else {
				return "redirect:freedetail.do?free_no=" + hotnew.getHotnew_no();
			}
		}
		else if(hotNewService.selectTip(hotnew) != null) {
			if((Member)session.getAttribute("loginMember") != null) {
				return "redirect:tipdetail.do?tip_no=" + hotnew.getHotnew_no() 
						+ "&user_id=" + ((Member)session.getAttribute("loginMember")).getUser_id();
			}else {
				return "redirect:tipdetail.do?tip_no=" + hotnew.getHotnew_no();
			}
		}
		else if(hotNewService.selectEyebody(hotnew) != null) {
			if((Member)session.getAttribute("loginMember") != null) {
				return "redirect:eyebodydetail.do?eyebody_no=" + hotnew.getHotnew_no() 
						+ "&user_id=" + ((Member)session.getAttribute("loginMember")).getUser_id();
			}else {
				return "redirect:eyebodydetail.do?eyebody_no=" + hotnew.getHotnew_no();
			}
		}
		else if(hotNewService.selectBfaf(hotnew) != null) {
			if((Member)session.getAttribute("loginMember") != null) {
				return "redirect:bfafdetail.do?bfaf_no=" + hotnew.getHotnew_no() 
						+ "&user_id=" + ((Member)session.getAttribute("loginMember")).getUser_id();
			}else {
				return "redirect:bfafdetail.do?bfaf_no=" + hotnew.getHotnew_no();
			}
		}else {
			model.addAttribute("message", hotnew.getHotnew_no() + "번 게시물 조회 실패");
			return "common/error";
		}
		
	}
	
	@RequestMapping(value="hntop5.do", method=RequestMethod.POST)
	@ResponseBody
	public String hotnewNewTop5Method() throws UnsupportedEncodingException {
		ArrayList<HotNew> list = hotNewService.hotnewSelectTop5();
		logger.info("hntop5.do : " + list.size());
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(HotNew hotNew : list) {
			JSONObject job = new JSONObject();
			job.put("hotnew_no", hotNew.getHotnew_no());
			job.put("hotnew_name", URLEncoder.encode(hotNew.getHotnew_name(), "utf-8"));
			job.put("write_hotnew_date", hotNew.getWrite_hotnew_date().toString());
			job.put("user_id", hotNew.getUser_id());
			job.put("click_hotnew_no", hotNew.getClick_hotnew_no());
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	@RequestMapping("newlist.do")
	public ModelAndView newListMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = hotNewService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<HotNew> list = hotNewService.newSelectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("new/newListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	@RequestMapping("hotlist.do")
	public ModelAndView hotListMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = hotNewService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<HotNew> list = hotNewService.hotSelectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("hot/hotListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	@RequestMapping(value="hotsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView hotSearchMethod(
			@RequestParam(name = "page", required = false, defaultValue = "1") String page, 
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");
		
		CountSearch countSearch = new CountSearch(searchtype, keyword);
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = hotNewService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);
		
		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);
		
		ArrayList<HotNew> list;
		if(searchtype.equals("hotname")) {
			list = hotNewService.hotSelectSearchTitle(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("hot/hotListView2");
			}
		}else if(searchtype.equals("hotvalue")) {
			list = hotNewService.hotSelectSearchValue(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("hot/hotListView2");
			}
		}else if(searchtype.equals("hotid")) {
			list = hotNewService.hotSelectSearchWriter(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("hot/hotListView2");
			}
		}
		if(mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("hot/hotListView2");
			return mv;
		}else {
			return mv;
		}
	}
	
	@RequestMapping(value="newsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView newSearchMethod(
			@RequestParam(name = "page", required = false, defaultValue = "1") String page, 
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");
		
		CountSearch countSearch = new CountSearch(searchtype, keyword);
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = hotNewService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);
		
		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);
		
		ArrayList<HotNew> list;
		if(searchtype.equals("newname")) {
			list = hotNewService.hotSelectSearchTitle(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("new/newListView2");
			}
		}else if(searchtype.equals("newvalue")) {
			list = hotNewService.hotSelectSearchValue(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("new/newListView2");
			}
		}else if(searchtype.equals("newid")) {
			list = hotNewService.hotSelectSearchWriter(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("new/newListView2");
			}
		}
		if(mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("new/newListView2");
			return mv;
		}else {
			return mv;
		}
	}
}
