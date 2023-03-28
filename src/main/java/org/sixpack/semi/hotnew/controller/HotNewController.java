package org.sixpack.semi.hotnew.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.hotnew.model.service.HotNewService;
import org.sixpack.semi.hotnew.model.vo.HotNew;
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
	
	@RequestMapping(value="hntop5.do", method=RequestMethod.POST)
	@ResponseBody
	public String freeNewTop5Method() throws UnsupportedEncodingException {
		ArrayList<HotNew> list = hotNewService.hotnewSelectTop5();
		logger.info("hntop5.do : " + list.size());
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(HotNew hotNew : list) {
			JSONObject job = new JSONObject();
			
			job.put("hotnew_name", URLEncoder.encode(hotNew.getHotnew_name(), "utf-8"));
			job.put("write_hotnew_date", hotNew.getWrite_hotnew_date().toString());
			job.put("user_id", hotNew.getUser_id());
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	@RequestMapping("newlist.do")
	public ModelAndView newListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
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
	@RequestMapping(value="newsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String newSearchMethod(@RequestParam("searchtype") String searchtype, 
			@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<HotNew> list;
		if(searchtype.equals("newname")) {
			list = hotNewService.newSelectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "new/newListView";
		}else if(searchtype.equals("newvalue")) {
			list = hotNewService.newSelectSearchValue(keyword);
			model.addAttribute("list", list);
			return "new/newListView";
		}else if(searchtype.equals("newid")) {
			list = hotNewService.newSelectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "new/newListView";
		}else {
			model.addAttribute("message", "검색 결과가 없습니다.");
			return "common/error";
		}
	}
	
	@RequestMapping("hotlist.do")
	public ModelAndView hotListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
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
	public String hotSearchMethod(@RequestParam("searchtype") String searchtype, 
			@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<HotNew> list;
		if(searchtype.equals("hotname")) {
			list = hotNewService.newSelectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "hot/hotListView";
		}else if(searchtype.equals("hotvalue")) {
			list = hotNewService.newSelectSearchValue(keyword);
			model.addAttribute("list", list);
			return "hot/hotListView";
		}else if(searchtype.equals("hotid")) {
			list = hotNewService.newSelectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "hot/hotListView";
		}else {
			model.addAttribute("message", "검색 결과가 없습니다.");
			return "common/error";
		}
	}
}
