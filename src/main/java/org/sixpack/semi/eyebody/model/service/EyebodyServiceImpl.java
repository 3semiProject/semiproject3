package org.sixpack.semi.eyebody.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.dao.EyebodyDao;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.eyebody.model.vo.LikeEyebody;
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
	public ArrayList<Eyebody> selectSearchTitle(Searchs searchs) {
		return eyebodyDao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Eyebody> selectSearchWriter(Searchs searchs) {
		return eyebodyDao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Eyebody> selectSearchValue(Searchs searchs) {
		return eyebodyDao.selectSearchValue(searchs);
	}
	
	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return eyebodyDao.selectSearchListCount(countSearch);
	}
	
	@Override
	public int deleteEyebodyBoard(int eyebody_no) {
		return eyebodyDao.deleteEyebodyBoard(eyebody_no);
	}
	
	@Override
	public ArrayList<Eyebody> selectRepleList(int eyebody_no) {
		return eyebodyDao.selectRepleList(eyebody_no);
	}
	
	@Override
	public int deleteReple(Eyebody eyebody) {
		return eyebodyDao.deleteReple(eyebody);
	}

	@Override
	public int insertReple(Eyebody eyebody) {
		return eyebodyDao.insertReple(eyebody);
	}

	@Override
	public int updateReple(Eyebody eyebody) {
		return eyebodyDao.updateReple(eyebody);
	}

	@Override
	public int insertReple2(Eyebody eyebody) {
		return eyebodyDao.insertReple2(eyebody);
	}

	@Override
	public int insertLikeEyebody(Eyebody eyebody) {
		return eyebodyDao.insertLikeEyebody(eyebody);
	}

	@Override
	public int updatePEyebodyLikeNo(Eyebody eyebody) {
		return eyebodyDao.updatePEyebodyLikeNo(eyebody);
		
	}

	@Override
	public int deleteLikeEyebody(Eyebody eyebody) {
		return eyebodyDao.deleteLikeEyebody(eyebody);
		
	}

	@Override
	public int updateMEyebodyLikeNo(Eyebody eyebody) {
		return eyebodyDao.updateMEyebodyLikeNo(eyebody);
		
	}

	@Override
	public LikeEyebody selectLikeEyebody(Eyebody eyebody) {
		return eyebodyDao.selectLikeEyebody(eyebody);
	}

	@Override
	public int updateMBoardCount(Eyebody eyebody) {
		return eyebodyDao.updateMBoardCount(eyebody);
	}
}
