package org.sixpack.semi.qna.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.board.controller.BoardController;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.qna.model.service.QnaService;
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
public class QnaController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("qnaListView.do")
	public String forwardMainView() {
		return "qna/qnaListView";
	}
	
	//리스트 출력
	@RequestMapping("qnalist.do")
	@ResponseBody
	public ModelAndView showQnaListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		
		int listCount = qnaService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();
		
		ArrayList<Qna> list = qnaService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			
			mv.setViewName("qna/qnaListView");
		}else {
			mv.addObject("message", "등록된 QNA가 없습니다.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//검색용 
	@RequestMapping(value="qnasearch.do", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView noitceSearchMethod(
			@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			@RequestParam("searchtype") String searchtype,
			@RequestParam("keyword") String keyword, ModelAndView mv) {

		CountSearch countSearch = new CountSearch(searchtype, keyword);
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = qnaService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);
		searchs.calculator();
		
		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);
		
		ArrayList<Qna> list;
		
		if(searchtype.equals("qname")) {
			list = qnaService.selectSearchTitle(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("qna/qnaListView2");
			}
		}else if(searchtype.equals("qcontent")) {
			list = qnaService.selectSearchContent(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("qna/qnaListView2");
			}
		}else if(searchtype.equals("qid")) {
			list = qnaService.selectSearchWriter(searchs);
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);
				
				mv.setViewName("qna/qnaListView2");
			}
		}else {
			mv.addObject("message", currentPage + "로 검색된 공지글 정보가 없습니다.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//상세보기
	@RequestMapping("qdetail.do")
	public ModelAndView showQnaDetailMethod(@RequestParam("qna_no") int qna_no, ModelAndView mv, 
			@RequestParam(name = "page", required = false) String page) {
		
		int currentPage = 1;
		
		//조회수증가
		qnaService.updateQnaReadcount(qna_no);
		
		//게시글 조회
		Qna qna = qnaService.selectQna(qna_no);
		
		
		if(qna != null) {
			mv.addObject("qna", qna);
			mv.addObject("currentPage", currentPage);
			
			mv.setViewName("qna/qnaDetailView");
		}else {
			mv.addObject("message", qna_no + "번 QNA글 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	// 게시 원글 쓰기 페이지로 이동 처리용
	@RequestMapping("qwform.do")
	public String moveqnaWriteForm() {
		return "qna/qnaWriteForm";
	}
	
	//수정페이지로 이동 처리용
	@RequestMapping("qupview.do")
	public String moveqnaUpdateView(@RequestParam("qna_no") int qna_no,
									  @RequestParam("page") int currentPage,
									  Model model) {
		

		//수정페이지로 보낼 board 객체 정보 조회함
		Qna qna = qnaService.selectQna(qna_no);
		
		if(qna != null) {
			model.addAttribute("qna", qna);
			model.addAttribute("currentPage", currentPage);
			
			return "qna/qnaUpdate";
		}else {
			model.addAttribute("message", qna_no + "번 글 수정페이지로 이동 실패!");
			
			return "common/error";
		}
	}
	
	@RequestMapping(value = "qoriginup.do", method = RequestMethod.POST)
	public String boardUpdateMethod(Qna qna, Model model, HttpServletRequest request,
			@RequestParam("page") int page,
			@RequestParam(name = "delflag", required = false) String delFlag,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {

		// 게시원글 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession()
				.getServletContext().getRealPath(
						"resources/qna_upfiles");

		// 첨부파일이 수정 처리된 경우 ---------------------------
		// 1. 원래 첨부파일이 있는데 '파일삭제'를 선택한 경우
		if (qna.getQna_originfile() != null 
				&& delFlag != null && delFlag.equals("yes")) {
			// 저장 폴더에 있는 파일을 삭제함
			new File(savePath + "/" + 
					qna.getQna_renamefile()).delete();
			// notice 의 파일 정보도 제거함
			qna.setQna_originfile(null);
			qna.setQna_renamefile(null);
		}

		// 2. 게시원글 첨부파일은 1개만 가능한 경우
		// 새로운 첨부파일이 있을때
		if (!mfile.isEmpty()) {
			// 2-1. 이전 첨부파일이 있을 때
			if (qna.getQna_originfile() != null) {
				// 저장 폴더에 있는 이전 파일을 삭제함
				new File(savePath + "/" + 
						qna.getQna_renamefile()).delete();
				// board 의 이전 파일 정보도 제거함
				qna.setQna_originfile(null);
				qna.setQna_renamefile(null);
			}

			// 2-2. 이전 첨부파일이 없을 때
			// 전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();

			// 다른 게시글의 첨부파일과 파일명이 중복되어서
			// 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
			// 폴더에 저장하는 방식을 사용할 수 있음
			// 변경 파일명 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {

				String renameFileName = 
						FileNameChange.change(
							fileName, "yyyyMMddHHmmss");

				logger.info("첨부 파일명 확인 : " + fileName 
						+ ", " + renameFileName);

				// 폴더에 저장 처리
				try {
					mfile.transferTo(new File(savePath + 
							"/" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 저장 실패!");
					return "common/error";
				}

				// board 객체에 첨부파일 정보 기록 저장
				qna.setQna_originfile(fileName);
				qna.setQna_renamefile(renameFileName);
			} // 이름바꾸기
		} // 새로운 첨부파일이 있을 때

		if (qnaService.updateQna(qna) > 0) {
			// 게시원글 수정 성공시 상세보기 페이지로 이동
			model.addAttribute("page", page);
			model.addAttribute("qna_no", qna.getQna_no());
			
			return "redirect:qdetail.do";
		} else {
			model.addAttribute("message", qna.getQna_no() 
					+ "번 게시글 수정 실패!");
			return "common/error";
		}
	}
	
	// 첨부파일 다운로드 요청 처리용
	@RequestMapping("qfdown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
		// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/qna_upfiles");

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
	
	//삭제
	@RequestMapping("qdel.do")
	public String qnaDeleteMethod(@RequestParam("qna_no") int qna_no,
			@RequestParam(name="rfile", required=false) String renameFileName,
			Model model, HttpServletRequest request) {

		if(qnaService.deleteQna(qna_no) > 0) {
			//첨부된 파일이 있는 공지일 때는 저장 폴더에 있는
			//첨부파일도 삭제함
			if(renameFileName != null) {
				//공지사항 첨부파일 저장 폴더 경로 지정
				String savePath = request.getSession()
						.getServletContext().getRealPath(
							"resources/qna_upfiles");
				
				new File(savePath + "\\" + renameFileName).delete();
			}
			
			return "redirect:qnalist.do";
		}else {
			model.addAttribute("message", 
					qna_no + "번 QNA 삭제 실패!");
			return "common/error";
		}
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
