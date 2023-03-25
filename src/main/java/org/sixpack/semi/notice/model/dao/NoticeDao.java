package org.sixpack.semi.notice.model.dao;

import org.sixpack.semi.common.SearchDate;
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

    public ArrayList<Notice> selectNewTop5() {

        List<Notice> list = session.selectList("noticeMapper.selectNewTop5");
        return (ArrayList<Notice>) list;
    }

    public ArrayList<Notice> selectAll() {
        List<Notice> list = session.selectList("noticeMapper.selectAll");
        return (ArrayList<Notice>) list;
    }

    public Notice selectNotice(int noticeno) {
        return session.selectOne("noticeMapper.selectNotice", noticeno);
    }

    public int insertNotice(Notice notice) {
        return session.insert("noticeMapper.insertNotice", notice);

    }

    public int updateNotice(Notice notice) {
        return session.update("noticeMapper.updateNotice", notice);

    }

    public int deleteNotice(int noticeno) {
        return session.delete("noticeMapper.deleteNotice", noticeno);
    }

    public ArrayList<Notice> selectSearchTitle(String keyword) {
        List<Notice> list = session.selectList("noticeMapper.selectSearchTitle", keyword);
        return (ArrayList<Notice>) list;
    }

    public ArrayList<Notice> selectSearchWriter(String keyword) {
        List<Notice> list = session.selectList("noticeMapper.selectSearchWriter", keyword);
        return (ArrayList<Notice>) list;
    }

    public ArrayList<Notice> selectSearchDate(SearchDate date) {
        List<Notice> list = session.selectList("noticeMapper.selectSearchDate", date);
        return (ArrayList<Notice>) list;
    }

    public Notice selectLast() {
        return session.selectOne("noticeMapper.selectLast");
    }
}
