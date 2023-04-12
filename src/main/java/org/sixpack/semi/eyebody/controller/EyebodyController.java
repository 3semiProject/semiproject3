package org.sixpack.semi.eyebody.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.FileNameChange2;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.service.EyebodyService;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.eyebody.model.vo.LikeEyebody;
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
public class EyebodyController {
	private static final Logger logger = LoggerFactory.getLogger(EyebodyController.class);

	@Autowired
	private EyebodyService eyebodyService;

	// 글추천 처리
	@RequestMapping(value = "eyebodylike.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String likeUpDeMethod(Eyebody eyebody) {
		LikeEyebody eyebodyLike = eyebodyService.selectLikeEyebody(eyebody);
		if (eyebodyLike == null) {
			eyebodyService.insertLikeEyebody(eyebody);
			eyebodyService.updatePEyebodyLikeNo(eyebody);
			eyebodyService.updateMBoardCount(eyebody);
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebody.getEyebody_no() + "&user_id="
					+ eyebody.getUser_id();
		} else {
			eyebodyService.deleteLikeEyebody(eyebody);
			eyebodyService.updateMEyebodyLikeNo(eyebody);
			eyebodyService.updateMBoardCount(eyebody);
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebody.getEyebody_no() + "&user_id=" + null;
		}
	}

	// 댓글,대댓글 수정페이지 이동
	@RequestMapping(value = "moveeyebodyrepup.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveEyebodyRepUpForm(@RequestParam("eyebody_no") int eyebody_no, Model model) {
		Eyebody eyebody = eyebodyService.selectBoard(eyebody_no);
		if (eyebody != null) {
			model.addAttribute("eyebody", eyebody);
			return "eyebody/eyebodyRepUpForm";
		} else {
			model.addAttribute("message", eyebody_no + "번 글 수정페이지로 이동 실패!");
			return "common/error";

		}
	}

	// 댓글,대댓글 수정 처리용
	@RequestMapping(value = "eyebodyrepupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodyRepUpdateMethod(Eyebody eyebody, Model model) {
		if (eyebodyService.updateReple(eyebody) > 0) {
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebody.getEyebody_ref();
		} else {
			model.addAttribute("message", "댓글 수정 실패!");
			return "common/error";
		}
	}

	// 대댓글 등록페이지 이동
	@RequestMapping(value = "moveeyebodyrepin2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveEyebodyRepForm2(Eyebody eyebody, Model model) {
		model.addAttribute("eyebody", eyebody);
		return "eyebody/eyebodyRepForm2";
	}

