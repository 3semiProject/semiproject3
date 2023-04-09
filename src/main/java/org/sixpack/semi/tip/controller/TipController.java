package org.sixpack.semi.tip.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange2;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.tip.model.service.TipService;
import org.sixpack.semi.tip.model.vo.LikeTip;
import org.sixpack.semi.tip.model.vo.Tip;
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
public class TipController {
	private static final Logger logger = LoggerFactory.getLogger(TipController.class);

	@Autowired
	private TipService tipService;

	// 글추천 처리
	@RequestMapping(value = "tiplike.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String likeUpDeMethod(Tip tip) {
		LikeTip tipLike = tipService.selectLikeTip(tip);
		if (tipLike == null) {
			tipService.insertLikeTip(tip);
			tipService.updatePTipLikeNo(tip);
			tipService.updateMBoardCount(tip);
			return "redirect:tipdetail.do?tip_no=" + tip.getTip_no() + "&user_id=" + tip.getUser_id();
		} else {
			tipService.deleteLikeTip(tip);
			tipService.updateMTipLikeNo(tip);
			tipService.updateMBoardCount(tip);
			return "redirect:tipdetail.do?tip_no=" + tip.getTip_no() + "&user_id=" + null;
		}
	}

	// 댓글,대댓글 수정페이지 이동
	@RequestMapping(value = "movetiprepup.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveTipRepUpForm(@RequestParam("tip_no") int tip_no, Model model) {
		Tip tip = tipService.selectBoard(tip_no);
		if (tip != null) {
			model.addAttribute("tip", tip);
			return "tip/tipRepUpForm";
		} else {
			model.addAttribute("message", tip_no + "번 글 수정페이지로 이동 실패!");
			return "common/error";

		}
	}

	// 댓글,대댓글 수정 처리용
	@RequestMapping(value = "tiprepupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipRepUpdateMethod(Tip tip, Model model) {
		if (tipService.updateReple(tip) > 0) {
			return "redirect:tipdetail.do?tip_no=" + tip.getTip_ref();
		} else {
			model.addAttribute("message", "댓글 수정 실패!");
			return "common/error";
		}
	}

	// 대댓글 등록페이지 이동
	@RequestMapping(value = "movetiprepin2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveTipRepForm2(Tip tip, Model model) {
		model.addAttribute("tip", tip);
		return "tip/tipRepForm2";
	}

