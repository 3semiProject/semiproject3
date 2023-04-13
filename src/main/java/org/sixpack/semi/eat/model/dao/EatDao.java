package org.sixpack.semi.eat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.eat.model.vo.Food;
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
		return (ArrayList<Eat>)list;	
	}

	public ArrayList<Food> selectSearchFoodlist(String food_name) {
		List<Food> list = session.selectList("eatMapper.selectSearchFoodlist", food_name);
		return (ArrayList<Food>)list;		
	}

	public int insertAllEat(List<Eat> eats) {
		return session.insert("eatMapper.insertAllEat", eats);
	}

	public int deleteAllEat(int diary_no) {
		return session.delete("eatMapper.deleteAllEat", diary_no);
	}

	public int deleteEatOverSeq(Eat eat) {
		return session.delete("eatMapper.deleteSeqEat", eat);
	}

	public int updateOneEat(Eat eat) {
		return session.update("eatMapper.updateOneEat", eat);
	}

	public int selectEatCount(int diary_no) {
		return session.selectOne("eatMapper.selectEatCount", diary_no);
	}

}
