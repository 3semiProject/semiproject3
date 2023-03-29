package org.sixpack.semi.notice.model.service;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.notice.model.dao.NoticeDao;
import org.sixpack.semi.notice.model.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticedao;

	@Override
	public int selectListCount() {
		return noticedao.selectListCount();
	}

	@Override
	public ArrayList<Notice> selectList(Paging page) {
		return noticedao.selectList(page);
	}

	@Override
	public Notice selectNotice(int notice_no) {
		return noticedao.selectNotice(notice_no);
	}

	@Override
	public int updateNoticeReadcount(int notice_no) {
		return noticedao.updateNoticeReadcount(notice_no);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticedao.insertNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticedao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int notice_no) {
		return noticedao.deleteNotice(notice_no);
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(String keyword) {
		return noticedao.selectSearchTitle(keyword);
	}

	@Override
	public ArrayList<Notice> selectSearchWriter(String keyword) {
		return noticedao.selectSearchWriter(keyword);
	}

	@Override
	public ArrayList<Notice> selectSearchContent(String keyword) {
		return noticedao.selectSearchContent(keyword);
	}
}
