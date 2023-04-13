package org.sixpack.semi.body.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.sixpack.semi.body.model.service.BodyService;
import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("bodyCon")
public class BodyController {

    @Autowired
    private DiaryService diaryService;
    @Autowired
    private BodyService bodyService;

    private static final Logger logger = LoggerFactory.getLogger(BodyController.class);

    //체형다이어리 화면출력용
    @RequestMapping(value = "diary_showBodyDiary.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String showBodyDiary(Model model, Diary diary, HttpSession session) {
        Diary move = null;

        //diary_no 있을때 바로이동
        if (diary.getDiary_no() > 0) {
            move = diaryService.selectDiaryNo(diary.getDiary_no());
        } else {
            //diary_no없을때 id, date, category로 조회
            if (diary.getUser_id() != null || diary.getDiary_post_date() != null || diary.getDiary_category() != null) {
                move = diaryService.selectDiaryOne(diary);
            }
            //id 없을때 비로그인 상태면 로그인 페이지로 이동
            if (session == null || session.getAttribute("loginMember") == null) {
                return "redirect:loginPage.do";
            } else {
                String id = ((Member) session.getAttribute("loginMember")).getUser_id();
                diary.setUser_id(id);
                diary.setUser_id("dd"); //test용
            }
            //date 없을때 현재날짜로
            if (diary.getDiary_post_date() == null) {
                diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
            }
            //category 없을때 식단우선
            if (diary.getDiary_category() == null) {
                diary.setDiary_category("eat");
            }
            //id, date, category 일치하는 diary 있는지 조회
            move = diaryService.selectDiaryOne(diary);

            //조회된 move 없으면 이전 다이이어리 정보 담기
            if (move == null) {
                logger.info("빈 운동화면 띄우기" + diary.toString());
                move = diary;
            }
        }

        model.addAttribute("diary", move);
        //목표정보, 날짜정보 조회
        Goal goal = diaryService.selectlastGoal(move);//가장 최신 목표정보
        ArrayList<Diary> week = diaryService.selectWeekDiary(move); // 일주일날짜에 대한 다이어리 정보
        if (goal != null && week != null) {
            model.addAttribute("goal", goal);
            model.addAttribute("week", week);
        }

        //체형정보 조회 있을때만 내보냄
        Body body = bodyService.selectOneBody(move);
        Body compare = bodyService.selectCompareBody(move);
        if (body != null && compare != null) {

            model.addAttribute("body", body);
            model.addAttribute("compare", compare);
        }
        return "diary/body/bodyDiary";
    }

    //체형다이어리 작성 화면출력용
    @RequestMapping("diary_showBodyWrite.do")
    public String showBodyWriteView(Model model, Diary diary, RedirectAttributes redirect,
                                    HttpSession session) {
        //이전다이어리 존재하면 수정화면으로 이동(act, body)
        Diary before = null;
        //diary_no로 회원정보 조회
        if (diary.getDiary_no() > 0) {
            diary = diaryService.selectDiaryNo(diary.getDiary_no());
        } else {
            //id 없을때
            if (session == null) {
                //비로그인 상태면 로그인 페이지로 이동
                //return "redirect:loginPage.do";
                diary.setUser_id("dd"); //test용
            } else {
                String id = ((Member) session.getAttribute("loginMember")).getUser_id();
                diary.setUser_id(id);
            }
            //date 없을때 현재날짜로
            if (diary.getDiary_post_date() == null) {
                Date today = new Date(new java.util.Date().getTime());
                //today =java.sql.Date.valueOf("2023-03-01"); //test용
                diary.setDiary_post_date(today);
            }
            //category 없을때
            if (diary.getDiary_category() == null) {
                diary.setDiary_category("eat");
            }
            //id, date, category 일치하는 diary 있는지 조회
            if (!(diary.getUser_id() == null && diary.getDiary_post_date() == null && diary.getDiary_category() == null)) {
                before = diaryService.selectDiaryOne(diary);
            }
            //이전다이어리 존재하면 수정화면으로 이동(act, body)
            if (before != null) {
                model.addAttribute("diary", before);


                return "redirect:diary_showBodyModify.do";
            }
        }
        ////작성할 새 다이어리번호 전달
        //diary.setDiary_no(diaryService.getDiaryNo());
        model.addAttribute("diary", diary);
        return "diary/body/bodyWrite";
    }

    //체형다이어리 수정 화면출력용
    @RequestMapping("diary_showBodyModify.do")
    public String showBodyModifyView(
            Model model,
            @RequestParam int diary_no) {


        Diary diary;
        Body body;
        //diary_no로 회원정보 조회
        if (diary_no > 0) {
            diary = diaryService.selectDiaryNo(diary_no);
            body = bodyService.selectBody(diary_no);

            model.addAttribute("diary", diary);
            model.addAttribute("body", body);

            return "diary/body/bodyModify";
        } else {
            model.addAttribute("message", "체형정보 수정페이지 오류");
            return "common/error";
        }
    }

