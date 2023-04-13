package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.stats.model.vo.ActChart;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.StatsDate;

import java.util.ArrayList;

//다이어리-운동정보
public interface StatsActService {

    //통계용 다이어리 조회

    // 추천운동 한개 조회
    ActRec selectRecAct(int rec_act_lev);

    ActStats actStatsTotal(StatsDate statsDate);

    ArrayList<ActChart> actChartList(StatsDate statsDate);
}
