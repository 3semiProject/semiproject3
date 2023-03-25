package org.sixpack.semi.log.model.service;

import java.sql.Date;

import org.sixpack.semi.log.model.dao.LogDao;
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

	@Override
	public int insertLog(String userid, String ip) {
		return logDao.insertLog(userid, ip);
	}
	
}
