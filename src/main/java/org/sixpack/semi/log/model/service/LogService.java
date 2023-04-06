package org.sixpack.semi.log.model.service;

import java.sql.Date;

import org.sixpack.semi.log.model.vo.Log;

public interface LogService {
	
	int selectLogCount(Date date);
	int visitCount();
	int visitCountMonth();
	int visitCountAvg();
	int insertLog(Log log);

}
