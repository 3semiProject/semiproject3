package org.sixpack.semi.diary.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.sixpack.semi.common.FileNameChange;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.DateData;
import org.sixpack.semi.diary.model.vo.Diary;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("diaryCon")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	private static final Logger logger = LoggerFactory.getLogger(DiaryController.class);
	
	//ajax mainbox 캘린더
	@RequestMapping(value = "calendar.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String diaryCalendarMethod(@RequestParam("user_id") String user_id) throws UnsupportedEncodingException {
		ArrayList<Diary> list = diaryService.selectDiary(user_id);
		logger.info("calendar.do : " + list.size());

		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();

		for (Diary diary : list) {
			JSONObject job = new JSONObject();

			job.put("diary_no", diary.getDiary_no());
			job.put("diary_post_date", diary.getDiary_post_date().toString());
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	
	//main에서 다이어리화면 띄울때 목표정보 확인용
	@RequestMapping(value="diary.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String showFirstDiary( RedirectAttributes redirect,
			HttpSession session) {
		if(session==null) {
			//비로그인 상태면 로그인 페이지로 이동
			return "redirect:loginPage.do";	
		}
		//다이어리에 회원정보담기
		String user_id = ((Member)session.getAttribute("loginMember")).getUser_id();
		Date today = new Date(new java.util.Date().getTime());
		Diary diary= new Diary(user_id, today, 0, "eat", null, null );
		
		

		//다이어리 전환 전, 목표정보 있는지 확인
		//목표관리페이지 아직 미완성
		 //Goal goal=null;
		 //goal= diaryService.selectCurrentGoal(diary); //1달이내 정보조회
		 //if(goal==null || goal.getGoal_date().before(today)) { //조회값이 없거나, 목표일이 끝났을때
		 //redirect.addFlashAttribute("diary", diary);
		 //redirect.addFlashAttribute("message", "목표정보가 없습니다. 목표를 설정해주세요"); 
		 //return "redirect:diary_showGoalWrite.do"; //목표작성화면으로 이동
		//}
		
		//목표정보 있으면 식단 다이어리화면으로 이동
		redirect.addFlashAttribute("diary", diary);
		return "redirect:diary_showEatDiary.do";
	}
	
	//다이어리 화면내 id, date, category 정보로 다이어리간 이동
	//수정 : diary_no로 이동
	//수정 : 날짜로 이동
	@RequestMapping(value="diary_moveDiary.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String showMoveDiary( RedirectAttributes redirect, Diary diary,
			HttpSession session) {
		
		//diary_no 있을때 바로이동
		Diary move = null;
		if(diary.getDiary_no()>0) {
			move = diaryService.selectDiaryNo(diary.getDiary_no());
		}else {
			//date 없을때 현재날짜로
			if(diary.getDiary_post_date()==null) {
				diary.setDiary_post_date(new Date(new java.util.Date().getTime()));
			}
			
			//id 없을때
			if(session==null) {
				//비로그인 상태면 로그인 페이지로 이동
				return "redirect:loginPage.do";	
			}else {
				if(diary.getUser_id()==null) {
					diary.setUser_id(((Member)session.getAttribute("loginMember")).getUser_id());
				}
			}
			
			//category 없을때 식단우선
			if(diary.getDiary_category()==null) {
				diary.setDiary_category("eat");
			}			
			//입력정보와 일치하는 diary 있는지 조회
			if(!(diary.getUser_id()==null&& diary.getDiary_post_date()==null&&diary.getDiary_category()==null)) {
				move = diaryService.selectDiaryOne(diary);			
			}
			//조회된 move 없으면 그냥 빈 식단화면 띄우기
			if(move ==null) {
				logger.info("빈 식단화면 띄우기"+ diary.toString());
				//diary.setDiary_post_date(java.sql.Date.valueOf("2023-03-01"));
				//diary.setUser_id("dd");
				//diary.setDiary_category("eat");				
				move=diary;
			}
		}
		redirect.addFlashAttribute("diary", move);	
		//카테고리별 컨트롤러 호출
		if(move.getDiary_category()==null || 
				move.getDiary_category().equals("eat")){
			return "redirect:diary_showEatDiary.do";
		}else if(move.getDiary_category().equals("act")){
			return "redirect:diary_showActDiary.do";
		}else{
			return "redirect:diary_showBodyDiary.do";
		}
	}
	
	//ajax 다이어리 등록 요청 처리용(파일 업로드 기능 사용)
	@RequestMapping(value = "diary_insertWrite.do", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void insertEatWrite(
	        @ModelAttribute("diary") Diary diary,
	        @RequestParam(name = "time") String time,
	        @RequestParam(name = "upfile", required = false) MultipartFile mfile,
	        Model model, HttpServletRequest request) throws ParseException {

		//날짜포맷팅
		// 입력받은 시간 문자열
		//String timeStr = "13:45";
		// 시간과 분을 추출하여 배열로 저장
		String[] timeParts = time.split(":");
		// 추출한 시간과 분을 각각 int 타입으로 변환
		int hour = Integer.parseInt(timeParts[0]);
		int minute = Integer.parseInt(timeParts[1]);
		// 현재 날짜를 java.sql.Date 형식으로 생성
		java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
		// 시간과 분을 java.sql.Time 형식으로 생성
		java.sql.Time newtime = new java.sql.Time(hour, minute, 0);
		// java.sql.Date와 java.sql.Time을 합쳐서 java.util.Date 객체를 생성
		java.util.Date dateTime = new java.util.Date(currentDate.getTime() + newtime.getTime());
		// java.util.Date를 java.sql.Date로 변환
		java.sql.Date resultDate = new java.sql.Date(dateTime.getTime());
	    
		diary.setDiary_post_date(resultDate);
		
		
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
						mfile.transferTo(new File(savePath + "\\" + renameFileName));
					} catch (Exception e) {
						e.printStackTrace();
						
					}

					//저장 성공하면 diary 객체에 첨부파일 정보 기록 저장
					diary.setDiary_image(renameFileName);
				} // 이름바꾸기
			} // 새로운 첨부파일이 있을 때
			
			//다이어리 생성
				diaryService.insertDiary(diary);
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
