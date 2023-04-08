package org.sixpack.semi.free.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.FileNameChange2;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.free.model.vo.LikeFree;
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

   //글추천 처리
   @RequestMapping(value = "freelike.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String likeUpDeMethod(Free free) {
      LikeFree freeLike = freeService.selectLikeFree(free);
      if (freeLike == null) {
         freeService.insertLikeFree(free);
         freeService.updatePFreeLikeNo(free);
         freeService.updateMBoardCount(free);
         return "redirect:freedetail.do?free_no=" + free.getFree_no()+ "&user_id=" + free.getUser_id();
      }else {
         freeService.deleteLikeFree(free);
         freeService.updateMFreeLikeNo(free);
         freeService.updateMBoardCount(free);
         return "redirect:freedetail.do?free_no=" + free.getFree_no() + "&user_id=" + null;
      }
   }

   //글쓰기 페이지 이동
   @RequestMapping(value = "commuwrite.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String moveWriteMethod() {
      return "common/cwriteForm";
   }
   
   // 댓글,대댓글 수정페이지 이동
   @RequestMapping(value = "movefreerepup.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String moveFreeRepUpForm(@RequestParam("free_no") int free_no, Model model) {
      Free free = freeService.selectBoard(free_no);
      if (free != null) {
         model.addAttribute("free", free);
         return "free/freeRepUpForm";
      } else {
         model.addAttribute("message", free_no + "번 글 수정페이지로 이동 실패!");
         return "common/error";

      }
   }
   
   // 댓글,대댓글 수정 처리용
   @RequestMapping(value = "freerepupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freeRepUpdateMethod(Free free, Model model) {
      if (freeService.updateReple(free) > 0) {
         return "redirect:freedetail.do?free_no=" + free.getFree_ref();
      } else {
         model.addAttribute("message", "댓글 수정 실패!");
         return "common/error";
      }
   }
   
   // 대댓글 등록페이지 이동
   @RequestMapping(value = "movefreerepin2.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String moveFreeRepForm2(Free free, Model model) {
      model.addAttribute("free", free);
      return "free/freeRepForm2";
   }
   
   // 대댓글 등록 처리용
   @RequestMapping(value = "freerepinsert2.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freeRepInsert2Method(Free free, Model model) {
      if (freeService.insertReple2(free) > 0) {
         return "redirect:freedetail.do?free_no=" + free.getFree_ref();
      } else {
         model.addAttribute("message", "대댓글 등록 실패!");
         return "common/error";
      }
   }

   // 댓글 등록페이지 이동
   @RequestMapping(value = "movefreerepin.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String moveFreeRepForm(@RequestParam("free_no") int free_ref, Model model) {
      model.addAttribute("free_ref", free_ref);
      return "free/freeRepForm";
   }

   // 댓글 등록 처리용
   @RequestMapping(value = "freerepinsert.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freeRepInsertMethod(Free free, Model model) {
      if (freeService.insertReple(free) > 0) {
         return "redirect:freedetail.do?free_no=" + free.getFree_ref();
      } else {
         model.addAttribute("message", "댓글 등록 실패!");
         return "common/error";
      }
   }

   // 댓글,대댓글 삭제 처리용
   @RequestMapping(value = "freerepdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freeRepDeleteMethod(@RequestParam("freeno") int freeno, Free free, Model model) {
      if (freeService.deleteReple(free) > 0) {
         return "redirect:freedetail.do?free_no=" + freeno;
      } else {
         model.addAttribute("message", "게시글 삭제 실패!");
         return "common/error";
      }
   }

   // 원글 수정페이지 이동
   @RequestMapping(value = "freeupmove.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String moveFreeUpdateForm(@RequestParam("free_no") int free_no, Model model) {
      Free free = freeService.selectBoard(free_no);

      if (free != null) {
         if(free.getOriginfile_free() != null) {
            String[] ofiles = free.getOriginfile_free().split(" ");
            String[] rfiles = free.getRenamefile_free().split(" ");
            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
            model.addAttribute("ofile", ofile);
            model.addAttribute("rfile", rfile);
         }
         model.addAttribute("free", free);
         return "free/freeUpdateForm";
      } else {
         model.addAttribute("message", free_no + "번 글 수정페이지로 이동 실패!");
         return "common/error";
      }
   }

   // 원글 삭제 처리용
   @RequestMapping(value = "freedelete.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freedeleteMethod(@RequestParam("free_no") int free_no, Model model) {
      if (freeService.deleteFreeBoard(free_no) > 0) {
         return "redirect:commu.do";
      } else {
         model.addAttribute("message", "게시글 삭제 실패!");
         return "common/error";
      }
   }

   // 게시글 상세보기 처리용
   @RequestMapping(value = "freedetail.do", method = { RequestMethod.GET, RequestMethod.POST })
   public ModelAndView boardDetailMethod(ModelAndView mv, @RequestParam("free_no") int free_no,
         @RequestParam(name = "user_id", required = false) String user_id,
         @RequestParam(name = "page", required = false) String page) {
      int currentPage = 1;
      if (page != null) {
         currentPage = Integer.parseInt(page);
      }

      // 조회수 1 증가 처리
      freeService.updateBoardReadcount(free_no);

      // 해당 게시글 조회
      ArrayList<Free> list = freeService.selectRepleList(free_no);
      Free free = freeService.selectBoard(free_no);
      Free free2 = new Free();
      free2.setUser_id(user_id);
      free2.setFree_no(free_no);
      
      LikeFree likeFree =   freeService.selectLikeFree(free2);
      
      if (list != null) {
         mv.addObject("list", list);
      }
      
      if(likeFree != null) {
         mv.addObject("likeFree", likeFree);
      }

      if (free != null) {
         if(free.getOriginfile_free() != null) {
            String[] ofiles = free.getOriginfile_free().split(" ");
            String[] rfiles = free.getRenamefile_free().split(" ");
            List<String> ofile = new ArrayList<String>(Arrays.asList(ofiles));
            List<String> rfile = new ArrayList<String>(Arrays.asList(rfiles));
            mv.addObject("ofile", ofile);
            mv.addObject("rfile", rfile);
         }
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
   @RequestMapping(value = "freedown.do", method = { RequestMethod.GET, RequestMethod.POST })
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
         @RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

      // 첨부파일 저장 폴더 경로 지정
      String savePath = request.getSession().getServletContext().getRealPath("resources/free_upfiles");
      
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
         free.setOriginfile_free(originfile.trim());
         free.setRenamefile_free(renamefile.trim());
      } // 새로운 첨부파일이 있을 때

      if (freeService.insertBoard(free) > 0) {
         // 공지글 수정 성공시 목록 보기 페이지로 이동
         return "redirect:commu.do";
      } else {
         model.addAttribute("message", "게시글 등록 실패!");
         return "common/error";
      }
   }

   // 게시원글 수정 요청 처리용 (파일 업로드 기능 사용)
   @RequestMapping(value = "freeupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String boardUpdateMethod(Free free, Model model, HttpServletRequest request,
         @RequestParam(name = "upfile", required = false) ArrayList<MultipartFile> mfiles) {

      // 게시원글 첨부파일 저장 폴더 경로 지정
      String savePath = request.getSession().getServletContext().getRealPath("resources/free_upfiles");
      String originfile = "";
      String renamefile = "";
      String[] ofiles = free.getOriginfile_free().split(" ");
      String[] rfiles = free.getRenamefile_free().split(" ");
      String[] delFlag = request.getParameterValues("delflag");
      
      // 첨부파일이 수정 처리된 경우 ---------------------------
      // 1. 원래 첨부파일이 있는데 '파일삭제'를 선택한 경우
      if (free.getRenamefile_free() != null && delFlag != null) {
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
         
         free.setOriginfile_free(originfile.trim());
         free.setRenamefile_free(renamefile.trim());
      }
      
      for(int i = 0; i < mfiles.size(); i++) {
         // 2.새로운 첨부파일이 있을때
         if (!mfiles.get(i).isEmpty()) {
            // 2-1. 이전 첨부파일이 있을 때
            if (free.getRenamefile_free() != null) {
               // 저장 폴더에 있는 이전 파일을 삭제함
               new File(savePath + "/" + free.getRenamefile_free()).delete();
               //이전 파일 정보도 제거함
               free.setOriginfile_free(null);
               free.setRenamefile_free(null);
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
                  //free.setOriginfile_free(fileName);
                  //free.setRenamefile_free(renameFileName);
                  originfile += fileName + " ";
                  renamefile += renameFileName + " ";
               } // 이름바꾸기
               free.setOriginfile_free(originfile.trim());
               free.setRenamefile_free(renamefile.trim());
            }
            // 객체에 첨부파일 정보 기록 저장
         }
      

      if (freeService.updateBoard(free) > 0) {
         // 게시원글 수정 성공시 상세보기 페이지로 이동
         model.addAttribute("free_no", free.getFree_no());

         return "redirect:freedetail.do";
      } else {
         model.addAttribute("message", free.getFree_no() + "번 게시글 수정 실패!");
         return "common/error";
      }
   }

   // top5
   @RequestMapping(value = "ftop5.do", method = { RequestMethod.GET, RequestMethod.POST })
   @ResponseBody
   public String freeNewTop5Method() throws UnsupportedEncodingException {
      ArrayList<Free> list = freeService.selectTop5();
      logger.info("ftop5.do : " + list.size());

      JSONObject sendJson = new JSONObject();
      JSONArray jarr = new JSONArray();

      for (Free free : list) {
         JSONObject job = new JSONObject();

         job.put("free_no", free.getFree_no());
         job.put("free_name", URLEncoder.encode(free.getFree_name(), "utf-8"));
         job.put("write_free_date", free.getWrite_free_date().toString());
         job.put("user_id", free.getUser_id());
         job.put("click_free_no", free.getClick_free_no());
         jarr.add(job);
      }
      sendJson.put("list", jarr);
      return sendJson.toJSONString();
   }

   // 리스트
   @RequestMapping(value = "commu.do", method = { RequestMethod.GET, RequestMethod.POST })
   @ResponseBody
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
   //검색
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
      }
      
      if(mv.isEmpty()) {
         mv.addObject("searchs", searchs);
         mv.setViewName("free/freeListView2");
         return mv;
      }else {
         return mv;
      }
   }
}