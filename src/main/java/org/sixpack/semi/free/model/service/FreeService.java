package org.sixpack.semi.free.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.free.model.vo.LikeFree;

public interface FreeService {
	ArrayList<Free> selectTop5();
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Free> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Free selectBoard(int free_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateBoardReadcount(int free_no);	//상세보기시에 조회수 1증가 처리용
	int insertBoard(Free free);	//원글 등록용
	int insertReply(Free reply);		//댓글 등록용 (대댓글 등록 포함)
	int updateReplySeq(Free reply);	//댓글 등록시 기존 댓글의 순번을 1증가 처리(최신 댓글이 순번1이 되게함)
	int updateBoard(Free free);	//원글 수정용
	int updateReply(Free reply);	//댓글 수정용 (대댓글 수정 포함)
	int deleteBoard(Free free);//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Free> selectSearchTitle(Searchs searchs);
	ArrayList<Free> selectSearchWriter(Searchs searchs);
	ArrayList<Free> selectSearchValue(Searchs searchs);
	int selectSearchListCount(CountSearch countSearch);
	ArrayList<Free> selectRepleList(int free_no);
	int deleteFreeBoard(int free_no);
	int deleteReple(Free free);
	int insertReple(Free free);
	int updateReple(Free free);
	int insertReple2(Free free);
	int insertLikeFree(Free free);
	int updatePFreeLikeNo(Free free);
	int deleteLikeFree(Free free);
	int updateMFreeLikeNo(Free free);
	LikeFree selectLikeFree(Free free);
	int updateMBoardCount(Free free);
}
