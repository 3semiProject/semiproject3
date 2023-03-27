package org.sixpack.semi.stats.model.service;

import java.util.ArrayList;

import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.vo.BodyStats;
import org.sixpack.semi.stats.model.vo.Graph;

public interface StatsBodyService {
	
	//통계용 다이어리 조회
	BodyStats selectPeriodBody(Period period);
	BodyStats selectPeriodTop3Body(Period period);
	ArrayList<Graph> selectGraphBody(Period period);
	

}
