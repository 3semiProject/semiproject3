package org.sixpack.semi.event.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.event.model.vo.Event;

public interface EventService {
	int selectListCount();	//총 게시글 갯수 조회용 (페이지 수 계산용)
	ArrayList<Event> selectList(Paging page);	//한 페이지에 출력할 게시글 조회용
	Event selectEvent(int event_no);	//해당 게시글번호에 대한 게시글 상세 조회용
	int updateEventReadcount(int event_no);	//상세보기시에 조회수 1증가 처리용
	int insertEvent(Event event);	//원글 등록용
	int updateEvent(Event event);	//원글 수정용
	int deleteEvent(int event_no);	//게시글 삭제용 (원글 삭제시, 관련 댓글과 대댓글 같이 삭제)
	ArrayList<Event> selectSearchTitle(String keyword);
	ArrayList<Event> selectSearchWriter(String keyword);
	ArrayList<Event> selectSearchContent(String keyword);
}
