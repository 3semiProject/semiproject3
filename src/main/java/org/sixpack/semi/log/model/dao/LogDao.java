package org.sixpack.semi.log.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.log.model.vo.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Date;

@Repository("logDao")
public class LogDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectLogCount(Date date) {
		// TODO Auto-generated method stub
		return 0;
	}

	//접속자 로그테이블에 저장
	public int insertLog(Log log) {
		return session.insert("logMapper.insertLog", log);
	}

	public int selectLogCount() {
		return session.selectOne("logMapper.selectLogCount");
	}

	public int selectLogCountM() {
		return session.selectOne("logMapper.selectLogCountM");
	}

	public int selectLogCountAvg() {
		return session.selectOne("logMapper.selectLogCountAvg");
	}

		
	}


