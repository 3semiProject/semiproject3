package org.sixpack.semi.eat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Eat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("eatDao")
public class EatDao {

	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Eat> selectDayEats(Diary diary) {
		List<Eat> list = session.selectList("eatMapper.selectDayEats", diary);
		return (ArrayList<Eat>)list;
	}

	public ArrayList<Eat> selectSumAllEats(Diary diary) {
		List<Eat> list = session.selectList("eatMapper.selectSumAllEats", diary);
		return (ArrayList<Eat>)list;	}
}
