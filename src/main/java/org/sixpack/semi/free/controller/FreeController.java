package org.sixpack.semi.free.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.free.model.vo.Free;
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
public class FreeController {
	private static final Logger logger = LoggerFactory.getLogger(FreeController.class);

	@Autowired
	private FreeService freeService;

	@RequestMapping(value = "commuwrite.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveWriteMethod() {
		return "common/cwriteForm";
	}
	
	//원글 삭제 처리용
	@RequestMapping(value = "freedelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String freedeleteMethod(@RequestParam("free_no") int free_no, Model model) {
		if(freeService.deleteBoard(free_no) > 0) {
			return "redirect:commu.do";
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 게시글 상세보기 처리용
	@RequestMapping(value = "freedetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("free_no") int free_no,
			@RequestParam(name = "page", required = false) String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 조회수 1 증가 처리
		freeService.updateBoardReadcount(free_no);

		// 해당 게시글 조회
		Free free = freeService.selectBoard(free_no);
		ArrayList<Free> list = freeService.selectRepleList(free_no);
		
		if(list != null) {
			mv.addObject("list", list);
		}
		
		if (free != null) {
			mv.addObject("free", free);
			mv.addObject("currentPage", currentPage);
			
			mv.setViewName("free/freeDetailView");
		} else {
			mv.addObject("message", free_no + "번 게시글 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}

	// 첨부파일 다운로드 요청 처리용
	@RequestMapping("freedown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
		// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/free_upfiles");

		// 저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
		File renameFile = new File(savePath + "\\" + renameFileName);
		// 파일 다운시 내보낼 원래 이름의 파일 객체 생성함
		File originFile = new File(originalFileName);

		// 파일 다운로드 뷰로 전달할 정보 저장
		mv.setViewName("filedown"); // 등록된 파일다운로드 뷰의 id명
		mv.addObject("renameFile", renameFile);
		mv.addObject("originFile", originFile);

		return mv;
	}

	// 등록 요청 처리용 (파일 업로드 기능 사용)
	@RequestMapping(value = "commuinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String freeInsertMethod(Free free, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {

		// 공지사항 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/free_upfiles");

		// 첨부파일이 있을때
		if (!mfile.isEmpty()) {

			// 전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();

			// 다른 공지글의 첨부파일과 파일명이 중복되어서
			// 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
			// 폴더에 저장하는 방식을 사용할 수 있음
			// 변경 파일명 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {
				// 바꿀 파일명에 대한 문자열 만들기
				String renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");

				logger.info("첨부 파일명 확인 : " + fileName + ", " + renameFileName);

				// 폴더에 저장 처리
				try {
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 저장 실패!");
					return "common/error";
				}

				// 객체에 첨부파일 정보 기록 저장
				free.setOriginfile_free(fileName);
				free.setRenamefile_free(renameFileName);
			} // 이름바꾸기
		} // 새로운 첨부파일이 있을 때

		if (freeService.insertBoard(free) > 0) {
			// 공지글 수정 성공시 목록 보기 페이지로 이동
			return "redirect:commu.do";
		} else {
			model.addAttribute("message", "새 공지 등록 실패!");
			return "common/error";
		}
	}
	//top5
	@RequestMapping(value = "ftop5.do", method = RequestMethod.POST)
	@ResponseBody
	public String freeNewTop5Method() throws UnsupportedEncodingException {
		ArrayList<Free> list = freeService.selectTop5();
		logger.info("ftop5.do : " + list.size());

		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();

		for (Free free : list) {
			JSONObject job = new JSONObject();

			job.put("free_name", URLEncoder.encode(free.getFree_name(), "utf-8"));
			job.put("write_free_date", free.getWrite_free_date().toString());
			job.put("user_id", free.getUser_id());
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	//리스트
	@RequestMapping(value = "commu.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView freeListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = freeService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);

		ArrayList<Free> list = freeService.selectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("free/freeListView");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	@RequestMapping(value = "freesearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView freeSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = freeService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<Free> list;
		if (searchtype.equals("fname")) {
			list = freeService.selectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("free/freeListView2");
			}
		} else if (searchtype.equals("fvalue")) {
			list = freeService.selectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("free/freeListView2");
			}
		} else if (searchtype.equals("fid")) {
			list = freeService.selectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("free/freeListView2");
			}
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
}
