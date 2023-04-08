package org.sixpack.semi.bfaf.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sixpack.semi.bfaf.model.service.BfafService;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.bfaf.model.vo.LikeBfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.common.FileNameChange2;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
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
public class BfafController {
	private static final Logger logger = LoggerFactory.getLogger(BfafController.class);
	@Autowired
	private BfafService bfafService;

	// 글추천 처리
	@RequestMapping(value = "bfaflike.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String likeUpDeMethod(Bfaf bfaf) {
		LikeBfaf bfafLike = bfafService.selectLikeBfaf(bfaf);
		if (bfafLike == null) {
			bfafService.insertLikeBfaf(bfaf);
			bfafService.updatePBfafLikeNo(bfaf);
			bfafService.updateMBoardCount(bfaf);
			return "redirect:bfafdetail.do?bfaf_no=" + bfaf.getBfaf_no() + "&user_id=" + bfaf.getUser_id();
		} else {
			bfafService.deleteLikeBfaf(bfaf);
			bfafService.updateMBfafLikeNo(bfaf);
			bfafService.updateMBoardCount(bfaf);
			return "redirect:bfafdetail.do?bfaf_no=" + bfaf.getBfaf_no() + "&user_id=" + null;
		}
	}

	// 댓글,대댓글 수정페이지 이동
	@RequestMapping(value = "movebfafrepup.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveBfafRepUpForm(@RequestParam("bfaf_no") int bfaf_no, Model model) {
		Bfaf bfaf = bfafService.selectBoard(bfaf_no);
		if (bfaf != null) {
			model.addAttribute("bfaf", bfaf);
			return "bfaf/bfafRepUpForm";
		} else {
			model.addAttribute("message", bfaf_no + "번 글 수정페이지로 이동 실패!");
			return "common/error";

		}
	}

	// 댓글,대댓글 수정 처리용
	@RequestMapping(value = "bfafrepupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bfafRepUpdateMethod(Bfaf bfaf, Model model) {
		if (bfafService.updateReple(bfaf) > 0) {
			return "redirect:bfafdetail.do?bfaf_no=" + bfaf.getBfaf_ref();
		} else {
			model.addAttribute("message", "댓글 수정 실패!");
			return "common/error";
		}
	}

	// 대댓글 등록페이지 이동
	@RequestMapping(value = "movebfafrepin2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveBfafRepForm2(Bfaf bfaf, Model model) {
		model.addAttribute("bfaf", bfaf);
		return "bfaf/bfafRepForm2";
	}

