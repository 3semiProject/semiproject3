package org.sixpack.semi.qnaanswer.model.service;

import java.util.ArrayList;

import org.sixpack.semi.qnaanswer.model.dao.QnaAnswerDao;
import org.sixpack.semi.qnaanswer.model.vo.QnaAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("qnaAnswerService")
public class QnaAnswerServiceImpl implements QnaAnswerService{
	@Autowired
	private QnaAnswerDao qnaAnswerDao;

	@Override
	public ArrayList<QnaAnswer> selectAnswerDetail(int qna_answer_no) {
		return qnaAnswerDao.selectAnswerDetail(qna_answer_no);
	}

	@Override
	public int insertAnswer(QnaAnswer answer) {
		return qnaAnswerDao.insertAnswer(answer);
	}

	@Override
	public int updateAnswer(QnaAnswer answer) {
		return qnaAnswerDao.updateAnswer(answer);
	}

	@Override
	public int deleteAnswer(int qns_answer_no) {
		return qnaAnswerDao.deleteAnswer(qns_answer_no);
	}
}
