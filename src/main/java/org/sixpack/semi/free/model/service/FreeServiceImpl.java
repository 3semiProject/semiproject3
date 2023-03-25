package org.sixpack.semi.free.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.free.model.dao.FreeDao;
import org.sixpack.semi.free.model.vo.Free;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("freeService")
public class FreeServiceImpl implements FreeService{
	
	@Autowired
	private FreeDao	freeDao;

	@Override
	public int selectListCount() {
		return freeDao.selectListCount();
	}

	@Override
	public ArrayList<Free> selectList(Paging page) {
		return freeDao.selectList(page);
	}

	@Override
	public Free selectBoard(int free_no) {
		return freeDao.selectBoard(free_no);
	}

	@Override
	public int updateBoardReadcount(int free_no) {
		return freeDao.updateBoardReadcount(free_no);
	}

	@Override
	public int insertBoard(Free free) {
		return freeDao.insertBoard(free);
	}

	@Override
	public int insertReply(Free reply) {
		return freeDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Free reply) {
		return freeDao.updateReplySeq(reply);
	}

	@Override
	public int updateBoard(Free free) {
		return freeDao.updateBoard(free);
	}

	@Override
	public int updateReply(Free reply) {
		return freeDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(Free free) {
		return freeDao.deleteBoard(free);
	}

	@Override
	public ArrayList<Free> selectTop5() {
		return freeDao.selectTop5();
	}
	
}
