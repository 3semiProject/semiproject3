package org.sixpack.semi.qna.model.service;

import java.util.ArrayList;

import org.sixpack.semi.qna.model.vo.Qna;

public interface QnaService {
	
	ArrayList<Qna> selectQnaList();
	ArrayList<Qna> selectQnaDetail(int qna_no);
	ArrayList<Qna> selectNoAnswerList();
	int insertQna(Qna qna);
	int updateQna(Qna qna);
	int deleteQna(int qna_no);
	
	
}
