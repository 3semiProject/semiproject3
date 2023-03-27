package org.sixpack.semi.stats.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository()
public class StatsDao {
	
	private SqlSessionTemplate session; //의존성 주입됨(DI)
}
