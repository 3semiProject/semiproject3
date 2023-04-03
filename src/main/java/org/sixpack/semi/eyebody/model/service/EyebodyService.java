package org.sixpack.semi.eyebody.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.eyebody.model.vo.LikeEyebody;

public interface EyebodyService {
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Eyebody> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Eyebody selectBoard(int eyebody_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateBoardReadcount(int eyebody_no);	//상세보기시에 조회수 1증가 처리용
	int insertBoard(Eyebody eyebody);	//원글 등록용
	int insertReply(Eyebody reply);		//댓글 등록용 (대댓글 등록 포함)
	int updateReplySeq(Eyebody reply);	//댓글 등록시 기존 댓글의 순번을 1증가 처리(최신 댓글이 순번1이 되게함)
	int updateBoard(Eyebody eyebody);	//원글 수정용
	int updateReply(Eyebody reply);	//댓글 수정용 (대댓글 수정 포함)
	int deleteBoard(Eyebody eyebody);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Eyebody> selectSearchTitle(Searchs searchs);
	ArrayList<Eyebody> selectSearchWriter(Searchs searchs);
	ArrayList<Eyebody> selectSearchValue(Searchs searchs);
	int selectSearchListCount(CountSearch countSearch);
	ArrayList<Eyebody> selectRepleList(int eyebody_no);
	int deleteEyebodyBoard(int eyebody_no);
	int deleteReple(Eyebody eyebody);
	int insertReple(Eyebody eyebody);
	int updateReple(Eyebody eyebody);
	int insertReple2(Eyebody eyebody);
	int insertLikeEyebody(Eyebody eyebody);
	int updatePEyebodyLikeNo(Eyebody eyebody);
	int deleteLikeEyebody(Eyebody eyebody);
	int updateMEyebodyLikeNo(Eyebody eyebody);
	LikeEyebody selectLikeEyebody(Eyebody eyebody);
	int updateMBoardCount(Eyebody eyebody);
}
