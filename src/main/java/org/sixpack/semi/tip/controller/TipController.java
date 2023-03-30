package org.sixpack.semi.tip.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TipController {
private static final Logger logger = LoggerFactory.getLogger(TipController.class);
	
	@Autowired
	private TipService tipService;
	
	//등록 요청 처리용 (파일 업로드 기능 사용)
		@RequestMapping(value="tipinsert.do", method={ RequestMethod.GET, RequestMethod.POST })
		public String freeInsertMethod(Tip tip, Model model, HttpServletRequest request,			
				@RequestParam(name="upfile", required=false) MultipartFile mfile) {

			//공지사항 첨부파일 저장 폴더 경로 지정
					String savePath = request.getSession()
							.getServletContext().getRealPath(
								"resources/tip_upfiles");
							
					//첨부파일이 있을때
					if(!mfile.isEmpty()) {
						
						//전송온 파일이름 추출함
						String fileName = mfile.getOriginalFilename();
						
						//다른 공지글의 첨부파일과 파일명이 중복되어서
						//덮어쓰기 되는것을 막기 위해, 파일명을 변경해서 
						//폴더에 저장하는 방식을 사용할 수 있음
						//변경 파일명 : 년월일시분초.확장자
						if(fileName != null && fileName.length() > 0) {
							//바꿀 파일명에 대한 문자열 만들기				
							String renameFileName = FileNameChange.change(
									fileName, "yyyyMMddHHmmss");
							
							logger.info("첨부 파일명 확인 : " + fileName 
											+ ", " + renameFileName);			
								
							//폴더에 저장 처리
							try {
								mfile.transferTo(new File(
										savePath + "\\" + renameFileName));
							} catch (Exception e) {					
								e.printStackTrace();
								model.addAttribute("message", 
										"첨부파일 저장 실패!");
								return "common/error";
							} 
							
							//객체에 첨부파일 정보 기록 저장
							tip.setOriginfile_tip(fileName);
							tip.setRenamefile_tip(renameFileName);
						} //이름바꾸기
					}  //새로운 첨부파일이 있을 때		
					
					if(tipService.insertBoard(tip) > 0) {
						//공지글 수정 성공시 목록 보기 페이지로 이동
						return "redirect:tiplist.do";
					}else {
						model.addAttribute("message", "새 공지 등록 실패!");
						return "common/error";
					}
				}
	
	@RequestMapping("tiplist.do")
	public ModelAndView tipListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = tipService.selectListCount();
		Paging paging = new Paging(listCount, currentPage,limit);
		
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
	public ModelAndView tipSearchMethod(
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
		int listCount = tipService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);
		
		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);
		
		ArrayList<Tip> list;
		if(searchtype.equals("tname")) {
			list = tipService.selectSearchTitle(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("tip/tipListView2");
			}
		}else if(searchtype.equals("tvalue")) {
			list = tipService.selectSearchValue(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("tip/tipListView2");
			}
		}else if(searchtype.equals("tid")) {
			list = tipService.selectSearchWriter(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("tip/tipListView2");
			}
		}else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
}
