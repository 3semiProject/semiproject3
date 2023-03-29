package org.sixpack.semi.qna.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.qna.model.service.QnaService;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("customer.do")
	public String forwardMainView() {
		return "common/customer";
	}
	
	@RequestMapping("qnalist.do")
	@ResponseBody
	public String showQnaListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) throws UnsupportedEncodingException {
//		
//		int currentPage = 1;
//		if(page != null) {
//			currentPage = Integer.parseInt(page);
//		}
//		
		int limit = 10;  //한 페이지에 출력할 목록 갯수
		System.out.println("page : " + page);
		int listCount = qnaService.selectListCount();
		Paging paging = new Paging(listCount, Integer.parseInt(page), limit);
		paging.calculator();
		
		JSONObject sendJson = new JSONObject();
		//리스트 저장할 json 배열 객체 준비
		JSONArray jarr = new JSONArray();
		
		ArrayList<Qna> list = qnaService.selectQnaList(paging);
		
		//list 를 jarr 에 옮기기 (복사)
		for(Qna qna : list) {
			//notice 의 각 필드값 저장할 json 객체 생성함
			JSONObject job = new JSONObject();
			
			job.put("qna_no", qna.getQna_no());
			//한글에 대해서는 인코딩해서 json에 담도록 함
			//한글깨짐 방지
			job.put("qna_title", URLEncoder.encode(
					qna.getQna_title(), "utf-8"));
			//날짜는 반드시 toString() 으로 문자열로 바꿔서
			//json 에 담아야 함
			job.put("user_id", qna.getUser_id());
			job.put("qna_views", qna.getQna_views());
			job.put("qna_post_date", qna.getQna_post_date().toString());
			
			jarr.add(job);  //job 를 jarr 에 추가함
		}
		sendJson.put("list", jarr);
		
		
		return sendJson.toJSONString();
		
		
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
