package org.sixpack.semi.faq.controller;

import org.sixpack.semi.faq.model.service.FaqService;
import org.sixpack.semi.faq.model.vo.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FaqController {
	@Autowired
	private FaqService FaqService;
	
	public String showFaqListMethod(ModelAndView mv) {
		return null;
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
