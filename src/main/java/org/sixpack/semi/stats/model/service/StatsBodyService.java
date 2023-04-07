package org.sixpack.semi.stats.model.service;

import java.util.ArrayList;

import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.BodyStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.sixpack.semi.stats.model.vo.StatsDate;

public interface StatsBodyService {
	
	//통계용 다이어리 조회

	BodyStats bodyStatsTotal(StatsDate statsDate);


	ArrayList<BodyChart> bodyChartList(StatsDate statsDate);
}
