package org.sixpack.semi.bfaf.model.service;

import java.util.ArrayList;

import org.sixpack.semi.bfaf.model.dao.BfafDao;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.common.Paging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bfafService")
public class BfafServiceImpl implements BfafService {
	@Autowired
	private BfafDao bfafDao;

	@Override
	public int selectListCount() {
		return bfafDao.selectListCount();
	}

	@Override
	public ArrayList<Bfaf> selectList(Paging page) {
		return bfafDao.selectList(page);
	}

	@Override
	public Bfaf selectBoard(int bfaf_no) {
		return bfafDao.selectBoard(bfaf_no);
	}

	@Override
	public int updateBoardReadcount(int bfaf_no) {
		return bfafDao.updateBoardReadcount(bfaf_no);
	}

	@Override
	public int insertBoard(Bfaf bfaf) {
		return bfafDao.insertBoard(bfaf);
	}

	@Override
	public int insertReply(Bfaf reply) {
		return bfafDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Bfaf reply) {
		return bfafDao.updateReplySeq(reply);
	}

	@Override
	public int updateBoard(Bfaf bfaf) {
		return bfafDao.updateBoard(bfaf);
	}

	@Override
	public int updateReply(Bfaf reply) {
		return bfafDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(Bfaf bfaf) {
		return bfafDao.deleteBoard(bfaf);
	}
	@Override
	public ArrayList<Bfaf> selectSearchTitle(String keyword) {
		return bfafDao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<Bfaf> selectSearchWriter(String keyword) {
		return bfafDao.selectSearchWriter(keyword);
	}

	@Override
	public ArrayList<Bfaf> selectSearchValue(String keyword) {
		return bfafDao.selectSearchValue(keyword);
	}
}
