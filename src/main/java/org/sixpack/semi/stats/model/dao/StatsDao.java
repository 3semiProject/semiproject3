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
        List<ActStats> actIntensity = session.selectList("statsMapper.actIntensity", statsDate.getUser_id());


        return actStats;
    }
}
