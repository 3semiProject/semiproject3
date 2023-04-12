package org.sixpack.semi.notice.model.dao;

import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.notice.model.vo.Notice;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("noticeMapper.selectListCount");
	}

	public ArrayList<Notice> selectList(Paging page) {
		List<Notice> list = session.selectList("noticeMapper.selectList", page);
		return (ArrayList<Notice>)list;
	}

	public Notice selectNotice(int notice_no) {
		return session.selectOne("noticeMapper.selectNotice", notice_no);
	}

	public int updateNoticeReadcount(int notice_no) {
		return session.update("noticeMapper.updateNoticeReadcount", notice_no);
	}

	public int insertNotice(Notice notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}

	public int updateNotice(Notice notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}

	public int deleteNotice(int notice_no) {
		return session.delete("noticeMapper.deleteNotice", notice_no);
	}

	public ArrayList<Notice> selectSearchTitle(Searchs searchs) {
		List<Notice> list = session.selectList("noticeMapper.selectSearchTitle", searchs);
		return (ArrayList<Notice>)list;
	}

	public ArrayList<Notice> selectSearchWriter(Searchs searchs) {
		List<Notice> list = session.selectList("noticeMapper.selectSearchWriter", searchs);
		return (ArrayList<Notice>)list;
	}

	public ArrayList<Notice> selectSearchContent(Searchs searchs) {
		List<Notice> list = session.selectList("noticeMapper.selectSearchContent", searchs);
		return (ArrayList<Notice>)list;
	}

	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("noticeMapper.selectSearchListCount", countSearch);
	}
}