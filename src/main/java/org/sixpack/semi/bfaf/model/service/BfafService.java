package org.sixpack.semi.bfaf.model.service;

import java.util.ArrayList;

import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;

public interface BfafService {
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Bfaf> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Bfaf selectBoard(int bfaf_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateBoardReadcount(int bfaf_no);	//상세보기시에 조회수 1증가 처리용
	int insertBoard(Bfaf bfaf);	//원글 등록용
	int insertReply(Bfaf reply);		//댓글 등록용 (대댓글 등록 포함)
	int updateReplySeq(Bfaf reply);	//댓글 등록시 기존 댓글의 순번을 1증가 처리(최신 댓글이 순번1이 되게함)
	int updateBoard(Bfaf bfaf);	//원글 수정용
	int updateReply(Bfaf reply);	//댓글 수정용 (대댓글 수정 포함)
	int deleteBoard(Bfaf bfaf);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Bfaf> selectSearchTitle(Searchs searchs);
	ArrayList<Bfaf> selectSearchWriter(Searchs searchs);
	ArrayList<Bfaf> selectSearchValue(Searchs searchs);
	int selectSearchListCount(CountSearch countSearch);
}
