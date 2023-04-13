package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.BodyStats;
import org.sixpack.semi.stats.model.vo.StatsDate;

import java.util.ArrayList;

public interface StatsBodyService {
	
	//통계용 다이어리 조회

	BodyStats bodyStatsTotal(StatsDate statsDate);


	ArrayList<BodyChart> bodyChartList(StatsDate statsDate);
}
