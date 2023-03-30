package org.sixpack.semi.notice.model.service;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.notice.model.vo.Notice;

import java.util.ArrayList;

public interface NoticeService {
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Notice> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Notice selectNotice(int notice_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateNoticeReadcount(int notice_no);	//상세보기시에 조회수 1증가 처리용
	int insertNotice(Notice notice);	//원글 등록용
	int updateNotice(Notice notice);	//원글 수정용
	int deleteNotice(int notice_no);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Notice> selectSearchTitle(String keyword);
	ArrayList<Notice> selectSearchWriter(String keyword);
	ArrayList<Notice> selectSearchContent(String keyword);
}
