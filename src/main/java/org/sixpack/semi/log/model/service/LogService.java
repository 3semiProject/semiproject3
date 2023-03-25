package org.sixpack.semi.log.model.service;

import java.sql.Date;

public interface LogService {
	
	int selectLogCount(Date date);
	int insertLog(String userid, String ip);

}
