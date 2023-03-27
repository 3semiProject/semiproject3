package org.sixpack.semi.stats.model.service;

import java.util.ArrayList;

import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.Graph;

//다이어리-운동정보
public interface StatsActService {

	//통계용 다이어리 조회 
	ActStats selectPeriodAct(Period period);
	ActStats selectPeriodTop3Act(Period period);
	ArrayList<Graph> selectGraphAct(Period period);
	
	// 추천운동 한개 조회
	ActRec selectRecAct(String recCode); 

}
