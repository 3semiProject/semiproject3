package org.sixpack.semi.stats.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("statsDao")
public class StatsDao {

    @Autowired
    private SqlSessionTemplate session; //의존성 주입됨(DI)


    public ActRec selectRecAct(int recActLev) {
        return session.selectOne("actStatsMapper.actRec", recActLev);
    }

    public ActStats selectActStatsTotal(StatsDate statsDate) {
        ActStats actStats = new ActStats();

        ActStats actTotal = session.selectOne("actStatsMapper.actTotal", statsDate);
        System.out.println(actTotal);
        List<Integer> actIntensity = session.selectList("actStatsMapper.actIntensity", statsDate);
        actStats.setTot_act_val(actTotal.getTot_act_val());
        actStats.setTot_act_time(actTotal.getTot_act_time());
        actStats.setAvg_act_one(actTotal.getAvg_act_one());
        actStats.setTot_weak_time(actIntensity.get(0));
        actStats.setTot_middle_time(actIntensity.get(1));
        actStats.setTot_strong_time(actIntensity.get(2));
        actStats.setMaxDay_actName(session.selectOne("actStatsMapper.actMaxDay", statsDate));
        actStats.setMaxKcal_actName(session.selectOne("actStatsMapper.actMaxKcal", statsDate));
        actStats.setMaxTime_actName(session.selectOne("actStatsMapper.actMaxTime", statsDate));

        System.out.println(actStats);

        return actStats;
    }

    public EatStats eatStatsTotal(StatsDate statsDate) {
        EatStats eatStats = new EatStats();

        eatStats.setAvg_eat((int)session.selectOne("eatStatsMapper.avgKcal", statsDate));
        eatStats.setRec_eat((int)session.selectOne("eatStatsMapper.setRec_eat", statsDate));

//        EatStats avgKcal =
//        System.out.println(avgKcal);
//
//        List<Double> actIntensity = session.selectList("eatStatsMapper.actIntensity", statsDate);
//
//        eatStats.setTot_weak_time(actIntensity.get(0));
//        eatStats.setTot_middle_time(actIntensity.get(1));
//        eatStats.setTot_strong_time(actIntensity.get(2));
//        eatStats.setMaxDay_actName(session.selectOne("eatStatsMapper.actMaxDay", statsDate));
//        eatStats.setMaxKcal_actName(session.selectOne("eatStatsMapper.actMaxKcal", statsDate));
//        eatStats.setMaxTime_actName(session.selectOne("eatStatsMapper.actMaxTime", statsDate));
//
//        System.out.println(eatTotal);

        return eatStats;
    }
}