	// 대댓글 등록 처리용
	@RequestMapping(value = "tiprepinsert2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipRepInsert2Method(Tip tip, Model model) {
		if (tipService.insertReple2(tip) > 0) {
			return "redirect:tipdetail.do?tip_no=" + tip.getTip_ref();
		} else {
			model.addAttribute("message", "대댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글 등록페이지 이동
	@RequestMapping(value = "movetiprepin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveTipRepForm(@RequestParam("tip_no") int tip_ref, Model model) {
		model.addAttribute("tip_ref", tip_ref);
		return "tip/tipRepForm";
	}

	// 댓글 등록 처리용
	@RequestMapping(value = "tiprepinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipRepInsertMethod(Tip tip, Model model) {
		if (tipService.insertReple(tip) > 0) {
			return "redirect:tipdetail.do?tip_no=" + tip.getTip_ref();
		} else {
			model.addAttribute("message", "댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글,대댓글 삭제 처리용
	@RequestMapping(value = "tiprepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipRepDeleteMethod(@RequestParam("tipno") int tipno, Tip tip, Model model) {
		if (tipService.deleteReple(tip) > 0) {
			return "redirect:tipdetail.do?tip_no=" + tipno;
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 원글 수정페이지 이동
	@RequestMapping(value = "tipupmove.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveTipUpdateForm(@RequestParam("tip_no") int tip_no, Model model) {
		Tip tip = tipService.selectBoard(tip_no);

		if (tip != null) {
			if (tip.getOriginfile_tip() != null) {
				String[] ofiles = tip.getOriginfile_tip().split(" ");
				String[] rfiles = tip.getRenamefile_tip().split(" ");
				List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
				List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
				model.addAttribute("ofile", ofile);
				model.addAttribute("rfile", rfile);
			}
			model.addAttribute("tip", tip);
			return "tip/tipUpdateForm";
		} else {
			model.addAttribute("message", tip_no + "번 글 수정페이지로 이동 실패!");
			return "common/error";
		}
	}

	// 원글 삭제 처리용
	@RequestMapping(value = "tipdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipdeleteMethod(@RequestParam("tip_no") int tip_no, Model model) {
		if (tipService.deleteTipBoard(tip_no) > 0) {
			return "redirect:tiplist.do";
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 게시글 상세보기 처리용
	@RequestMapping(value = "tipdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("tip_no") int tip_no,
			@RequestParam(name = "user_id", required = false) String user_id,
			@RequestParam(name = "page", required = false) String page) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 조회수 1 증가 처리
		tipService.updateBoardReadcount(tip_no);

		// 해당 게시글 조회
		ArrayList<Tip> list = tipService.selectRepleList(tip_no);
		Tip tip = tipService.selectBoard(tip_no);
		Tip tip2 = new Tip();
		tip2.setUser_id(user_id);
		tip2.setTip_no(tip_no);

		LikeTip likeTip = tipService.selectLikeTip(tip2);

		if (list != null) {
			mv.addObject("list", list);
		}

		if (likeTip != null) {
			mv.addObject("likeTip", likeTip);
		}

		if (tip != null) {
			if (tip.getOriginfile_tip() != null) {
				String[] ofiles = tip.getOriginfile_tip().split(" ");
				String[] rfiles = tip.getRenamefile_tip().split(" ");
				List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
				List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
				mv.addObject("ofile", ofile);
				mv.addObject("rfile", rfile);
			}
			mv.addObject("tip", tip);
			mv.addObject("currentPage", currentPage);

			mv.setViewName("tip/tipDetailView");
		} else {
			mv.addObject("message", tip_no + "번 게시글 조회 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 첨부파일 다운로드 요청 처리용
	@RequestMapping(value = "tipdown.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
		// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/tip_upfiles");

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
	@RequestMapping(value = "tipinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String tipInsertMethod(Tip tip, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

		// 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/tip_upfiles");

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
			tip.setOriginfile_tip(originfile.trim());
			tip.setRenamefile_tip(renamefile.trim());
		} // 새로운 첨부파일이 있을 때

		if (tipService.insertBoard(tip) > 0) {
			// 공지글 수정 성공시 목록 보기 페이지로 이동
			return "redirect:tiplist.do";
		} else {
			model.addAttribute("message", "게시글 등록 실패!");
			return "common/error";
		}
	}

	// 게시원글 수정 요청 처리용 (파일 업로드 기능 사용)
	@RequestMapping(value = "tipupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardUpdateMethod(Tip tip, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

		// 게시원글 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/tip_upfiles");
		String originfile = "";
		String renamefile = "";
		String[] ofiles = tip.getOriginfile_tip().split(" ");
		String[] rfiles = tip.getRenamefile_tip().split(" ");
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
			tip.setOriginfile_tip(originfile.trim());
			tip.setRenamefile_tip(renamefile.trim());
		} else {
			for (int i = 0; i < rfiles.length; i++) {
				originfile += ofiles[i] + " ";
				renamefile += rfiles[i] + " ";
			}
			tip.setOriginfile_tip(originfile.trim());
			tip.setRenamefile_tip(renamefile.trim());
		}

		for (int i = 0; i < mfiles.size(); i++) {
			// 2.새로운 첨부파일이 있을때
			if (!mfiles.get(i).isEmpty()) {
				// 2-1. 이전 첨부파일이 있을 때
				if (tip.getRenamefile_tip() != null) {
					// 저장 폴더에 있는 이전 파일을 삭제함
					for (int k = 0; k < rfiles.length; k++) {
						new File(savePath + "/" + rfiles[k]).delete();
					}
					// 이전 파일 정보도 제거함
					originfile = "";
					renamefile = "";
					tip.setOriginfile_tip(null);
					tip.setRenamefile_tip(null);
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
					// tip.setOriginfile_tip(fileName);
					// tip.setRenamefile_tip(renameFileName);
					originfile += fileName + " ";
					renamefile += renameFileName + " ";
				} // 이름바꾸기
				tip.setOriginfile_tip(originfile.trim());
				tip.setRenamefile_tip(renamefile.trim());
			}
			// 객체에 첨부파일 정보 기록 저장
		}

		if (tipService.updateBoard(tip) > 0) {
			// 게시원글 수정 성공시 상세보기 페이지로 이동
			model.addAttribute("tip_no", tip.getTip_no());

			return "redirect:tipdetail.do";
		} else {
			model.addAttribute("message", tip.getTip_no() + "번 게시글 수정 실패!");
			return "common/error";
		}
	}

	// 리스트
	@RequestMapping(value = "tiplist.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView tipListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = tipService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);

		ArrayList<Tip> list = tipService.selectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("tip/tipListView");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 검색
	@RequestMapping(value = "tipsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView tipSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = tipService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<Tip> list;
		if (searchtype.equals("tname")) {
			list = tipService.selectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("tip/tipListView2");
			}
		} else if (searchtype.equals("tvalue")) {
			list = tipService.selectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("tip/tipListView2");
			}
		} else if (searchtype.equals("tid")) {
			list = tipService.selectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("tip/tipListView2");
			}
		}
		if (mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("tip/tipListView2");
			return mv;
		} else {
			return mv;
		}
	}
}
