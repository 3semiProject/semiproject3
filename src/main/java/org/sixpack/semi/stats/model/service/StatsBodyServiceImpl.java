package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.BodyStats;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("statsBodyService")
public class StatsBodyServiceImpl implements StatsBodyService {


    @Autowired
    StatsDao statsDao;

    @Override
    public BodyStats bodyStatsTotal(StatsDate statsDate) {
        return statsDao.bodyStatsTotal(statsDate);
    }

    @Override
    public ArrayList<BodyChart> bodyChartList(StatsDate statsDate) {
        return statsDao.bodyChartList(statsDate);
    }
}
