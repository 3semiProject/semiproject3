package org.sixpack.semi.stats.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
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
        return session.selectOne("statsMapper.actRec", recActLev);
    }

    public ActStats selectActStatsTotal(StatsDate statsDate) {
        ActStats actStats = new ActStats();

        ActStats actTotal = session.selectOne("statsMapper.actTotal", statsDate);
        System.out.println(actTotal);
        List<Integer> actIntensity = session.selectList("statsMapper.actIntensity", statsDate);
        actStats.setTot_act_val(actTotal.getTot_act_val());
        actStats.setTot_act_time(actTotal.getTot_act_time());
        actStats.setAvg_act_one(actTotal.getAvg_act_one());
        actStats.setTot_weak_time(actIntensity.get(0));
        actStats.setTot_middle_time(actIntensity.get(1));
        actStats.setTot_strong_time(actIntensity.get(2));
        actStats.setMaxDay_actName(session.selectOne("statsMapper.actMaxDay", statsDate));
        actStats.setMaxKcal_actName(session.selectOne("statsMapper.actMaxKcal", statsDate));
        actStats.setMaxTime_actName(session.selectOne("statsMapper.actMaxTime", statsDate));

        System.out.println(actStats);

        return actStats;
    }
}