	// 대댓글 등록 처리용
	@RequestMapping(value = "bfafrepinsert2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bfafRepInsert2Method(Bfaf bfaf, Model model) {
		if (bfafService.insertReple2(bfaf) > 0) {
			return "redirect:bfafdetail.do?bfaf_no=" + bfaf.getBfaf_ref();
		} else {
			model.addAttribute("message", "대댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글 등록페이지 이동
	@RequestMapping(value = "movebfafrepin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveBfafRepForm(@RequestParam("bfaf_no") int bfaf_ref, Model model) {
		model.addAttribute("bfaf_ref", bfaf_ref);
		return "bfaf/bfafRepForm";
	}

	// 댓글 등록 처리용
	@RequestMapping(value = "bfafrepinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bfafRepInsertMethod(Bfaf bfaf, Model model) {
		if (bfafService.insertReple(bfaf) > 0) {
			return "redirect:bfafdetail.do?bfaf_no=" + bfaf.getBfaf_ref();
		} else {
			model.addAttribute("message", "댓글 등록 실패!");
			return "common/error";
		}
	}

	// 댓글,대댓글 삭제 처리용
	@RequestMapping(value = "bfafrepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bfafRepDeleteMethod(@RequestParam("bfafno") int bfafno, Bfaf bfaf, Model model) {
		if (bfafService.deleteReple(bfaf) > 0) {
			return "redirect:bfafdetail.do?bfaf_no=" + bfafno;
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 원글 수정페이지 이동
	   @RequestMapping(value = "bfafupmove.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public String moveBfafUpdateForm(@RequestParam("bfaf_no") int bfaf_no, Model model) {
	      Bfaf bfaf = bfafService.selectBoard(bfaf_no);

	      if (bfaf != null) {
	         if(bfaf.getOriginfile_bfaf() != null) {
	            String[] ofiles = bfaf.getOriginfile_bfaf().split(" ");
	            String[] rfiles = bfaf.getRenamefile_bfaf().split(" ");
	            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
	            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
	            model.addAttribute("ofile", ofile);
	            model.addAttribute("rfile", rfile);
	         }
	         model.addAttribute("bfaf", bfaf);
	         return "bfaf/bfafUpdateForm";
	      } else {
	         model.addAttribute("message", bfaf_no + "번 글 수정페이지로 이동 실패!");
	         return "common/error";
	      }
	   }

	// 원글 삭제 처리용
	@RequestMapping(value = "bfafdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bfafdeleteMethod(@RequestParam("bfaf_no") int bfaf_no, Model model) {
		if (bfafService.deleteBfafBoard(bfaf_no) > 0) {
			return "redirect:bfaflist.do";
		} else {
			model.addAttribute("message", "게시글 삭제 실패!");
			return "common/error";
		}
	}

	// 게시글 상세보기 처리용
	   @RequestMapping(value = "bfafdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("bfaf_no") int bfaf_no,
	         @RequestParam(name = "user_id", required = false) String user_id,
	         @RequestParam(name = "page", required = false) String page) {
	      int currentPage = 1;
	      if (page != null) {
	         currentPage = Integer.parseInt(page);
	      }

	      // 조회수 1 증가 처리
	      bfafService.updateBoardReadcount(bfaf_no);

	      // 해당 게시글 조회
	      ArrayList<Bfaf> list = bfafService.selectRepleList(bfaf_no);
	      Bfaf bfaf = bfafService.selectBoard(bfaf_no);
	      Bfaf bfaf2 = new Bfaf();
	      bfaf2.setUser_id(user_id);
	      bfaf2.setBfaf_no(bfaf_no);
	      
	      LikeBfaf likeBfaf =   bfafService.selectLikeBfaf(bfaf2);
	      
	      if (list != null) {
	         mv.addObject("list", list);
	      }
	      
	      if(likeBfaf != null) {
	         mv.addObject("likeBfaf", likeBfaf);
	      }

	      if (bfaf != null) {
	         if(bfaf.getOriginfile_bfaf() != null) {
	            String[] ofiles = bfaf.getOriginfile_bfaf().split(" ");
	            String[] rfiles = bfaf.getRenamefile_bfaf().split(" ");
	            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
	            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
	            mv.addObject("ofile", ofile);
	            mv.addObject("rfile", rfile);
	         }
	         mv.addObject("bfaf", bfaf);
	         mv.addObject("currentPage", currentPage);

	         mv.setViewName("bfaf/bfafDetailView");
	      } else {
	         mv.addObject("message", bfaf_no + "번 게시글 조회 실패!");
	         mv.setViewName("common/error");
	      }

	      return mv;
	   }

	// 첨부파일 다운로드 요청 처리용
	@RequestMapping(value = "bfafdown.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {
		// 공지사항 첨부파일 저장폴더에 대한 경로(path) 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/bfaf_upfiles");

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
	   @RequestMapping(value = "bfafinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public String bfafInsertMethod(Bfaf bfaf, Model model, HttpServletRequest request,
	         @RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

	      // 첨부파일 저장 폴더 경로 지정
	      String savePath = request.getSession().getServletContext().getRealPath("resources/bfaf_upfiles");
	      
	      String originfile = "";
	      String renamefile = "";
	      
	      // 첨부파일이 있을때
	      if (!mfiles.isEmpty()) {
	         for(MultipartFile mfile : mfiles) {
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
	         bfaf.setOriginfile_bfaf(originfile.trim());
	         bfaf.setRenamefile_bfaf(renamefile.trim());
	      } // 새로운 첨부파일이 있을 때

	      if (bfafService.insertBoard(bfaf) > 0) {
	         // 공지글 수정 성공시 목록 보기 페이지로 이동
	         return "redirect:bfaflist.do";
	      } else {
	         model.addAttribute("message", "게시글 등록 실패!");
	         return "common/error";
	      }
	   }

	   // 게시원글 수정 요청 처리용 (파일 업로드 기능 사용)
	   @RequestMapping(value = "bfafupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	   public String boardUpdateMethod(Bfaf bfaf, Model model, HttpServletRequest request,
	         @RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

	      // 게시원글 첨부파일 저장 폴더 경로 지정
	      String savePath = request.getSession().getServletContext().getRealPath("resources/bfaf_upfiles");
	      String originfile = "";
	      String renamefile = "";
	      String[] ofiles = bfaf.getOriginfile_bfaf().split(" ");
	      String[] rfiles = bfaf.getRenamefile_bfaf().split(" ");
	      String[] delFlag = request.getParameterValues("delflag");
	      
	      // 첨부파일이 수정 처리된 경우 ---------------------------
	      // 1. 원래 첨부파일이 있는데 '파일삭제'를 선택한 경우
	      if (bfaf.getRenamefile_bfaf() != null && delFlag != null) {
	         for(int i = 0; i < delFlag.length; i++) {
	            for(int k = 0; k < rfiles.length; k++) {
	               if(delFlag[i].equals(rfiles[k])) {
	                  new File(savePath + "/" + delFlag[i]).delete();
	                  rfiles[k] = "x";
	                  ofiles[k] = "x";
	               }
	            }
	         }
	         for(int i = 0; i < rfiles.length; i++) {
	            if(!rfiles[i].equals("x")) {
	               originfile += ofiles[i] +" ";
	               renamefile += rfiles[i] +" ";
	            }
	         }
	         
	         bfaf.setOriginfile_bfaf(originfile.trim());
	         bfaf.setRenamefile_bfaf(renamefile.trim());
	      }
	      
	      for(int i = 0; i < mfiles.size(); i++) {
	         // 2.새로운 첨부파일이 있을때
	         if (!mfiles.get(i).isEmpty()) {
	            // 2-1. 이전 첨부파일이 있을 때
	            if (bfaf.getRenamefile_bfaf() != null) {
	               // 저장 폴더에 있는 이전 파일을 삭제함
	               new File(savePath + "/" + bfaf.getRenamefile_bfaf()).delete();
	               //이전 파일 정보도 제거함
	               bfaf.setOriginfile_bfaf(null);
	               bfaf.setRenamefile_bfaf(null);
	            }
	         }
	      }
	      if(!mfiles.isEmpty()) {
	            // 2-2. 이전 첨부파일이 없을 때
	            // 전송온 파일이름 추출함
	            for(MultipartFile mfile : mfiles) {
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
	                  //bfaf.setOriginfile_bfaf(fileName);
	                  //bfaf.setRenamefile_bfaf(renameFileName);
	                  originfile += fileName + " ";
	                  renamefile += renameFileName + " ";
	               } // 이름바꾸기
	               bfaf.setOriginfile_bfaf(originfile.trim());
	               bfaf.setRenamefile_bfaf(renamefile.trim());
	            }
	            // 객체에 첨부파일 정보 기록 저장
	         }
	      

	      if (bfafService.updateBoard(bfaf) > 0) {
	         // 게시원글 수정 성공시 상세보기 페이지로 이동
	         model.addAttribute("bfaf_no", bfaf.getBfaf_no());

	         return "redirect:bfafdetail.do";
	      } else {
	         model.addAttribute("message", bfaf.getBfaf_no() + "번 게시글 수정 실패!");
	         return "common/error";
	      }
	   }

	// 리스트
	@RequestMapping(value = "bfaflist.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView bfafListMethod(@RequestParam(name = "page", required = false) String page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = bfafService.selectListCount();
		Paging paging = new Paging(listCount, currentPage, limit);

		ArrayList<Bfaf> list = bfafService.selectList(paging);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);

			mv.setViewName("bfaf/bfafListView");
		} else {
			mv.addObject("message", currentPage + "페이지 리스트 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 검색
	@RequestMapping(value = "bfafsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView bfafSearchMethod(@RequestParam(name = "page", required = false, defaultValue = "1") String page,
			HttpServletRequest request, ModelAndView mv) {
		String searchtype = request.getParameter("searchtype");
		String keyword = request.getParameter("keyword");

		CountSearch countSearch = new CountSearch(searchtype, keyword);

		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		int listCount = bfafService.selectSearchListCount(countSearch);
		Searchs searchs = new Searchs(listCount, currentPage, limit);

		searchs.setSearchtype(searchtype);
		searchs.setKeyword(keyword);

		ArrayList<Bfaf> list;
		if (searchtype.equals("baname")) {
			list = bfafService.selectSearchTitle(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("bfaf/bfafListView2");
			}
		} else if (searchtype.equals("bavalue")) {
			list = bfafService.selectSearchValue(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("bfaf/bfafListView2");
			}
		} else if (searchtype.equals("baid")) {
			list = bfafService.selectSearchWriter(searchs);
			if (list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("searchs", searchs);

				mv.setViewName("bfaf/bfafListView2");
			}
		} 
		
		if(mv.isEmpty()) {
			mv.addObject("searchs", searchs);
			mv.setViewName("bfaf/bfafListView2");
			return mv;
		}else {
			return mv;
		}
	}
}
