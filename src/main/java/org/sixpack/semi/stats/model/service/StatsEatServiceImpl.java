package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("StatsEatService")
public class StatsEatServiceImpl implements StatsEatService {

    @Autowired
    StatsDao statsDao;

    @Override
    public ArrayList<EatStats> eatChartList(StatsDate statsDate) {
        return statsDao.eatChartList(statsDate);
    }

    @Override
    public EatStats eatStatsTotal(StatsDate statsDate) {
        return statsDao.eatStatsTotal(statsDate);
    }
}
