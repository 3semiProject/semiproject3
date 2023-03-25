package org.sixpack.semi.notice.model.service;

import org.sixpack.semi.common.SearchDate;
import org.sixpack.semi.notice.model.vo.Notice;

import java.util.ArrayList;

public interface NoticeService {
    ArrayList<Notice> selectNewTop5();

    ArrayList<Notice> selectAll();

    Notice selectNotice(int noticeno);

    int insertNotice(Notice notice);

    int updateNotice(Notice notice);

    int deleteNotice(int noticeno);

    ArrayList<Notice> selectSearchTitle(String keyword);

    ArrayList<Notice> selectSearchWriter(String keyword);

    ArrayList<Notice> selectSearchDate(SearchDate date);

    Notice selectLast();
}
