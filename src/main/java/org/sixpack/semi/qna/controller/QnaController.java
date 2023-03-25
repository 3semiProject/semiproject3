package org.sixpack.semi.qna.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.qna.model.service.QnaService;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	public String showQnaListMethod(ModelAndView mv) {
		return null;
	}
	public String showQnaDetailMethod(HttpSession session,Qna qna,ModelAndView mv) {
		return null;
	}
	public String writeQnaMethod(Qna qna, HttpServletRequest request,
						@RequestParam(name = "hide", required = false) String hideCheck,
			            @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	public String updateQnaListMethod(Qna qna, HttpServletRequest request,
						@RequestParam(name = "hide", required = false) String hideCheck,
			            @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	public String deleteQnaListMethod(HttpServletRequest request, @RequestParam("qna_no") int qna_no,
			             @RequestParam(name = "upfile", required = false) MultipartFile mfile, ModelAndView mv) {
		return null;
	}
	public String showNoAnswerListMethod(ModelAndView mv) {
		return null;
	}
}
