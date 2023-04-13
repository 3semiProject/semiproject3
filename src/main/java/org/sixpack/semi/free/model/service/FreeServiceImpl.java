package org.sixpack.semi.free.model.service;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.dao.FreeDao;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.free.model.vo.LikeFree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

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
	public int deleteFreeBoard(int free_no) {
		return freeDao.deleteFreeBoard(free_no);
	}

	@Override
	public ArrayList<Free> selectTop5() {
		return freeDao.selectTop5();
	}

	@Override
	public ArrayList<Free> selectSearchTitle(Searchs searchs) {
		return freeDao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Free> selectSearchWriter(Searchs searchs) {
		return freeDao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Free> selectSearchValue(Searchs searchs) {
		return freeDao.selectSearchValue(searchs);
	}

	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return freeDao.selectSearchListCount(countSearch);
	}

	@Override
	public ArrayList<Free> selectRepleList(int free_no) {
		return freeDao.selectRepleList(free_no);
	}

	@Override
	public int deleteBoard(Free free) {
		return freeDao.deleteBoard(free);
	}

	@Override
	public int deleteReple(Free free) {
		return freeDao.deleteReple(free);
	}

	@Override
	public int insertReple(Free free) {
		return freeDao.insertReple(free);
	}

	@Override
	public int updateReple(Free free) {
		return freeDao.updateReple(free);
	}

	@Override
	public int insertReple2(Free free) {
		return freeDao.insertReple2(free);
	}

	@Override
	public int insertLikeFree(Free free) {
		return freeDao.insertLikeFree(free);
	}

	@Override
	public int updatePFreeLikeNo(Free free) {
		return freeDao.updatePFreeLikeNo(free);
		
	}

	@Override
	public int deleteLikeFree(Free free) {
		return freeDao.deleteLikeFree(free);
		
	}

	@Override
	public int updateMFreeLikeNo(Free free) {
		return freeDao.updateMFreeLikeNo(free);
		
	}

	@Override
	public LikeFree selectLikeFree(Free free) {
		return freeDao.selectLikeFree(free);
	}

	@Override
	public int updateMBoardCount(Free free) {
		return freeDao.updateMBoardCount(free);
	}
	
}
