package org.sixpack.semi.hotnew.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.hotnew.model.dao.HotNewDao;
import org.sixpack.semi.hotnew.model.vo.HotNew;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("hotNewService")
public class HotNewServiceImpl implements HotNewService {
	
	@Autowired
	private HotNewDao hotNewDao;

	@Override
	public int selectListCount() {
		return hotNewDao.selectListCount();
	}

	@Override
	public ArrayList<HotNew> selectList(Paging page) {
		return hotNewDao.selectList(page);
	}

	@Override
	public HotNew selectBoard(int hotnew_no) {
		return hotNewDao.selectBoard(hotnew_no);
	}

	@Override
	public int updateBoardReadcount(int hotnew_no) {
		return hotNewDao.updateBoardReadcount(hotnew_no);
	}

	@Override
	public int insertBoard(HotNew hotnew) {
		return hotNewDao.insertBoard(hotnew);
	}

	@Override
	public int insertReply(HotNew reply) {
		return hotNewDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(HotNew reply) {
		return hotNewDao.updateReplySeq(reply);
	}

	@Override
	public int updateBoard(HotNew hotnew) {
		return hotNewDao.updateBoard(hotnew);
	}

	@Override
	public int updateReply(HotNew reply) {
		return hotNewDao.updateReply(reply);
	}

	@Override
	public int deleteBoard(HotNew hotnew) {
		return hotNewDao.deleteBoard(hotnew);
	}
}
