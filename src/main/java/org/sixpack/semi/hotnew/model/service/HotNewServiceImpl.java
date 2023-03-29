package org.sixpack.semi.hotnew.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
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

	@Override
	public ArrayList<HotNew> newSelectList(Paging page) {
		return hotNewDao.newSelectList(page);
	}

	@Override
	public ArrayList<HotNew> newSelectSearchTitle(Searchs searchs) {
		return hotNewDao.newSelectSearchTitle(searchs);
	}

	@Override
	public ArrayList<HotNew> newSelectSearchWriter(Searchs searchs) {
		return hotNewDao.newSelectSearchWriter(searchs);
	}

	@Override
	public ArrayList<HotNew> newSelectSearchValue(Searchs searchs) {
		return hotNewDao.newSelectSearchValue(searchs);
	}

	@Override
	public ArrayList<HotNew> hotSelectList(Paging page) {
		return hotNewDao.hotSelectList(page);
	}

	@Override
	public ArrayList<HotNew> hotSelectSearchTitle(Searchs searchs) {
		return hotNewDao.hotSelectSearchTitle(searchs);
	}

	@Override
	public ArrayList<HotNew> hotSelectSearchWriter(Searchs searchs) {
		return hotNewDao.hotSelectSearchWriter(searchs);
	}

	@Override
	public ArrayList<HotNew> hotSelectSearchValue(Searchs searchs) {
		return hotNewDao.hotSelectSearchValue(searchs);
	}

	@Override
	public ArrayList<HotNew> hotnewSelectTop5() {
		return hotNewDao.hotnewSelectTop5();
	}
	
	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return hotNewDao.selectSearchListCount(countSearch);
	}
}
