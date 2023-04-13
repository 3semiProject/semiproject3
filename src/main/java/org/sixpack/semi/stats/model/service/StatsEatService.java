package org.sixpack.semi.stats.model.service;


import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.StatsDate;

import java.util.ArrayList;

public interface StatsEatService {	
	
	//통계보기용 조회

	EatStats eatStatsTotal(StatsDate statsDate);

	ArrayList<EatStats> eatChartList(StatsDate statsDate);
}
