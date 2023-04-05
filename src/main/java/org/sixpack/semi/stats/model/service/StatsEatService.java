package org.sixpack.semi.stats.model.service;

import java.util.ArrayList;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.sixpack.semi.stats.model.vo.StatsDate;

public interface StatsEatService {	
	
	//통계보기용 조회
	EatStats selectPeriodEat(Period period);
	EatStats selectPeriodTop3Eat(Period period);
	ArrayList<Graph> selectGraphEat(Period period);

	EatStats eatStatsTotal(StatsDate statsDate);
}