	// 대댓글 등록 처리용
	@RequestMapping(value = "eyebodyrepinsert2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodyRepInsert2Method(Eyebody eyebody, Model model) {
		if (eyebodyService.insertReple2(eyebody) > 0) {
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebody.getEyebody_ref();
		} else {
			model.addAttribute("message", "대댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글 등록페이지 이동
	@RequestMapping(value = "moveeyebodyrepin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveEyebodyRepForm(@RequestParam("eyebody_no") int eyebody_ref, Model model) {
		model.addAttribute("eyebody_ref", eyebody_ref);
		return "eyebody/eyebodyRepForm";
	}

	// 댓글 등록 처리용
	@RequestMapping(value = "eyebodyrepinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodyRepInsertMethod(Eyebody eyebody, Model model) {
		if (eyebodyService.insertReple(eyebody) > 0) {
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebody.getEyebody_ref();
		} else {
			model.addAttribute("message", "댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글,대댓글 삭제 처리용
	@RequestMapping(value = "eyebodyrepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodyRepDeleteMethod(@RequestParam("eyebodyno") int eyebodyno, Eyebody eyebody, Model model) {
		if (eyebodyService.deleteReple(eyebody) > 0) {
			return "redirect:eyebodydetail.do?eyebody_no=" + eyebodyno;
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 원글 수정페이지 이동
	@RequestMapping(value = "eyebodyupmove.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveEyebodyUpdateForm(@RequestParam("eyebody_no") int eyebody_no, Model model) {
		Eyebody eyebody = eyebodyService.selectBoard(eyebody_no);

		if (eyebody != null) {
			if (eyebody.getOriginfile_eyebody() != null) {
				String[] ofiles = eyebody.getOriginfile_eyebody().split(" ");
				String[] rfiles = eyebody.getRenamefile_eyebody().split(" ");
				List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
				List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
				model.addAttribute("ofile", ofile);
				model.addAttribute("rfile", rfile);
			}
			model.addAttribute("eyebody", eyebody);
			return "eyebody/eyebodyUpdateForm";
		} else {
			model.addAttribute("message", eyebody_no + "번 글 수정페이지로 이동 실패!");
			return "common/error";
		}
	}

	// 원글 삭제 처리용
	@RequestMapping(value = "eyebodydelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodydeleteMethod(@RequestParam("eyebody_no") int eyebody_no, Model model) {
		if (eyebodyService.deleteEyebodyBoard(eyebody_no) > 0) {
			return "redirect:eyebodylist.do";
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 게시글 상세보기 처리용
	@RequestMapping(value = "eyebodydetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("eyebody_no") int eyebody_no,
			@RequestParam(name = "user_id", required = false) String user_id,
			@RequestParam(name = "page", required = false, defaultValue = "1") String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 조회수 1 증가 처리
		eyebodyService.updateBoardReadcount(eyebody_no);

		// 해당 게시글 조회
		ArrayList<Eyebody> list = eyebodyService.selectRepleList(eyebody_no);
		Eyebody eyebody = eyebodyService.selectBoard(eyebody_no);
		Eyebody eyebody2 = new Eyebody();
		eyebody2.setUser_id(user_id);
		eyebody2.setEyebody_no(eyebody_no);

		LikeEyebody likeEyebody = eyebodyService.selectLikeEyebody(eyebody2);

		if (list != null) {
			mv.addObject("list", list);
		}

		if (likeEyebody != null) {
			mv.addObject("likeEyebody", likeEyebody);
		}

		if (eyebody != null) {
			if (eyebody.getOriginfile_eyebody() != null) {
				String[] ofiles = eyebody.getOriginfile_eyebody().split(" ");
				String[] rfiles = eyebody.getRenamefile_eyebody().split(" ");
				List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
				List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
				mv.addObject("ofile", ofile);
				mv.addObject("rfile", rfile);
			}
			mv.addObject("eyebody", eyebody);
			mv.addObject("currentPage", currentPage);

			mv.setViewName("eyebody/eyebodyDetailView");
		} else {
			mv.addObject("message", eyebody_no + "번 게시글 조회 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 첨부파일 다운로드 요청 처리용
	@RequestMapping(value = "eyebodydown.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
		// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/eyebody_upfiles");

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
	@RequestMapping(value = "eyebodyinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String eyebodyInsertMethod(Eyebody eyebody, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

		// 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/eyebody_upfiles");

		String originfile = "";
		String renamefile = "";

		// 첨부파일이 있을때
		if (!mfiles.isEmpty()) {
			for (MultipartFile mfile : mfiles) {
				// 전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();

				// 다른 공지글의 첨부파일과 파일명이 중복되어서
				// 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
				// 폴더에 저장하는 방식을 사용할 수 있음
				// 변경 파일명 : 년월일시분초.확장자
				if (fileName != null && fileName.length() > 0) {
					// 바꿀 파일명에 대한 문자열 만들기
					String renameFileName = FileNameChange2.change(fileName, "yyyyMMddHHmmss");
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
					originfile += fileName + " ";
					renamefile += renameFileName + " ";
				} // 이름바꾸기
			}
			// 객체에 첨부파일 정보 기록 저장
			eyebody.setOriginfile_eyebody(originfile.trim());
			eyebody.setRenamefile_eyebody(renamefile.trim());
		} // 새로운 첨부파일이 있을 때

		if (eyebodyService.insertBoard(eyebody) > 0) {
			// 공지글 수정 성공시 목록 보기 페이지로 이동
			return "redirect:eyebodylist.do";
		} else {
			model.addAttribute("message", "게시글 등록 실패!");
			return "common/error";
		}
	}

	// 게시원글 수정 요청 처리용 (파일 업로드 기능 사용)
	@RequestMapping(value = "eyebodyupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardUpdateMethod(Eyebody eyebody, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

		// 게시원글 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/eyebody_upfiles");
		String originfile = "";
		String renamefile = "";
		String[] ofiles = eyebody.getOriginfile_eyebody().split(" ");
		String[] rfiles = eyebody.getRenamefile_eyebody().split(" ");
		String[] delFlag = request.getParameterValues("delflag");

		// 첨부파일이 수정 처리된 경우 ---------------------------
		// 1. 원래 첨부파일이 있는데 '파일삭제'를 선택한 경우
		if (delFlag != null) {
			for (int i = 0; i < delFlag.length; i++) {
				for (int k = 0; k < rfiles.length; k++) {
					if (delFlag[i].equals(rfiles[k])) {
						new File(savePath + "/" + delFlag[i]).delete();
						rfiles[k] = "x";
						ofiles[k] = "x";
					}
				}
			}
			for (int i = 0; i < rfiles.length; i++) {
				if (!rfiles[i].equals("x")) {
					originfile += ofiles[i] + " ";
					renamefile += rfiles[i] + " ";
				}
			}
			eyebody.setOriginfile_eyebody(originfile.trim());
			eyebody.setRenamefile_eyebody(renamefile.trim());
		} else {
			for (int i = 0; i < rfiles.length; i++) {
				originfile += ofiles[i] + " ";
				renamefile += rfiles[i] + " ";
			}
			eyebody.setOriginfile_eyebody(originfile.trim());
			eyebody.setRenamefile_eyebody(renamefile.trim());
		}

		for (int i = 0; i < mfiles.size(); i++) {
			// 2.새로운 첨부파일이 있을때
			if (!mfiles.get(i).isEmpty()) {
				// 2-1. 이전 첨부파일이 있을 때
				if (eyebody.getRenamefile_eyebody() != null) {
					// 저장 폴더에 있는 이전 파일을 삭제함
					for (int k = 0; k < rfiles.length; k++) {
						new File(savePath + "/" + rfiles[k]).delete();
					}
					// 이전 파일 정보도 제거함
					originfile = "";
					renamefile = "";
					eyebody.setOriginfile_eyebody(null);
					eyebody.setRenamefile_eyebody(null);
				}
			}
		}
		if (!mfiles.isEmpty()) {
			// 2-2. 이전 첨부파일이 없을 때
			// 전송온 파일이름 추출함
			for (MultipartFile mfile : mfiles) {
				// 전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();

				// 다른 공지글의 첨부파일과 파일명이 중복되어서
				// 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
				// 폴더에 저장하는 방식을 사용할 수 있음
				// 변경 파일명 : 년월일시분초.확장자
				if (fileName != null && fileName.length() > 0) {
					// 바꿀 파일명에 대한 문자열 만들기
					String renameFileName = FileNameChange2.change(fileName, "yyyyMMddHHmmss");
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
					// eyebody.setOriginfile_eyebody(fileName);
					// eyebody.setRenamefile_eyebody(renameFileName);
					originfile += fileName + " ";
					renamefile += renameFileName + " ";
				} // 이름바꾸기
				eyebody.setOriginfile_eyebody(originfile.trim());
				eyebody.setRenamefile_eyebody(renamefile.trim());
			}
			// 객체에 첨부파일 정보 기록 저장
		}

		if (eyebodyService.updateBoard(eyebody) > 0) {
			// 게시원글 수정 성공시 상세보기 페이지로 이동
			model.addAttribute("eyebody_no", eyebody.getEyebody_no());

			return "redirect:eyebodydetail.do?user_id="+eyebody.getUser_id();
		} else {
			model.addAttribute("message", eyebody.getEyebody_no() + "번 게시글 수정 실패!");
			return "common/error";
		}
	}

	// 리스트
	@RequestMapping(value = "eyebodylist.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView eyebodyListMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = eyebodyService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);

		ArrayList<Eyebody> list = eyebodyService.selectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("eyebody/eyebodyListView");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 검색
	@RequestMapping(value = "eyebodysearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView eyebodySearchMethod(
			@RequestParam(name = "page", required = false, defaultValue = "1") String page, HttpServletRequest request,
			ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = eyebodyService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<Eyebody> list;
		if (searchtype.equals("ebname")) {
			list = eyebodyService.selectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("eyebody/eyebodyListView2");
			}
		} else if (searchtype.equals("ebvalue")) {
			list = eyebodyService.selectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("eyebody/eyebodyListView2");
			}
		} else if (searchtype.equals("ebid")) {
			list = eyebodyService.selectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("eyebody/eyebodyListView2");
			}
		}
		if (mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("eyebody/eyebodyListView2");
			return mv;
		} else {
			return mv;
		}
	}
}
