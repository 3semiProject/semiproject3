package org.sixpack.semi.free.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.free.model.vo.Free;
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
public class FreeController {
	private static final Logger logger = LoggerFactory.getLogger(FreeController.class);
	
	@Autowired
	private FreeService freeService;
	
	@RequestMapping(value="ftop5.do", method=RequestMethod.POST)
	@ResponseBody
	public String freeNewTop5Method() throws UnsupportedEncodingException {
		ArrayList<Free> list = freeService.selectTop5();
		logger.info("ftop5.do : " + list.size());
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(Free free : list) {
			JSONObject job = new JSONObject();
			
			job.put("free_name", URLEncoder.encode(free.getFree_name(), "utf-8"));
			job.put("write_free_date", free.getWrite_free_date().toString());
			job.put("user_id", free.getUser_id());
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	@RequestMapping("commu.do")
	public ModelAndView freeListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = freeService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<Free> list = freeService.selectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("free/freeListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	@RequestMapping(value="fsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String freeSearchMethod(@RequestParam("searchtype") String searchtype, 
			@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<Free> list;
		if(searchtype.equals("fname")) {
			list = freeService.selectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "free/freeListView";
		}else if(searchtype.equals("fvalue")) {
			list = freeService.selectSearchValue(keyword);
			model.addAttribute("list", list);
			return "free/freeListView";
		}else if(searchtype.equals("fid")) {
			list = freeService.selectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "free/freeListView";
		}else {
			model.addAttribute("message", "검색 결과가 없습니다.");
			return "common/error";
		}
	}
}
