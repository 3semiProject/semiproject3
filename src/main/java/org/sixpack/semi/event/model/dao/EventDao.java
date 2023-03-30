package org.sixpack.semi.event.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.event.model.vo.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("eventDao")
public class EventDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("eventMapper.selectListCount");
	}

	public ArrayList<Event> selectList(Paging page) {
		List<Event> list = session.selectList("eventMapper.selectList", page);
		return (ArrayList<Event>)list;
	}

	public Event selectEvent(int event_no) {
		return session.selectOne("eventMapper.selectListCount", event_no);
	}

	public int updateEventReadcount(int event_no) {
		return session.update("eventMapper.selectListCount", event_no);
	}

	public int insertEvent(Event event) {
		return session.insert("eventMapper.selectListCount", event);
	}

	public int updateEvent(Event event) {
		return session.update("eventMapper.selectListCount", event);
	}

	public int deleteEvent(int event_no) {
		return session.delete("eventMapper.selectListCount", event_no);
	}

	public ArrayList<Event> selectSearchTitle(Searchs searchs) {
		List<Event> list = session.selectList("eventMapper.selectSearchTitle", searchs);
		return (ArrayList<Event>)list;
	}

	public ArrayList<Event> selectSearchWriter(Searchs searchs) {
		List<Event> list = session.selectList("eventMapper.selectSearchWriter", searchs);
		return (ArrayList<Event>)list;
	}

	public ArrayList<Event> selectSearchContent(Searchs searchs) {
		List<Event> list = session.selectList("eventMapper.selectSearchContent", searchs);
		return (ArrayList<Event>)list;
	}

	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("eventMapper.selectSearchListCount", countSearch);
	}
}
