package org.sixpack.semi.qnaanswer.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.qnaanswer.model.vo.QnaAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("qnaAnswerDao")
public class QnaAnswerDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<QnaAnswer> selectAnswerDetail(int qna_answer_no) {
		// TODO Auto-generated method stub
		return null;
	}

	public int insertAnswer(QnaAnswer answer) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateAnswer(QnaAnswer answer) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteAnswer(int qns_answer_no) {
		// TODO Auto-generated method stub
		return 0;
	}
}
