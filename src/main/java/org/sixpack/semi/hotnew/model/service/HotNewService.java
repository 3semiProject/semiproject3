package org.sixpack.semi.hotnew.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.hotnew.model.vo.HotNew;

public interface HotNewService {
	
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	HotNew selectBoard(int hotnew_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateBoardReadcount(int hotnew_no);	//상세보기시에 조회수 1증가 처리용
	int insertBoard(HotNew hotnew);	//원글 등록용
	int insertReply(HotNew reply);		//댓글 등록용 (대댓글 등록 포함)
	int updateReplySeq(HotNew reply);	//댓글 등록시 기존 댓글의 순번을 1증가 처리(최신 댓글이 순번1이 되게함)
	int updateBoard(HotNew hotnew);	//원글 수정용
	int updateReply(HotNew reply);	//댓글 수정용 (대댓글 수정 포함)
	int deleteBoard(HotNew hotnew);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<HotNew> newSelectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	ArrayList<HotNew> newSelectSearchTitle(Searchs searchs);
	ArrayList<HotNew> newSelectSearchWriter(Searchs searchs);
	ArrayList<HotNew> newSelectSearchValue(Searchs searchs);
	ArrayList<HotNew> hotSelectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	ArrayList<HotNew> hotSelectSearchTitle(Searchs searchs);
	ArrayList<HotNew> hotSelectSearchWriter(Searchs searchs);
	ArrayList<HotNew> hotSelectSearchValue(Searchs searchs);
	ArrayList<HotNew> hotnewSelectTop5();
	int selectSearchListCount(CountSearch countSearch);
	HotNew selectFree(HotNew hotnew);
	HotNew selectTip(HotNew hotnew);
	HotNew selectEyebody(HotNew hotnew);
	HotNew selectBfaf(HotNew hotnew);
}
