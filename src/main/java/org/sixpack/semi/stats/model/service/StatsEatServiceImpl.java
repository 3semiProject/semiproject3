package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("StatsEatService")
public class StatsEatServiceImpl implements StatsEatService {

    @Autowired
    StatsDao statsDao;

    @Override
    public EatStats selectPeriodEat(Period period) {
        return null;
    }

    @Override
    public EatStats selectPeriodTop3Eat(Period period) {
        return null;
    }

    @Override
    public ArrayList<Graph> selectGraphEat(Period period) {
        return null;
    }

    @Override
    public EatStats eatStatsTotal(StatsDate statsDate) {
        return statsDao.eatStatsTotal(statsDate);
    }
}
