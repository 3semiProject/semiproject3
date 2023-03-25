package org.sixpack.semi.qnaanswer.model.service;

import java.util.ArrayList;

import org.sixpack.semi.qnaanswer.model.vo.QnaAnswer;

public interface QnaAnswerService {
	
	ArrayList<QnaAnswer> selectAnswerDetail(int qna_answer_no);
	int insertAnswer(QnaAnswer answer);
	int updateAnswer(QnaAnswer answer);
	int deleteAnswer(int qns_answer_no);
}
