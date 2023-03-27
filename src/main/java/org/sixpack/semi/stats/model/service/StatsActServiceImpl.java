package org.sixpack.semi.stats.model.service;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.Graph;

import java.util.ArrayList;

public class StatsActServiceImpl implements StatsActService{
    StatsDao statsDao = new StatsDao();
    @Override
    public ActStats selectPeriodAct(Period period) {
        return null;
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
