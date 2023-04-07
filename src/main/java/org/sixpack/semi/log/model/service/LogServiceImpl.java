package org.sixpack.semi.log.model.service;

import java.sql.Date;

import org.sixpack.semi.log.model.dao.LogDao;
import org.sixpack.semi.log.model.vo.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("logService")
public class LogServiceImpl implements LogService{

	@Autowired
	private LogDao logDao;

	@Override
	public int selectLogCount(Date date) {
		return logDao.selectLogCount(date);
	}


	//하루, 월, 월평균 접속자수 카운트 메소드
	@Override
	public int visitCount() {
		return logDao.selectLogCount();
	}

	@Override
	public int visitCountMonth() {
		return logDao.selectLogCountM();
	}

	@Override
	public int visitCountAvg() {
		return logDao.selectLogCountAvg();
	}

	//접속자 로그테이블에 저장하기
	@Override
	public int insertLog(Log log) {
		return logDao.insertLog(log);
		
	}
	
}
