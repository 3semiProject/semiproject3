package org.sixpack.semi.qna.model.service;

import java.util.ArrayList;

import org.sixpack.semi.qna.model.dao.QnaDao;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{
	@Autowired
	private QnaDao qnaDao;

	@Override
	public ArrayList<Qna> selectQnaList() {
		return qnaDao.selectQnaList();
	}

	@Override
	public ArrayList<Qna> selectQnaDetail(int qna_no) {
		return qnaDao.selectQnaDetail(qna_no);
	}

	@Override
	public ArrayList<Qna> selectNoAnswerList() {
		return qnaDao.selectNoAnswerList();
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
}
