package org.sixpack.semi.eyebody.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.service.EyebodyService;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.free.model.vo.Free;
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
public class EyebodyController {
private static final Logger logger = LoggerFactory.getLogger(EyebodyController.class);
	
	@Autowired
	private EyebodyService eyebodyService;
	
	@RequestMapping("eyebodylist.do")
	public ModelAndView eyebodyListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = eyebodyService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<Eyebody> list = eyebodyService.selectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("eyebody/eyebodyListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	@RequestMapping(value="eyebodysearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView eyebodySearchMethod(
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
		int listCount = eyebodyService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);
		
		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);
		
		ArrayList<Eyebody> list;
		if(searchtype.equals("ename")) {
			list = eyebodyService.selectSearchTitle(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("eyebody/eyebodyListView2");
			}
		}else if(searchtype.equals("evalue")) {
			list = eyebodyService.selectSearchValue(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("eyebody/eyebodyListView2");
			}
		}else if(searchtype.equals("eid")) {
			list = eyebodyService.selectSearchWriter(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("eyebody/eyebodyListView2");
			}
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
}
