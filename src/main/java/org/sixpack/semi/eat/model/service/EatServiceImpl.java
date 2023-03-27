package org.sixpack.semi.eat.model.service;

import java.util.ArrayList;

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
		public ArrayList<Eat> selectDayEat(Diary diary) {
			return null;
		}

		@Override
		public ArrayList<Eat> selectSumAllEat(Diary diary) {
			return null;
		}
		
		@Override
		public Food selectFoodName(String food_name) {
			return null;
		}

		@Override
		public int insertAllEat(ArrayList<Eat> eats) {
			return 0;
		}

		@Override
		public int updateAllEat(ArrayList<Eat> eats) {
			return 0;
		}
		
		@Override
		public int deleteAllEat(Diary diary) {
			return 0;
		}
}
