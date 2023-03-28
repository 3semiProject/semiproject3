package org.sixpack.semi.tip.controller;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.tip.model.service.TipService;
import org.sixpack.semi.tip.model.vo.Tip;
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
public class TipController {
private static final Logger logger = LoggerFactory.getLogger(TipController.class);
	
	@Autowired
	private TipService tipService;
	
	@RequestMapping("tiplist.do")
	public ModelAndView bfafListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = tipService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		paging.calculator();
		
		ArrayList<Tip> list = tipService.selectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("tip/tipListView");
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	@RequestMapping(value="tipsearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String bfafSearchMethod(@RequestParam("searchtype") String searchtype, 
			@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<Tip> list;
		if(searchtype.equals("tname")) {
			list = tipService.selectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "tip/tipListView";
		}else if(searchtype.equals("tvalue")) {
			list = tipService.selectSearchValue(keyword);
			model.addAttribute("list", list);
			return "tip/tipListView";
		}else if(searchtype.equals("tid")) {
			list = tipService.selectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "tip/tipListView";
		}else {
			model.addAttribute("message", "검색 결과가 없습니다.");
			return "common/error";
		}
	}
}
