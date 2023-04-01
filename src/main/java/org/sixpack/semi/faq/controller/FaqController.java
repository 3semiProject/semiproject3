package org.sixpack.semi.faq.controller;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.faq.model.service.FaqService;
import org.sixpack.semi.faq.model.vo.Faq;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FaqController {
	@Autowired
	private FaqService faqService;
	
	@RequestMapping("flistView.do")
	public String showFaqListMethod(ModelAndView mv) {
		return "faq/faqListView";
	}
	
	@RequestMapping("faqlist.do")
	@ResponseBody
	public ModelAndView showFaqListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		
		int listCount = faqService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();
		
		ArrayList<Faq> list = faqService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			
			mv.setViewName("faq/faqListView");
		}else {
			mv.addObject("message", "등록된 FAQ가 없습니다.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	public String writeFaqMethod(Faq faq, ModelAndView mv) {
		return null;
	}
	public String updateFaqMethod(Faq faq, ModelAndView mv) {
		return null;
	}
	public String deleteFaqMethod(@RequestParam("faq_no") int faq_no, ModelAndView mv) {
		return null;
	}
	
	
}
