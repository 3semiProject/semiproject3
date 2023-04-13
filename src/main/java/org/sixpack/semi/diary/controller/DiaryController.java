package org.sixpack.semi.diary.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.service.GoalService;
import org.sixpack.semi.goal.model.service.GoalServiceImpl;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("diaryController")
public class DiaryController {

    @Autowired
    private DiaryService diaryService;

    @Autowired
    private GoalService goalService;

    private static final Logger logger = LoggerFactory.getLogger(DiaryController.class);

    //ajax mainbox 캘린더
    @RequestMapping(value = "calendar.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String diaryCalendarMethod(@RequestParam("user_id") String user_id) throws UnsupportedEncodingException {
        ArrayList<Diary> list = diaryService.selectDiary(user_id);
        logger.info("calendar.do : " + list.size());

        JSONObject sendJson = new JSONObject();
        JSONArray jarr = new JSONArray();

        for (Diary diary : list) {
            JSONObject job = new JSONObject();
            job.put("diary_no", diary.getDiary_no());
            job.put("diary_category", diary.getDiary_category());
            job.put("diary_post_date", diary.getDiary_post_date().toString());
            jarr.add(job);
        }
        sendJson.put("list", jarr);
        return sendJson.toJSONString();
    }


    //main에서 다이어리화면 띄울때 목표정보 확인용
    @RequestMapping(value = "diary.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String showFirstDiary(RedirectAttributes redirect,
                                 HttpSession session) {
        if (session == null) {
            //비로그인 상태면 로그인 페이지로 이동
            return "redirect:loginPage.do";
        }
        //다이어리에 회원정보담기
        String user_id = ((Member) session.getAttribute("loginMember")).getUser_id();
        Date today = new Date(new java.util.Date().getTime());
        Diary diary = new Diary(user_id, today, 0, "eat", null, null);


        //다이어리 전환 전, 목표정보 있는지 확인
        Goal goal = diaryService.selectTodayGoal(diary); // 오늘 날짜 goal 조회
        System.out.println("goal : " + goal);

        if (goal == null) { //조회값이 없거나, 목표일이 끝났을때
            goal = diaryService.selectCurrentGoal(diary);

            if (goal != null) { // 기한 내 목표 있을 경우
                goalService.insertGoalInfo(goal);  // 목표 생성

            } else {
                goal = diaryService.selectlastGoal(diary);

                if (goal != null) {
                    redirect.addAttribute("isExist", "D"); // 기간 내 목표가 없을 시
                    redirect.addAttribute("goal", goal);  // 가장 최근 데이터에 목표기간만 한달 후인 데이터 넘김
                    return "redirect:diary_showGoal.do"; //목표작성화면으로 이동
                } else {
                    redirect.addAttribute("isExist", "N"); // 처음 가입시(목표 데이터 없을 시)
                    return "redirect:diary_showGoalModify.do"; //목표작성화면으로 이동
                }
            }
        }

        //목표정보 있으면 식단 다이어리화면으로 이동
        redirect.addFlashAttribute("diary", diary);
        return "redirect:diary_showEatDiary.do";
    }

    @RequestMapping("notExistGoal")
    public String notExistGoalMethod(
            RedirectAttributes redirect,
            HttpSession session
    ) {

        String user_id = ((Member) session.getAttribute("loginMember")).getUser_id();
        Date today = new Date(new java.util.Date().getTime());
        Diary diary = new Diary(user_id, today, 0, "eat", null, null);

        Goal goal = diaryService.selectlastGoal(diary);

        if (goal != null) {
            redirect.addAttribute("isExist", "D"); // 기간 내 목표가 없을 시
            redirect.addAttribute("goal", goal);  // 가장 최근 데이터에 목표기간만 한달 후인 데이터 넘김
            return "redirect:diary_showGoal.do"; //목표작성화면으로 이동
        } else {
            redirect.addAttribute("isExist", "N"); // 처음 가입시(목표 데이터 없을 시)
            return "redirect:diary_showGoalModify.do"; //목표작성화면으로 이동
        }

    }


