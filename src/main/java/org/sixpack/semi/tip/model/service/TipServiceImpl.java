package org.sixpack.semi.tip.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.tip.model.dao.TipDao;
import org.sixpack.semi.tip.model.vo.Tip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("tipService")
public class TipServiceImpl implements TipService {
	@Autowired
	private TipDao tipDao;
	
    @Override
	public int selectListCount() {
		return tipDao.selectListCount();
	}

	@Override
	public ArrayList<Tip> selectList(Paging page) {
		return tipDao.selectList(page);
	}

	@Override
	public Tip selectBoard(int tip_no) {
		return tipDao.selectBoard(tip_no);
	}

	@Override
	public int updateBoardReadcount(int tip_no) {
		return tipDao.updateBoardReadcount(tip_no);
	}

	@Override
	public int insertBoard(Tip tip) {
		return tipDao.insertBoard(tip);
	}

	@Override
	public int insertReply(Tip reply) {
		return tipDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Tip reply) {
		return tipDao.updateReplySeq(reply);
	}

	@Override
	public int updateBoard(Tip tip) {
		return tipDao.updateBoard(tip);
	}

	@Override
	public int updateReply(Tip reply) {
		return tipDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(Tip tip) {
		return tipDao.deleteBoard(tip);
	}
}
