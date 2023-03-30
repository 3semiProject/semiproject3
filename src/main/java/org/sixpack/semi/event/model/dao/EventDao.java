package org.sixpack.semi.event.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
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

	public ArrayList<Event> selectSearchTitle(String keyword) {
		List<Event> list = session.selectList("eventMapper.selectSearchTitle", keyword);
		return (ArrayList<Event>)list;
	}

	public ArrayList<Event> selectSearchWriter(String keyword) {
		List<Event> list = session.selectList("eventMapper.selectSearchWriter", keyword);
		return (ArrayList<Event>)list;
	}

	public ArrayList<Event> selectSearchContent(String keyword) {
		List<Event> list = session.selectList("eventMapper.selectSearchContent", keyword);
		return (ArrayList<Event>)list;
	}
}
