package org.sixpack.semi.notice.model.service;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.notice.model.dao.NoticeDao;
import org.sixpack.semi.notice.model.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeDao ndao = new NoticeDao();

    @Override
    public ArrayList<Notice> selectNewTop5() {
        return ndao.selectNewTop5();
    }

    @Override
    public ArrayList<Notice> selectAll() {
        return ndao.selectAll();
    }

    @Override
    public Notice selectNotice(int noticeno) {
        return ndao.selectNotice(noticeno);
    }

    @Override
    public int insertNotice(Notice notice) {
        return ndao.insertNotice(notice);
    }

    @Override
    public int updateNotice(Notice notice) {
        return ndao.updateNotice(notice);
    }

    @Override
    public int deleteNotice(int noticeno) {
        return ndao.deleteNotice(noticeno);
    }

    @Override
    public ArrayList<Notice> selectSearchTitle(String keyword) {
        return ndao.selectSearchTitle(keyword);
    }

    @Override
    public ArrayList<Notice> selectSearchWriter(String keyword) {
        return ndao.selectSearchWriter(keyword);
    }

    @Override
    public ArrayList<Notice> selectSearchDate(SearchDate date) {
        return ndao.selectSearchDate(date);
    }

    @Override
    public Notice selectLast() {
        return ndao.selectLast();
    }
}
