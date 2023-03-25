package org.sixpack.semi.notice.controller;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.notice.model.service.NoticeService;
import org.sixpack.semi.notice.model.vo.Notice;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@Controller
public class NoticeController {
    private static final Logger logger =
            LoggerFactory.getLogger(NoticeController.class);
    @Autowired
    private NoticeService noticeService;


    @RequestMapping(value = "ntop5.do", method = RequestMethod.POST)
    @ResponseBody
    public String noticeTop5Method() {

        ArrayList<Notice> list = noticeService.selectNewTop5();
        logger.info("ntop5.do : " + list.size());

        JSONObject sendJson = new JSONObject();
        JSONArray jarr = new JSONArray();

        for (Notice notice : list) {
            {
                JSONObject job = new JSONObject();
                job.put("noticeno", notice.getNoticeno());
                job.put("noticetitle", URLEncoder.encode(notice.getNoticetitle(), StandardCharsets.UTF_8));
                job.put("noticedate", notice.getNoticedate().toString());
                jarr.add(job);
            }
        }
        sendJson.put("list", jarr);
        return sendJson.toJSONString();
    }


    @RequestMapping("nlist.do")
    public String noticeListMethod(Model model) {
        ArrayList<Notice> list = noticeService.selectAll();
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "notice/noticeListView";
        } else {
            model.addAttribute("massage", "등록된 공지사항 정보가 없습니다.");
            return "common/error";
        }
    }


    @RequestMapping("ndetail.do")
    public String noticeDetailMethod(
            @RequestParam("noticeno") int noticeno, Model model, HttpSession session) {

        Notice notice = noticeService.selectNotice(noticeno);
        if (notice != null) {
            model.addAttribute("notice", notice);
            if (session.getAttribute("loginMember") != null) {
                Member loginMember = (Member) session.getAttribute("loginMember");
                if (loginMember.getAdmin().equals("Y")) {
                    return "notice/noticeAdminDetailView";
                }
            }
            return "notice/noticeDetailView";
        } else {
            model.addAttribute("message", "공지글이 없습니다.");
            return "common/error";
        }
    }


    @RequestMapping(value = "nsearchTitle.do", method = RequestMethod.POST)
    public String noticeSearchTitleMethod(
            @RequestParam("keyword") String keyword, Model model) {
        logger.info("아아아");
        ArrayList<Notice> list = noticeService.selectSearchTitle(keyword);
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "notice/noticeListView";
        } else {
            model.addAttribute("message", keyword + " 로 검색된 공지글 정보가 없습니다.");
            return "common/error";
        }
    }

    @RequestMapping(value = "nsearchWriter.do", method = RequestMethod.POST)
    public String noticeSearchWriterMethod(
            @RequestParam("keyword") String keyword, Model model) {
        ArrayList<Notice> list = noticeService.selectSearchWriter(keyword);
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "notice/noticeListView";
        } else {
            model.addAttribute("message", keyword + " 로 검색된 공지글 정보가 없습니다.");
            return "common/error";
        }

    }

    @RequestMapping(value = "nsearchDate.do", method = RequestMethod.POST)
    public String noticeSearchDateMethod(
            SearchDate date, Model model) {
        ArrayList<Notice> list = noticeService.selectSearchDate(date);
        if (list != null && list.size() > 0) {
            model.addAttribute("list", list);
            return "notice/noticeListView";
        } else {
            model.addAttribute("message", "해당 날짜 공지글 정보가 없습니다.");
            return "common/error";
        }
    }


    //첨부파일 다운로드 요청 처리용
    @RequestMapping("nfdown.do")
    public ModelAndView noticeDownloadMethod(
            ModelAndView mv, HttpServletRequest request,
            @RequestParam("ofile") String originalFileName,
            @RequestParam("rfile") String renameFileName) {
        // 공지사항 첨부파일 저장폴더에 대한 경로 지정
        String savePath = request.getSession().getServletContext()
                .getRealPath("resources/notice_upfiles");

        // 저장 폴더에서 읽을 파일 객체 생성함
        File renameFile = new File(savePath + File.separator + renameFileName);
        // 파일 다운로드시 내보낼 원래 이름의 파일 객체 생성
        File originFile = new File(originalFileName);

        // 파일 다운로드 뷰로 전달할 정보 저장
        mv.setViewName("filedown");  // 등록된 파일다운로드 뷰의 id명
        mv.addObject("renameFile", renameFile);
        mv.addObject("originFile", originFile);

        return mv;
    }


    @RequestMapping("nmoveup.do")
    public String noticeMoveUpdateMethod(
            @RequestParam("noticeno") int noticeno, Model model) {
        Notice notice = noticeService.selectNotice(noticeno);

        if (notice != null) {
            model.addAttribute("notice", notice);
            return "notice/noticeUpdateForm";
        } else {
            model.addAttribute("message", "공지글 수정페이지로 이동 실패");
            return "common/error";
        }
    }

    @RequestMapping(value = "nupdate.do", method = RequestMethod.POST)
    public String noticeUpdateMethod(
            Notice notice, Model model, HttpServletRequest request,
            @RequestParam(name = "delflag", required = false) String delflag,
            @RequestParam(name = "upfile", required = false) MultipartFile mfile) {

        String savePath = request.getSession().getServletContext().
                getRealPath("resources/notice_upfiles");

        // 첨부파일이 수정 처리된 경우
        if (notice.getOriginal_filepath() != null && delflag != null && delflag.equals("yes")) {
            // 저장 폴더에 있는 파일을 삭제함
            new File(savePath + File.separator + notice.getRename_filepath()).delete();
            notice.setOriginal_filepath(null);
            notice.setRename_filepath(null);
        }

        // 새로운 첨부파일이 있을 때
        if (!mfile.isEmpty()) {

            if (notice.getOriginal_filepath() != null) {
                // 저장 폴더에 있는 파일을 삭제함
                new File(savePath + File.separator + notice.getRename_filepath()).delete();
                notice.setOriginal_filepath(null);
                notice.setRename_filepath(null);
            }
            // 전송온 파일이름 추출 (다른 첨부파일과 중복되는것을 방지)
            String fileName = mfile.getOriginalFilename();

            // 변경 파일명 : 년월일시분초.확장자

            if (fileName != null && fileName.length() > 0) {
                // 바꿀 파일명에 대한 문자열 만들기
                // 공지글 등록 | 수정 요청시점의 날짜시간정보를 이용함
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                String renameFileName = sdf.format(
                        new java.sql.Date(System.currentTimeMillis()));
                logger.info(renameFileName);
                // 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
                renameFileName += fileName.substring(fileName.lastIndexOf("."));
                logger.info("변경 파일명 : " + renameFileName);

                // 파일 객체 만들기
                File renameFile = new File(savePath + File.separator + renameFileName);

                // 폴더에 저장 처리
                try {
                    mfile.transferTo(renameFile);
                } catch (IOException e) {
                    model.addAttribute("message", "첨부파일 저장 실패");
                    return "common/error";
                }

                notice.setOriginal_filepath(fileName);
                notice.setRename_filepath(renameFileName);
            } // 이름바꾸기
        } // 새로운 파일 있을 시

        logger.info("경로: " + savePath);
        if (noticeService.updateNotice(notice) > 0) {

            return "redirect:nlist.do";
        } else {

            model.addAttribute("message", notice.getNoticeno() + "번글 공지 수정 실패");
            return "common/error";
        }

    }


    @RequestMapping("ndelete.do")
    public String noticeDeleteMethod(
            @RequestParam("noticeno") int noticeno,
            @RequestParam(name = "rfile", required = false) String renameFileName,
            HttpServletRequest request,
            Model model) {

        if (noticeService.deleteNotice(noticeno) > 0) {
            if (renameFileName != null) {
                String savePath = request.getSession().getServletContext()
                        .getRealPath("resources/notice_upfiles");
                new File(savePath + File.separator + renameFileName).delete();
            }
            return "redirect:nlist.do";
        } else {
            model.addAttribute("message", noticeService+ "번 공지 삭제 실패");
            return "common/error";
        }
    }
    @RequestMapping("movewrite.do")
    public String noticeWriteMethod(){
        return "notice/noticeWriteForm";
    }


    @RequestMapping(value = "ninsert.do", method = RequestMethod.POST)
    public String noticeInsertMethod(
            Notice notice, Model model, HttpServletRequest request,
            @RequestParam(name = "delflag", required = false) String delflag,
            @RequestParam(name = "upfile", required = false) MultipartFile mfile) {

        String savePath = request.getSession().getServletContext().
                getRealPath("resources/notice_upfiles");

        // 첨부파일이 수정 처리된 경우
        if (notice.getOriginal_filepath()!=null) {
            // 저장 폴더에 있는 파일을 삭제함
            new File(savePath + File.separator + notice.getRename_filepath()).delete();
            notice.setOriginal_filepath(null);
            notice.setRename_filepath(null);
        }

        // 새로운 첨부파일이 있을 때
        if (!mfile.isEmpty()) {

            if (notice.getOriginal_filepath() != null) {
                // 저장 폴더에 있는 파일을 삭제함
                new File(savePath + File.separator + notice.getRename_filepath()).delete();
                notice.setOriginal_filepath(null);
                notice.setRename_filepath(null);
            }
            // 전송온 파일이름 추출 (다른 첨부파일과 중복되는것을 방지)
            String fileName = mfile.getOriginalFilename();

            // 변경 파일명 : 년월일시분초.확장자

            if (fileName != null && fileName.length() > 0) {
                // 바꿀 파일명에 대한 문자열 만들기
                // 공지글 등록 | 수정 요청시점의 날짜시간정보를 이용함
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                String renameFileName = sdf.format(
                        new java.sql.Date(System.currentTimeMillis()));
                logger.info(renameFileName);
                // 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
                renameFileName += fileName.substring(fileName.lastIndexOf("."));
                logger.info("변경 파일명 : " + renameFileName);

                // 파일 객체 만들기
                File renameFile = new File(savePath + File.separator + renameFileName);

                // 폴더에 저장 처리
                try {
                    mfile.transferTo(renameFile);
                } catch (IOException e) {
                    model.addAttribute("message", "첨부파일 저장 실패");
                    return "common/error";
                }
                // notice 객체에 첨부파일 정보 기록 저장
                notice.setOriginal_filepath(fileName);
                notice.setRename_filepath(renameFileName);
            } // 이름바꾸기
        } // 새로운 파일 있을 시


        if (noticeService.insertNotice(notice) > 0) {

            return "redirect:nlist.do";
        } else {

            model.addAttribute("message", "새 공지글 등록 실패");
            return "common/error";
        }

    }

}
