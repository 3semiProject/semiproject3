package org.sixpack.semi.eyebody.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.eyebody.model.dao.EyebodyDao;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("eyebodyService")
public class EyebodyServiceImpl implements EyebodyService {
	@Autowired
	private EyebodyDao eyebodyDao;
	
	@Override
	public int selectListCount() {
		return eyebodyDao.selectListCount();
	}

	@Override
	public ArrayList<Eyebody> selectList(Paging page) {
		return eyebodyDao.selectList(page);
	}

	@Override
	public Eyebody selectBoard(int eyebody_no) {
		return eyebodyDao.selectBoard(eyebody_no);
	}

	@Override
	public int updateBoardReadcount(int eyebody_no) {
		return eyebodyDao.updateBoardReadcount(eyebody_no);
	}

	@Override
	public int insertBoard(Eyebody eyebody) {
		return eyebodyDao.insertBoard(eyebody);
	}

	@Override
	public int insertReply(Eyebody reply) {
		return eyebodyDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Eyebody reply) {
		return eyebodyDao.updateReplySeq(reply);
	}

	@Override
	public int updateBoard(Eyebody eyebody) {
		return eyebodyDao.updateBoard(eyebody);
	}

	@Override
	public int updateReply(Eyebody reply) {
		return eyebodyDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(Eyebody eyebody) {
		return eyebodyDao.deleteBoard(eyebody);
	}

	@Override
	public ArrayList<Eyebody> selectSearchTitle(String keyword) {
		return eyebodyDao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<Eyebody> selectSearchWriter(String keyword) {
		return eyebodyDao.selectSearchWriter(keyword);
	}

	@Override
	public ArrayList<Eyebody> selectSearchValue(String keyword) {
		return eyebodyDao.selectSearchValue(keyword);
	}
}
