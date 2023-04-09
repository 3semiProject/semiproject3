package org.sixpack.semi.act.model.service;

import java.util.ArrayList;
import java.util.List;

import org.sixpack.semi.act.model.dao.ActDao;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("actService")
public class ActServiceImpl implements ActService {
	
	@Autowired
	private ActDao actDao;
	
	//운동다이어리 보기용
	@Override
	public ArrayList<Act> selectDayAct(Diary diary) {
		return actDao.selectDayAct(diary);
	}	
	@Override
	public java.lang.Integer selectSumAct(Diary diary) {
		return actDao.selectSumAct(diary);
	}
	
	//운동다이어리 작성용
	@Override
	public ArrayList<Move> selectSearchMovelist(String move_name) {
		return actDao.selectSearchMovelist(move_name);
	}
	@Override
	public int insertAllAct(List<Act> acts) {
		return actDao.insertAllAct(acts);
	}
	

	@Override
	public int deleteAllAct(Diary diaryno) {
		return 0;
	}

	@Override
	public int deleteOneAct(Act act) {
		return 0;
	}

	@Override
	public int updateOneAct(Act act) {
		return 0;
	}

	@Override
	public int insertOneAct(Act act) {
		return 0;
	}




}
