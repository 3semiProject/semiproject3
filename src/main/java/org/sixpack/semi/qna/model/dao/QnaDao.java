package org.sixpack.semi.qna.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("qnaDao")
public class QnaDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Qna> selectQnaList() {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Qna> selectQnaDetail(int qna_no) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Qna> selectNoAnswerList() {
		// TODO Auto-generated method stub
		return null;
	}

	public int insertQna(Qna qna) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateQna(Qna qna) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteQna(int qna_no) {
		// TODO Auto-generated method stub
		return 0;
	}
}
