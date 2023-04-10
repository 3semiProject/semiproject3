package org.sixpack.semi.stats.
        model.service;

import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.dao.StatsDao;
import org.sixpack.semi.stats.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("statsActServices")
public class StatsActServiceImpl implements StatsActService {
    @Autowired
    StatsDao statsDao;


    @Override
    public ActStats actStatsTotal(StatsDate statsDate) {
        return statsDao.actStatsTotal(statsDate);
    }


    @Override
    public ActRec selectRecAct(int rec_act_lev) {
        return statsDao.selectRecAct(rec_act_lev);
    }

    @Override
    public ArrayList<ActChart> actChartList(StatsDate statsDate) {
        return statsDao.actChartList(statsDate);
    }

}
