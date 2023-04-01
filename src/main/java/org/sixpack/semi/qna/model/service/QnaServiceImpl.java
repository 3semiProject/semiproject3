package org.sixpack.semi.qna.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.qna.model.dao.QnaDao;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{
	@Autowired
	private QnaDao qnaDao;

	@Override
	public int selectListCount() {
		return qnaDao.selectListCount();
	}

	@Override
	public ArrayList<Qna> selectList(Paging page) {
		return qnaDao.selectList(page);
	}

	@Override
	public Qna selectQna(int qna_no) {
		return qnaDao.selectQna(qna_no);
	}

	@Override
	public int updateQnaReadcount(int qna_no) {
		return qnaDao.updateQnaReadcount(qna_no);
	}

	@Override
	public int insertQna(Qna qna) {
		return qnaDao.insertQna(qna);
	}

	@Override
	public int updateQna(Qna qna) {
		return qnaDao.updateQna(qna);
	}

	@Override
	public int deleteQna(int qna_no) {
		return qnaDao.deleteQna(qna_no);
	}

	@Override
	public ArrayList<Qna> selectSearchTitle(Searchs searchs) {
		return qnaDao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Qna> selectSearchWriter(Searchs searchs) {
		return qnaDao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Qna> selectSearchContent(Searchs searchs) {
		return qnaDao.selectSearchContent(searchs);
	}

	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return qnaDao.selectSearchListCount(countSearch);
	}

	@Override
	public int updateReplySeq(Qna reply) {
		return qnaDao.updateReplySeq(reply);
	}

	@Override
	public int insertReply(Qna reply) {
		return qnaDao.insertReply(reply);
	}

	
}
