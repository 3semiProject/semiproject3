package org.sixpack.semi.notice.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.notice.model.service.NoticeService;
import org.sixpack.semi.notice.model.vo.Notice;
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
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	//공지사항 전체 목록보기 요청 처리용
	@RequestMapping("nlist.do")
	public ModelAndView noticeListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 8;
		
		int listCount = noticeService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);
		paging.calculator();
		
		
		ArrayList<Notice> list = noticeService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("notice/noticeListView");
		}else {
			mv.addObject("message", "등록된 공지사항 정보가 없습니다.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	//공지글 검색용 
	@RequestMapping(value="nsearch.do", method=RequestMethod.POST)
	public String noitceSearchTitleMethod(@RequestParam("keyword") String keyword,
			@RequestParam("searchtype") String searchtype, Model model) {
		ArrayList<Notice> list;
		
		//제목검색
		if(searchtype.equals("nname")) {
			list = noticeService.selectSearchTitle(keyword);
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else if(searchtype.equals("ncontent")) {
			list = noticeService.selectSearchContent(keyword);
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else if(searchtype.equals("nid")) {
			list = noticeService.selectSearchWriter(keyword);
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", keyword + "로 검색된 공지글 정보가 없습니다.");
			return "common/error";
		}
	}
	
	//공지글 상세보기 요청 처리용
	@RequestMapping("ndetail.do")
	public String noticeDetailMethod(@RequestParam("notice_no") int notice_no, Model model, HttpSession session) {
		//관리자용 상세보기 페이지와 일반 회원|비회원 상세보기 페이지 구분함
		//HttpSession 을 매개변수에 추가함
		
		Notice notice = noticeService.selectNotice(notice_no);
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			
			Member loginMember = (Member)session.getAttribute("loginMember");
			
			if(loginMember != null && loginMember.getAdmin_ck().equals("Y")) {
				//로그인한 관리자가 요청했다면
				return "notice/noticeAdminDetailView";
			}else {
				//관리자가 아닌 | 로그인 안 한 상태에서의 요청이라면
				return "notice/noticeDetailView";
			}
			
		}else {
			model.addAttribute("message", notice_no + "번 공지글 상세보기 조회 실패!");
			return "common/error";
		}
		
	}
	
	//첨부파일 다운로드 요청 처리용
	@RequestMapping("nfdown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request, 
									   @RequestParam("ofile") String originalFileName, 
									   @RequestParam("rfile") String renameFileName) {
		//공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//저장 폴더에서 읽을 파일에 대한 파일 객체 생성함
		File renameFile = new File(savePath + "\\" + renameFileName);
		//파일 다운시 내보낼 원래 이름의 파일 객체 생성함
		File originFile = new File(originalFileName);
		
		//파일 다운로드 뷰로 전달할 정보 저장
		mv.setViewName("filedown");  //등록된 파일다운로드 뷰의 id명
		mv.addObject("renameFile", renameFile);
		mv.addObject("originFile", originFile);
		
		return mv;
		
	}
	
	//공지글 수정페이지로 이동 요청 처리용
	@RequestMapping("nmoveup.do")
	public String moveUpdatePage(@RequestParam("noticeno") int noticeno, Model model) {
		//수정페이지에 출력할 해당 공지글 다시 조회함
		Notice notice = noticeService.selectNotice(noticeno);
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			return "notice/noticeUpdateForm";
		}else {
			model.addAttribute("message", noticeno + "번 공지글 수정페이지로 이동 실패!");
			return "common/error";
		}
		
		
	}
	
	//공지글 수정 요청 처리용 (파일 업로드 기능 사용)
	@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
	public String noticeUpdateMethod(Notice notice, Model model, HttpServletRequest request,
									@RequestParam(name="delflag", required=false) String delFlag,
									@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		
		//공지사항 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//첨부파일이 수정 처리된 경우 -------------------------------------------------------
		//1. 원래 첨부파일이 있는데 '파일삭제'를 선택한 경우
		if(notice.getNotice_originfile() != null && delFlag != null && delFlag.equals("yes")) {
			//저장 폴더에 있는 파일을 삭제함
			new File(savePath + "\\" + notice.getNotice_renamefile()).delete();
			//notice 의 파일 정보도 제거함
			notice.setNotice_originfile(null);
			notice.setNotice_renamefile(null);
		}
		
		//2. 공지글 첨부파일은 1개만 가능한 경우
		//새로운 첨부파일이 있을때
		if(!mfile.isEmpty()) {
			//2-1. 이전 첨부파일이 있을 때
			if(notice.getNotice_originfile() != null) {
				//저장 폴더에 있는 이전 파일을 삭제함
				new File(savePath + "\\" + notice.getNotice_renamefile()).delete();
				//notice 의 이전 파일 정보도 제거함
				notice.setNotice_originfile(null);
				notice.setNotice_renamefile(null);
			}
			
			//2-2. 이전 첨부파일이 없을 때
			//전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			
			//다른 공지글의 첨부파일과 파일명이 중복되어서
			//덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
			//폴더에 저장하는 방식을 사용할 수 있음
			//변경 파일명 : 년월일시분초.확장자
//			mfile.transferTo(new File(savePath + "\\" + fileName + ext)) // 이렇게 해도됨 하지만 변경파일명으로 할꺼임
			if(fileName != null && fileName.length() > 0) {
				//바꿀 파일명에 대한 문자열 만들기
				//공지글 등록 | 수정 요청시점의 날짜시간정보를 이용함
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				//변경할 파일명 만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				logger.info("첨부 변경 파일명 : " + fileName + ", " + renameFileName);
				
				//파일 객체 만들기
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				//폴더에 저장 처리 
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 저장 실패!");
					return "common/error";
				}
				
				//notice 객체에 첨부파일 정보 기록 저장
				notice.setNotice_originfile(fileName);
				notice.setNotice_renamefile(renameFileName);
			}	//이름바꾸기
		}	//새로운 첨부파일이 있을 때
		
		if(noticeService.updateNotice(notice) > 0) {
			//공지글 수정 성공시 목록 보기 페이지로 이동
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", notice.getNotice_no() + "번 공지 수정 실패!");
			return "common/error";
		}
	}
	
	//공지글 삭제 요청 처리용
	@RequestMapping("ndel.do")
	public String noticeDeleteMethod(@RequestParam("notice_no") int notice_no,
									 @RequestParam(name="rfile", required=false) String renameFileName,
									 Model model, HttpServletRequest request) {
		
		if(noticeService.deleteNotice(notice_no) > 0) {
			//첨부된 파일이 있는 공지일 때는 저장 폴더에 있는 첨부파일도 삭제함
			if(renameFileName != null) {
				//공지사항 첨부파일 저장 폴더 경로 지정
				String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
				new File(savePath + "\\" + renameFileName).delete();
			}
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", notice_no + "번 공지 삭제 실패!");
			return "common/error";
		}
	}

	//새 공지글 등록 페이지로 이동 처리용
	@RequestMapping("nmovewrite.do")
	public String moveWritePage() {
		return "notice/noticeWriteForm";
	}
	
	@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
	public String noticeInsertMethod(Notice notice, Model model, HttpServletRequest request,
									@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		
		//공지사항 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//새로운 첨부파일이 있을때
		if(!mfile.isEmpty()) {
			
			//전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			
			//다른 공지글의 첨부파일과 파일명이 중복되어서
			//덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
			//폴더에 저장하는 방식을 사용할 수 있음
			//변경 파일명 : 년월일시분초.확장자
//			mfile.transferTo(new File(savePath + "\\" + fileName + ext)) // 이렇게 해도됨 하지만 변경파일명으로 할꺼임
			if(fileName != null && fileName.length() > 0) {
				//바꿀 파일명에 대한 문자열 만들기
				//공지글 등록 | 수정 요청시점의 날짜시간정보를 이용함
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				//변경할 파일명 만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				logger.info("첨부 변경 파일명 : " + fileName + ", " + renameFileName);
				
				//파일 객체 만들기
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				//폴더에 저장 처리 
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 저장 실패!");
					return "common/error";
				}
				
				//notice 객체에 첨부파일 정보 기록 저장
				notice.setNotice_originfile(fileName);
				notice.setNotice_renamefile(renameFileName);
			}	//이름바꾸기
		}	//새로운 첨부파일이 있을 때
		
		if(noticeService.insertNotice(notice) > 0) {
			//공지글 수정 성공시 목록 보기 페이지로 이동
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", "새 공지 등록 실패!");
			return "common/error";
		}
	}
	
}