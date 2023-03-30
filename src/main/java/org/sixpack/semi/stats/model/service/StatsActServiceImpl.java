package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("statsActServices")
public class StatsActServiceImpl implements StatsActService {
    @Autowired
    StatsDao statsDao;


    @Override
    public ActStats actStatsTotal(StatsDate statsDate) {
        return statsDao.selectActStatsTotal(statsDate);
    }

    @Override
    public ActStats selectPeriodTop3Act(Period period) {
        return null;
    }

    @Override
    public ArrayList<Graph> selectGraphAct(Period period) {
        return null;
    }

    @Override
    public ActRec selectRecAct(int rec_act_lev) {
        return statsDao.selectRecAct(rec_act_lev);
    }
}
