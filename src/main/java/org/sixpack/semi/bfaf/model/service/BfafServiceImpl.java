package org.sixpack.semi.bfaf.model.service;

import java.util.ArrayList;

import org.sixpack.semi.bfaf.model.dao.BfafDao;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.bfaf.model.vo.LikeBfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
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
	public ArrayList<Bfaf> selectSearchTitle(Searchs searchs) {
		return bfafDao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Bfaf> selectSearchWriter(Searchs searchs) {
		return bfafDao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Bfaf> selectSearchValue(Searchs searchs) {
		return bfafDao.selectSearchValue(searchs);
	}
	
	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return bfafDao.selectSearchListCount(countSearch);
	}
	
	@Override
	public int deleteBfafBoard(int bfaf_no) {
		return bfafDao.deleteBfafBoard(bfaf_no);
	}
	
	@Override
	public ArrayList<Bfaf> selectRepleList(int bfaf_no) {
		return bfafDao.selectRepleList(bfaf_no);
	}
	
	@Override
	public int deleteReple(Bfaf bfaf) {
		return bfafDao.deleteReple(bfaf);
	}

	@Override
	public int insertReple(Bfaf bfaf) {
		return bfafDao.insertReple(bfaf);
	}

	@Override
	public int updateReple(Bfaf bfaf) {
		return bfafDao.updateReple(bfaf);
	}

	@Override
	public int insertReple2(Bfaf bfaf) {
		return bfafDao.insertReple2(bfaf);
	}

	@Override
	public int insertLikeBfaf(Bfaf bfaf) {
		return bfafDao.insertLikeBfaf(bfaf);
	}

	@Override
	public int updatePBfafLikeNo(Bfaf bfaf) {
		return bfafDao.updatePBfafLikeNo(bfaf);
		
	}

	@Override
	public int deleteLikeBfaf(Bfaf bfaf) {
		return bfafDao.deleteLikeBfaf(bfaf);
		
	}

	@Override
	public int updateMBfafLikeNo(Bfaf bfaf) {
		return bfafDao.updateMBfafLikeNo(bfaf);
		
	}

	@Override
	public LikeBfaf selectLikeBfaf(Bfaf bfaf) {
		return bfafDao.selectLikeBfaf(bfaf);
	}

	@Override
	public int updateMBoardCount(Bfaf bfaf) {
		return bfafDao.updateMBoardCount(bfaf);
	}
}
