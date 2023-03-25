package org.sixpack.semi.qnaanswer.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.qnaanswer.model.service.QnaAnswerService;
import org.sixpack.semi.qnaanswer.model.vo.QnaAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QnaAnswerController {
	@Autowired
	private QnaAnswerService qnaAnswerService;
	
	public String showAnswerDetailMethod(HttpSession session ,ModelAndView mv) {
		return null;
	}
	public String writeAnswerMethod(QnaAnswer qnaAnswer, HttpServletRequest request,
						@RequestParam(name = "hide", required = false) String hideCheck,
			            @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	public String updateAnswerMethod(QnaAnswer qnaAnswer, HttpServletRequest request,
						@RequestParam(name = "hide", required = false) String hideCheck,
			            @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	
	public String deleteAnswerMethod(HttpServletRequest request, @RequestParam("qna_no") int qna_no,
			             @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	
}
