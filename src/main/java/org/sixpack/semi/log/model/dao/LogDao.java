package org.sixpack.semi.log.model.dao;

import java.sql.Date;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("logDao")
public class LogDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectLogCount(Date date) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int insertLog(String userid, String ip) {
		// TODO Auto-generated method stub
		return 0;
	}

}
