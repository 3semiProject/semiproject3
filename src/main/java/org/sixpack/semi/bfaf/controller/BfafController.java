package org.sixpack.semi.bfaf.controller;

import java.util.ArrayList;

import org.sixpack.semi.bfaf.model.service.BfafService;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.common.Paging;
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
public class BfafController {
	private static final Logger logger = LoggerFactory.getLogger(BfafController.class);
	@Autowired
	private BfafService bfafService;
	
	@RequestMapping("bfaflist.do")
	public ModelAndView bfafListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = bfafService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<Bfaf> list = bfafService.selectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("bfaf/bfafListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	@RequestMapping(value="bfafsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String bfafSearchMethod(@RequestParam("searchtype") String searchtype, 
			@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<Bfaf> list;
		if(searchtype.equals("baname")) {
			list = bfafService.selectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "bfaf/bfafListView";
		}else if(searchtype.equals("bavalue")) {
			list = bfafService.selectSearchValue(keyword);
			model.addAttribute("list", list);
			return "bfaf/bfafListView";
		}else if(searchtype.equals("baid")) {
			list = bfafService.selectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "bfaf/bfafListView";
		}else {
			model.addAttribute("message", "검색 결과가 없습니다.");
			return "common/error";
		}
	}
}
