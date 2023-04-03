package org.sixpack.semi.faq.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.faq.model.service.FaqService;
import org.sixpack.semi.faq.model.vo.Faq;
import org.sixpack.semi.qna.model.vo.Qna;
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

@Controller
public class FaqController {
	@Autowired
	private FaqService faqService;
	
	private static final Logger logger = LoggerFactory.getLogger(FaqController.class);
	
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
	
	//쓰기 페이지 이동
	@RequestMapping("fwform.do")
	public String movefaqWriteForm() {
		return "faq/faqWriteForm";
	}
	
	//쓰기
	@RequestMapping(value = "faqinsert.do", method ={ RequestMethod.GET, RequestMethod.POST })
	public String writeFaqMethod(Faq faq, Model model, HttpServletRequest request) {
		
		logger.info("faq_title : " + faq.getFaq_title());
		
		if (faqService.insertFaq(faq) > 0) {
			// 게시원글 수정 성공시 상세보기 페이지로 이동
			return "redirect:faqlist.do";
		} else {
			model.addAttribute("message", faq.getFaq_no() 
					+ "번 게시글 수정 실패!");
			return "common/error";
		}
	}
	
	@RequestMapping(value = "faqup.do", method = RequestMethod.POST)
	public String updateFaqMethod(Faq faq, Model model, HttpServletRequest request) {

		if (faqService.updateFaq(faq) > 0) {
			
			return "redirect:faqlist.do";
		} else {
			model.addAttribute("message", faq.getFaq_no() 
					+ "번 FAQ 수정 실패!");
			return "common/error";
		}
	}
	
	//수정페이지로 이동 처리용
	@RequestMapping("faqupview.do")
	public String moveUpdateView(@RequestParam("faq_no") int faq_no,
									  Model model) {
		

		//수정페이지로 보낼 qna 객체 정보 조회함
		Faq faq = faqService.selectFaq(faq_no);
		
		if(faq != null) {
			model.addAttribute("faq", faq);
			
			return "faq/faqUpdate";
		}else {
			model.addAttribute("message", faq_no + "번 FAQ 수정페이지로 이동 실패!");
			
			return "common/error";
		}
	}
	
	@RequestMapping(value = "faqdel.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteFaqMethod(@RequestParam("faq_no") int faq_no,
			Model model, HttpServletRequest request) {
		
		if(faqService.deleteFaq(faq_no) > 0) {

			return "redirect:faqlist.do";
		}else {
			model.addAttribute("message", 
					faq_no + "번 FAQ 삭제 실패!");
			return "common/error";
		}
	}
	
	
}