    //다이어리 화면내 id, date, category 정보로 다이어리간 이동
    //수정 : diary_no로 이동
    //수정 : 날짜로 이동
    @RequestMapping(value = "diary_moveDiary.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String showMoveDiary(RedirectAttributes redirect, Diary diary,
                                HttpSession session) {

        //diary_no 있을때 바로이동
        Diary move = null;
        if (diary.getDiary_no() > 0) {
            move = diaryService.selectDiaryNo(diary.getDiary_no());
        } else {
            //date 없을때 현재날짜로
            if (diary.getDiary_post_date() == null) {
                diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
            }

            //id 없을때
            if (session == null) {
                //비로그인 상태면 로그인 페이지로 이동
                return "redirect:loginPage.do";
            } else {
                if (diary.getUser_id() == null) {
                    diary.setUser_id(((Member) session.getAttribute("loginMember")).getUser_id());
                }
            }

            //category 없을때 식단우선
            if (diary.getDiary_category() == null) {
                diary.setDiary_category("eat");
            }
            //입력정보와 일치하는 diary 있는지 조회
            if (!(diary.getUser_id() == null && diary.getDiary_post_date() == null && diary.getDiary_category() == null)) {
                move = diaryService.selectDiaryOne(diary);
            }
            //조회된 move 없으면 그냥 빈 식단화면 띄우기
            if (move == null) {
                logger.info("빈 식단화면 띄우기" + diary.toString());
                //diary.setDiary_post_date(java.sql.Date.valueOf("2023-03-01"));
                //diary.setUser_id("dd");
                //diary.setDiary_category("eat");
                move = diary;
            }
        }
        redirect.addFlashAttribute("diary", move);
        //카테고리별 컨트롤러 호출
        if (move.getDiary_category() == null ||
                move.getDiary_category().equals("eat")) {
            return "redirect:diary_showEatDiary.do";
        } else if (move.getDiary_category().equals("act")) {
            return "redirect:diary_showActDiary.do";
        } else {
            return "redirect:diary_showBodyDiary.do";
        }
    }

    //다이어리 작성용new (이미지처리) : 날짜 셋팅
    @RequestMapping(value = "diary_insertDiary.do", method = {RequestMethod.POST, RequestMethod.GET})
    public void insertEats(HttpServletRequest request,
                           HttpServletResponse response,
                           Diary diary,
                           @RequestParam String dateTime,
                           @RequestParam(name = "upfile", required = false) MultipartFile mfile
    ) throws ParseException, IOException {
        System.out.println("diary 저장시작");
        //sql날짜 설정 yyyy-MM-dd 형식
        //String sqldate = dateTime.substring(0, 10);
        //diary.setDiary_post_date(Date.valueOf(sqldate));
        System.out.println(dateTime);
        System.out.println(diary.getDiary_post_date());

        //1.이미지파일 저장처리
        String savePath = request.getSession().getServletContext().getRealPath("resources/diary_upfile");
        if (mfile != null && !mfile.isEmpty()) {
            String fileName = mfile.getOriginalFilename();
            System.out.println(diary.getDiary_post_date());

            if (fileName != null && fileName.length() > 0) {
                String renameFileName = FileNameChange.diaryChange(
                        diary.getDiary_no(), fileName);
                logger.info("첨부 파일명 확인 : " + fileName + ", " + renameFileName);

                try {
                    mfile.transferTo(new File(savePath + "\\" + renameFileName));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                diary.setDiary_image(renameFileName);
            } // 이름바꾸기
        } // 새로운 첨부파일이 있을 때
        logger.info(diary.toString());


        //2. 다이어리 저장, 날짜+시간 update
        if (diaryService.insertDiary(diary) > 0) {
            Diary timeDiary = new Diary();
            timeDiary.setDiary_no(diary.getDiary_no());
            timeDiary.setDiary_memo(dateTime);
            diaryService.updateDiaryTime(timeDiary);

            response.getWriter().append("ok").flush();
        } else {
            response.getWriter().append("fail").flush();
        }
    }

    //ajax 다이어리 작성 중복체크 : id, date, category
    @RequestMapping(value = "diary_checkDuplicateDiary.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody //뷰리졸버 통하지 않고 string반환
    public String checkDuplicateDiary(Model model, Diary diary) {
        Diary searchD = diaryService.selectDiaryOne(diary);
        if (searchD != null) { //다이어리 존재하면 다이어리번호 전달
            String no = String.valueOf(searchD.getDiary_no());
            return no;
        } else {
            System.out.println("Controller nope");
            return "ok";
        }
    }

//	//캘린더 출력용
//	@RequestMapping(value = "diary_showCalendar.do", method = RequestMethod.GET)
//	public String calendar(Model model, HttpServletRequest request, DateData dateData){
//		
//		Calendar cal = Calendar.getInstance();
//		DateData calendarData;
//		//검색 날짜
//		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
//			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
//		}
//		//검색 날짜 end
//
//		Map<String, Integer> today_info =  dateData.today_info(dateData);
//		List<DateData> dateList = new ArrayList<DateData>();
//		
//		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
//		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
//		for(int i=1; i<today_info.get("start"); i++){
//			calendarData= new DateData(null, null, null, null);
//			dateList.add(calendarData);
//		}
//		
//		//날짜 삽입
//		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
//			if(i==today_info.get("today")){
//				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
//			}else{
//				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
//			}
//			dateList.add(calendarData);
//		}
//
//		//달력 빈곳 빈 데이터로 삽입
//		int index = 7-dateList.size()%7;
//		
//		if(dateList.size()%7!=0){
//			
//			for (int i = 0; i < index; i++) {
//				calendarData= new DateData(null, null, null, null);
//				dateList.add(calendarData);
//			}
//		}
//		System.out.println(dateList);
//		
//		//배열에 담음
//		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
//		model.addAttribute("today_info", today_info);
//		return "views/diary/common/calendar";
//	}


//	@RequestMapping ("diary.do")
//	public String moveStatsMethod(){
//		return "diary/stats/actStats";
//	}


}//controller
