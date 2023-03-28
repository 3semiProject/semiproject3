package org.sixpack.semi.body.controller;

import org.sixpack.semi.diary.model.service.DiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("bodyCon")
public class BodyController {	
	
	@Autowired
	private DiaryService diaryService;
	
	//체형다이어리 화면출력용
	//diary 전달값은 없을 수 없음. 날짜라도 받아야함.
	@RequestMapping("diary_showBodyDiary.do")
	public String showBodyDiary() {
			return "diary/body/bodyDiary";
	}
	
	//체형다이어리 작성 화면출력용
	@RequestMapping("diary_showBodyWrite.do")
	public String showBodyWriteView() {
		return "diary/body/bodyWrite";
	}
	
	//체형다이어리 수정 화면출력용
	@RequestMapping("diary_showBodyModify.do")
	public String showBodyModifyView() {
			return "diary/body/bodyModify";			
	}
}