    //체형다이어리 작성처리용 (이미지처리)
    @RequestMapping(value = "diary_insertBodyWrite.do", method = RequestMethod.POST)
    public String insertBodyWrite(RedirectAttributes redirect,
                                  HttpServletRequest request,
                                  Diary diary, Body body,
                                  @RequestParam(name = "upfile", required = false) MultipartFile mfile,
                                  Model model) throws ParseException {
        //작성할 새 다이어리번호
        int diary_no = diaryService.getDiaryNo();
        diary.setDiary_no(diary_no);
        body.setDiary_no(diary_no);

        diary.setDiary_category("body");

        //날짜 설정
        body.setBody_post_date(diary.getDiary_post_date());
        //이미지파일 저장처리
        // 첨부파일 저장 폴더 경로 지정
        String savePath = request.getSession().getServletContext().getRealPath("resources/diary_upfile");

        // 첨부파일이 있을때
        if (mfile != null && !mfile.isEmpty()) {
            // 전송온 파일이름 추출함
            String fileName = mfile.getOriginalFilename();
            System.out.println(diary.getDiary_post_date());
            // 다른 공지글의 첨부파일과 파일명이 중복되어서
            // 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
            // 폴더에 저장하는 방식을 사용할 수 있음
            // 변경 파일명 : 년월일시분초.확장자
            if (fileName != null && fileName.length() > 0) {
                // 바꿀 파일명에 대한 문자열 만들기
                String renameFileName = FileNameChange.diaryChange(
                        diary.getDiary_no(), fileName);

                logger.info("첨부 파일명 확인 : " + fileName + ", " + renameFileName);

                // 폴더에 저장 처리
                try {
                    mfile.transferTo(new File(savePath + "/" + renameFileName));
                } catch (Exception e) {
                    e.printStackTrace();

                }

                //저장 성공하면 diary 객체에 첨부파일 정보 기록 저장
                diary.setDiary_image(renameFileName);
            } // 이름바꾸기
        } // 새로운 첨부파일이 있을 때
        logger.info(diary.toString());

        //다이어리 작성실패 시
        if (diaryService.insertDiary(diary) == 0) {
            model.addAttribute("message", "다이어리 작성 실패");
            return "common/error";
        }

        //체중입력값 있을때만 저장 :diary는 존재하되, 체중0인 body는 존재하지 않게
        if (body.getBody_weight() > 0) {
            if (bodyService.insertBody(body) == 0) {
                model.addAttribute("message", "체형정보 작성 실패");
                return "common/error";
            }
        }

        redirect.addAttribute("diary_no", diary.getDiary_no());
        return "redirect:diary_showBodyDiary.do";
    }


    @RequestMapping(value = "diary_updateBodyModify.do", method = RequestMethod.POST)
    public String updateBodyWrite(RedirectAttributes redirect,
                                  HttpServletRequest request,

                                  Diary diary, Body body,
                                  @RequestParam(name = "upfile", required = false) MultipartFile mfile,
                                  @RequestParam(name = "userid") String user_id,
                                  @RequestParam(name = "diaryno") int diary_no,
                                  Model model) throws ParseException {

        //이미지파일 저장처리
        // 첨부파일 저장 폴더 경로 지정
        String savePath = request.getSession().getServletContext().getRealPath("resources/diary_upfile");

        diary.setUser_id(user_id);
        diary.setDiary_no(diary_no);
        body.setUser_id(user_id);
        body.setDiary_no(diary_no);

        // 첨부파일이 있을때
        if (mfile != null && !mfile.isEmpty()) {
            // 전송온 파일이름 추출함
            String fileName = mfile.getOriginalFilename();
            System.out.println(diary.getDiary_post_date());
            // 다른 공지글의 첨부파일과 파일명이 중복되어서
            // 덮어쓰기 되는것을 막기 위해, 파일명을 변경해서
            // 폴더에 저장하는 방식을 사용할 수 있음
            // 변경 파일명 : 년월일시분초.확장자
            if (fileName != null && fileName.length() > 0) {
                // 바꿀 파일명에 대한 문자열 만들기
                String renameFileName = FileNameChange.diaryChange(
                        diary.getDiary_no(), fileName);

                logger.info("첨부 파일명 확인 : " + fileName + ", " + renameFileName);

                // 폴더에 저장 처리
                try {
                    mfile.transferTo(new File(savePath + "/" + renameFileName));
                } catch (Exception e) {
                    e.printStackTrace();

                }

                //저장 성공하면 diary 객체에 첨부파일 정보 기록 저장
                diary.setDiary_image(renameFileName);
            } // 이름바꾸기
        } // 새로운 첨부파일이 있을 때
        else diary.setDiary_image(diaryService.selectDiaryNo(diary_no).getDiary_image());


        logger.info(diary.toString());

        //다이어리 작성실패 시

        if (diaryService.updateDiary(diary) == 0) {
            model.addAttribute("message", "다이어리 작성 실패");
            return "common/error";
        }

        //체중입력값 있을때만 저장 :diary는 존재하되, 체중0인 body는 존재하지 않게
        if (body.getBody_weight() > 0) {
            if (bodyService.updateBody(body) == 0) {
                model.addAttribute("message", "체형정보 작성 실패");
                return "common/error";
            }
        }

        redirect.addAttribute("diary_no", diary.getDiary_no());
        return "redirect:diary_showBodyDiary.do";
    }

}
