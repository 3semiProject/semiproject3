package org.sixpack.semi.eat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.eat.model.dao.EatDao;
import org.sixpack.semi.eat.model.vo.Eat;
import org.sixpack.semi.eat.model.vo.Food;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("eatService")
public class EatServiceImpl implements EatService {

		@Autowired
		private EatDao eatDao;

		@Override
		public ArrayList<Eat> selectDayEats(Diary diary) {
			return eatDao.selectDayEats(diary);
		}

		@Override
		public ArrayList<Eat> selectSumAllEats(Diary diary) {
			return eatDao.selectSumAllEats(diary);
		}

		@Override
		public ArrayList<Food> selectSearchFoodlist(String food_name) {
			return eatDao.selectSearchFoodlist(food_name);
		}
		@Override
		public int insertAllEat(List<Eat> eats) {
			return eatDao.insertAllEat(eats);
		}

		@Override
		public int updateAllEat(ArrayList<Eat> eats) {
			return 0;
		}

		@Override
		public int deleteAllEat(int diary_no) {
			return eatDao.deleteAllEat(diary_no);
		}

		@Override
		public int deleteEatOverSeq(Eat eat) {
			return eatDao.deleteEatOverSeq(eat);
		}

		@Override
		public int updateOneEat(Eat eat) {
			return eatDao.updateOneEat(eat);
		}

		@Override
		public int selectEatCount(int diary_no) {
			return eatDao.selectEatCount(diary_no);
		}

		@Override
		public int insertOneEat(Eat eat) {
			return 0;
		}
}
