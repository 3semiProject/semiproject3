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

        return actStats;
    }

    public EatStats eatStatsTotal(StatsDate statsDate) {

        EatStats eatStats = new EatStats();


        EatStats eatAvg = session.selectOne("eatStatsMapper.avgKcal", statsDate);
        eatStats.setAvg_eat(eatAvg.getAvg_eat());
        eatStats.setTan_g(eatAvg.getTan_g());
        eatStats.setDan_g(eatAvg.getDan_g());
        eatStats.setZi_g(eatAvg.getZi_g());

        eatStats.setRec_eat( (int)(session.selectOne("eatStatsMapper.setRec_eat", statsDate)));
        eatStats.setContrast_eat(eatStats.getRec_eat() - eatStats.getAvg_eat());
        eatStats.setMany_food(session.selectOne("eatStatsMapper.eatMaxDay", statsDate));
        eatStats.setMaxKcal_food(session.selectOne("eatStatsMapper.eatMaxKcal", statsDate));

        return eatStats;
    }
}
