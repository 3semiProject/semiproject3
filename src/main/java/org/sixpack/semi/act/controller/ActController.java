package org.sixpack.semi.act.controller;

import java.util.ArrayList;

import org.sixpack.semi.act.model.service.ActService;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("actCon")
public class ActController {

	@Autowired
	private ActService actService;
	@Autowired
	private DiaryService diaryService;
	//로그객체 생성구문 넣어야함

	//운동다이어리 화면출력용
	//diary 전달값은 없을 수 없음
	@RequestMapping("diary_showActDiary.do")
	public ModelAndView showActDiary(ModelAndView mv, Diary diary) {
		
		//다이어리 조회, 없어도 기본정보전달
		 //화면출력을 위한 memo,image
		Diary selectD = diaryService.selectOneDiary(diary);
		if(selectD !=null) {
			mv.addObject("diary", selectD);			
		}else {			
			mv.addObject("diary", diary);
		}
		
		//목표정보, 날짜정보 조회 없어도 내보냄, 빈칸출력
		Goal goal = diaryService.selectlastGoal(diary);//가장 최신 목표정보
		ArrayList<Diary> week = diaryService.selectWeekDiary(diary); // 일주일날짜에 대한 다이어리 정보
		mv.addObject("goal", goal);
		mv.addObject("week", week);
		
		//운동정보 조회 있을때만 내보냄
		ArrayList<Act> acts = actService.selectDayAct(diary);
		if(acts.size()>0) {
			mv.addObject("acts", acts);	 // 하루치 운동정보 목록
			//int sum = actService.selectSumAct(diary).intValue(); //오류 제외
			//mv.addObject("sum", sum);	 // 하루치 운동합계 : 오류 제외
		}
		
		
		mv.setViewName("diary/act/actDiary");
		return mv;			
	}
	
	//운동다이어리 작성 화면출력용
	@RequestMapping("diary_showActWrite.do")
	public String showActWriteView(ModelAndView mv,
			@RequestParam("diary")Diary diary) {
		//어떤날짜에 누가 작성할지를 전달받고 전달해야함
		mv.addObject("diary", diary);
		return "diary/act/actWrite";
	}
	
	//운동다이어리 수정 화면출력용
	@RequestMapping("diary_showActModify.do")
	public String showActModifyView(ModelAndView mv,
			@RequestParam("diary")Diary diary,
			ArrayList<Act> acts) {
		//diary 받아와서
		//원래 다이어리 정보 조회
		//acts 화면에 띄워야함
		acts = actService.selectDayAct(diary);
		
		if(acts !=null && acts.size()>0) {
			mv.addObject("diary", diary);
			mv.addObject("acts", acts);
			return "diary/act/actModify";			
		}else {
			mv.addObject("message","수정화면 다이어리 조회 실패");
			return "common/error";
		}
	}
	
	
	
	
	
	
	/*
	 * //운동이름 검색 ajax
	 * 
	 * @RequestMapping("diary_serarchMove.do") public String
	 * searchMovement(ModelAndView mv,
	 * 
	 * @RequestParam("move_name") String move_name, Move move, JSONObject sendJSON)
	 * {
	 * 
	 * move = actService.selectMoveName(move_name); sendJSON.put("move", move);
	 * return sendJSON.toJSONString(); }
	 */
	
	//운동작성 요청처리용
	@RequestMapping(value="diary_inertAct.do", method=RequestMethod.POST)
	public String writeActMethod(ModelAndView mv,
			@RequestParam("diary")Diary diary, 
			@RequestParam("acts")ArrayList<Act> acts){
		//작성될 날짜는 diary에 담아오기
		//diary 1개 생성 
		//생성된 다이어리 번호 불러오기
		int createdDiaryNo = 0;
		if(diaryService.insertDiary(diary) > 0) {
		diaryService.selectOneDiary(diary).getDiary_no();
		}
		//다이어리 번호 입력해서 act 여러개 생성
		int result = 0;
		for(Act a : acts) {
		a.setDiary_no(createdDiaryNo);
		result += actService.insertOneAct(a);
		}		
		
		if(result > 0) {
			//성공시 생성된 다이어리 화면 보여주기
			mv.addObject("diary",diary);
			return "redirect:diary_showActDiary.do";
		}else {
			mv.addObject("message","다이어리 생성 실패");
			return "common/error";
		}
		
	}
	
	//운동다이어리 삭제용
	@RequestMapping(value="diary_delAct.do", method=RequestMethod.POST)
	public String deleteActMethod(ModelAndView mv,
			@RequestParam("diary")Diary diary) {
		//삭제할 다이어리 정보를 받아와서 
		//다이어리 번호에 해당하는 act 먼저 삭제하고
		//diary도 삭제하고 결과값 받고
		//해당일의 다이어리 화면으로 돌아감
		
		int result = actService.deleteAllAct(diary);
		
		if(result > 0 && diaryService.deleteDiary(diary) > 0) {
			mv.addObject("diary",diary);
			return "redirect:diary_showActDiary.do";
		}else {
			mv.addObject("message","해당 다이어리 삭제 실패");
			return "common/error";			
		}
	}

	//운동다이어리 수정용
	@RequestMapping(value="diary_modifyAct.do", method=RequestMethod.POST)
	public String modifyActMethod(ModelAndView mv,
			@RequestParam("diary")Diary diary,
			@RequestParam("acts")ArrayList<Act> acts) {
		//수정할 다이어리 정보를 받아와서
		//기존 운동 갯수가 많았다면 삭제하고
		//acts 수정하고
		//diary의 내용도 수정하고 결과값 받고
		//해당일의 다이어리 화면으로 돌아감
		
		//해당일의 기존 운동을 조회
		//입력된 acts.size보다 많으면 뒤쪽 순번운동은 삭제
		ArrayList<Act> beforeActs = actService.selectDayAct(diary);
		int updateSize = acts.size();
		int beforeSize = beforeActs.size();

		if (beforeSize > updateSize) {
			int deleteCount = 0;
			for (int i = updateSize; i < beforeSize; i++) {
				deleteCount += actService.deleteOneAct(beforeActs.get(i));
			}
			// logger로 삭제한 행갯수 deleteCount 확인
			if ((beforeSize - updateSize) != deleteCount) {
				mv.addObject("message","기존 다이어리 삭제 실패");
				return "common/error";	
			}
		}
		
		int updateCount = 0;
		for(Act a : acts) {
			updateCount += actService.updateOneAct(a);
		}
		
		if(updateSize == updateCount && diaryService.deleteDiary(diary) > 0) {
			mv.addObject("diary",diary);
			return "redirect:diary_showActDiary.do";
		}else {
			mv.addObject("message","해당 다이어리 삭제 실패");
			return "common/error";			
		}
	}		
}