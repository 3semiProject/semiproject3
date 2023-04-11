package org.sixpack.semi.body.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bodyDao")
public class BodyDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public Body selectOneBody(Diary diary) {
		return session.selectOne("bodyMapper.selectOneBody", diary);
	}

	public Body selectCompareBody(Diary diary) {
		return session.selectOne("bodyMapper.selectCompareBody", diary);
	}

	public int insertBody(Body body) {
		return session.insert("bodyMapper.insertBody", body);
	}
}
