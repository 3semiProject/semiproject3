package org.sixpack.semi.body.model.service;

import org.sixpack.semi.body.model.dao.BodyDao;
import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bodyService")
public class BodyServiceImpl implements BodyService {
	
	@Autowired
	private BodyDao bodyDao;

	@Override
	public Body selectOneBody(Diary diary) {
		return bodyDao.selectOneBody(diary);
	}

	@Override
	public Body selectCompareBody(Diary diary) {
		return bodyDao.selectCompareBody(diary);
	}

	@Override
	public int insertBody(Body body) {
		return bodyDao.insertBody(body);
	}

	@Override
	public Body selectBody(int diary_no) {
		return bodyDao.selectBody(diary_no);
	}

	public int updateBody(Body body) {
		return bodyDao.updateBody(body);
	}
	public int deleteBody(Body body) {
		return bodyDao.deleteBody(body);
	}
}
