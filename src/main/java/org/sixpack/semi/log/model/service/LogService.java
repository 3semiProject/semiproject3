package org.sixpack.semi.log.model.service;

import org.sixpack.semi.log.model.vo.Log;

import java.sql.Date;

public interface LogService {
	
	int selectLogCount(Date date);
	int visitCount();
	int visitCountMonth();
	int visitCountAvg();
	int insertLog(Log log);

}
