package org.sixpack.semi.banner.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.banner.model.service.BannerService;
import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BannerController {
	
	@Autowired
	private BannerService bannerService;
	
	@RequestMapping("showBanner.do")
	public String showBannerMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("bannerlist.do")
	@ResponseBody
	public ModelAndView showBannerListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		
		int listCount = bannerService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();
		
		ArrayList<Banner> list = bannerService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			
			mv.setViewName("banner/bannerListView");
		}else {
			mv.addObject("message", "등록된 배너가 없습니다.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	@RequestMapping(value = "yooinsert.do", method ={ RequestMethod.GET, RequestMethod.POST })
	public String yootubeInsertMethod(Banner banner, Model model, HttpServletRequest request) {

		if (bannerService.insertBanner(banner) > 0) {
			return "redirect:bannerlist.do";
		} else {
			model.addAttribute("message", banner.getBanner_no() 
					+ "번 게시글 수정 실패!");
			return "common/error";
		}
	}
	
	// 게시 원글 쓰기 페이지로 이동 처리용
	@RequestMapping("bawform.do")
	public String moveqnaWriteForm() {
		return "banner/yootubeWriteForm";
	}
	
	//수정페이지로 이동 처리용
	@RequestMapping("baupview.do")
	public String moveqnaUpdateView(@RequestParam("banner_no") int banner_no, Model model) {
		

		//수정페이지로 보낼 qna 객체 정보 조회함
		Banner banner = bannerService.selectBanner(banner_no);
		
		if(banner != null) {
			model.addAttribute("banner", banner);
			
			return "banner/bannerUpdate";
		}else {
			model.addAttribute("message", banner_no + "번 글 수정페이지로 이동 실패!");
			
			return "common/error";
		}
	}
	
	
	//상세보기
	@RequestMapping("badetail.do")
	public ModelAndView showBannerDetailMethod(@RequestParam("banner_no") int banner_no, ModelAndView mv, 
			@RequestParam(name = "page", required = false) String page) {
		
		int currentPage = 1;
		
		
		//게시글 조회
		Banner banner = bannerService.selectBanner(banner_no);
		
		
		if(banner != null) {
			mv.addObject("banner", banner);
			mv.addObject("currentPage", currentPage);
			
			mv.setViewName("banner/bannerDetailView");
		}else {
			mv.addObject("message", banner_no + "번 배너글 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	@RequestMapping("bannerInsert.do")
	public String BannerInsertMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("bannerUpdate.do")
	public String BannerUpdateMethod(Banner banner, Model model, HttpServletRequest request) {
				if (bannerService.updateBanner(banner) > 0) {

					
					return "redirect:bannerlist.do";
				} else {
					model.addAttribute("message", banner.getBanner_no() 
							+ "번 게시글 수정 실패!");
					return "common/error";
				}
	}
	@RequestMapping("bannerDelete.do")
	public String BannerDeleteMethod(int banner_no, Model model) {
		return null;
	}

}
