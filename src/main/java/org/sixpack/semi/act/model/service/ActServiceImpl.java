package org.sixpack.semi.act.model.service;

import java.util.ArrayList;

import org.sixpack.semi.act.model.dao.ActDao;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("actService")
public class ActServiceImpl implements ActService {
	
	@Autowired
	private ActDao dao;

	@Override
	public ArrayList<Act> selectDayAct(Diary diary) {
		return null;
	}

	@Override
	public int insertOneAct(Act act) {
		return 0;
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
	public Move selectMoveName(String move_name) {
		return null;
	}


}
