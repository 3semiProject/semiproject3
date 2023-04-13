package org.sixpack.semi.tip.model.service;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.tip.model.dao.TipDao;
import org.sixpack.semi.tip.model.vo.LikeTip;
import org.sixpack.semi.tip.model.vo.Tip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

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
	@Override
	public ArrayList<Tip> selectSearchTitle(Searchs searchs) {
		return tipDao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Tip> selectSearchWriter(Searchs searchs) {
		return tipDao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Tip> selectSearchValue(Searchs searchs) {
		return tipDao.selectSearchValue(searchs);
	}
	
	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return tipDao.selectSearchListCount(countSearch);
	}
	
	@Override
	public int deleteTipBoard(int tip_no) {
		return tipDao.deleteTipBoard(tip_no);
	}
	
	@Override
	public ArrayList<Tip> selectRepleList(int tip_no) {
		return tipDao.selectRepleList(tip_no);
	}
	
	@Override
	public int deleteReple(Tip tip) {
		return tipDao.deleteReple(tip);
	}

	@Override
	public int insertReple(Tip tip) {
		return tipDao.insertReple(tip);
	}

	@Override
	public int updateReple(Tip tip) {
		return tipDao.updateReple(tip);
	}

	@Override
	public int insertReple2(Tip tip) {
		return tipDao.insertReple2(tip);
	}

	@Override
	public int insertLikeTip(Tip tip) {
		return tipDao.insertLikeTip(tip);
	}

	@Override
	public int updatePTipLikeNo(Tip tip) {
		return tipDao.updatePTipLikeNo(tip);
		
	}

	@Override
	public int deleteLikeTip(Tip tip) {
		return tipDao.deleteLikeTip(tip);
		
	}

	@Override
	public int updateMTipLikeNo(Tip tip) {
		return tipDao.updateMTipLikeNo(tip);
		
	}

	@Override
	public LikeTip selectLikeTip(Tip tip) {
		return tipDao.selectLikeTip(tip);
	}

	@Override
	public int updateMBoardCount(Tip tip) {
		return tipDao.updateMBoardCount(tip);
	}
}
