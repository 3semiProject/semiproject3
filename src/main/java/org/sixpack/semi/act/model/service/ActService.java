package org.sixpack.semi.act.model.service;

import java.util.ArrayList;

import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.Diary;

//다이어리-운동정보
public interface ActService {
	//하루치(=1개다이어리) 운동목록 조회
	ArrayList<Act> selectDayAct(Diary diary);	//다이어리 정보 조회
	//하루치 운동정보 합계 
	java.lang.Integer selectSumAct(Diary diary);
	
		//운동 한개 추가
	int insertOneAct(Act act);
	//수정시 운동 한개 수정
	int updateOneAct(Act act);
	//삭제시 해당다이어리의 운동 일괄삭제
	int deleteAllAct(Diary diaryno);
	//수정시 운동 한개 삭제
	int deleteOneAct(Act act);	
	
	//운동이름 조회
	Move selectMoveName(String move_name);
}
