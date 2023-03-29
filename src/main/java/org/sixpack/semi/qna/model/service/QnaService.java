package org.sixpack.semi.qna.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.qna.model.vo.Qna;

public interface QnaService {
	
	ArrayList<Qna> selectQnaList(Paging page);
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Qna> selectQnaDetail(int qna_no);
	ArrayList<Qna> selectNoAnswerList();
	int insertQna(Qna qna);
	int updateQna(Qna qna);
	int deleteQna(int qna_no);
	
	
}
