package org.sixpack.semi.event.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.event.model.dao.EventDao;
import org.sixpack.semi.event.model.vo.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("eventService")
public class EventServiceImpl implements EventService {

	@Autowired
	private EventDao eventdao;
	
	@Override
	public int selectListCount() {
		return eventdao.selectListCount();
	}

	@Override
	public ArrayList<Event> selectList(Paging page) {
		return eventdao.selectList(page);
	}

	@Override
	public Event selectEvent(int event_no) {
		return eventdao.selectEvent(event_no);
	}

	@Override
	public int updateEventReadcount(int event_no) {
		return eventdao.updateEventReadcount(event_no);
	}

	@Override
	public int insertEvent(Event event) {
		return eventdao.insertEvent(event);
	}

	@Override
	public int updateEvent(Event event) {
		return eventdao.updateEvent(event);
	}

	@Override
	public int deleteEvent(int event_no) {
		return eventdao.deleteEvent(event_no);
	}

	@Override
	public ArrayList<Event> selectSearchTitle(Searchs searchs) {
		return eventdao.selectSearchTitle(searchs);
	}

	@Override
	public ArrayList<Event> selectSearchWriter(Searchs searchs) {
		return eventdao.selectSearchWriter(searchs);
	}

	@Override
	public ArrayList<Event> selectSearchContent(Searchs searchs) {
		return eventdao.selectSearchContent(searchs);
	}

	@Override
	public int selectSearchListCount(CountSearch countSearch) {
		return eventdao.selectSearchListCount(countSearch);
	}
}
