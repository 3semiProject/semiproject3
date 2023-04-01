package org.sixpack.semi.qna.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.qna.model.vo.Qna;

public interface QnaService {
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Qna> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Qna selectQna(int qna_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateQnaReadcount(int qna_no);	//상세보기시에 조회수 1증가 처리용
	int insertQna(Qna qna);	//원글 등록용
	int updateQna(Qna qna);	//원글 수정용
	int deleteQna(int qna_no);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Qna> selectSearchTitle(Searchs searchs);
	ArrayList<Qna> selectSearchWriter(Searchs searchs);
	ArrayList<Qna> selectSearchContent(Searchs searchs);
	int selectSearchListCount(CountSearch countSearch);
	int updateReplySeq(Qna reply);
	int insertReply(Qna reply);
	
	
	
}
