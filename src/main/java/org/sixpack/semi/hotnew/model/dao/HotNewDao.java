package org.sixpack.semi.hotnew.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.hotnew.model.vo.HotNew;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("hotNewDao")

public class HotNewDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("hotnewMapper.selectListCount");
	}

	public ArrayList<HotNew> selectList(Paging page) {
		List<HotNew> list = session.selectList("hotnewMapper.selectList", page);
		return (ArrayList<HotNew>)list;
	}

	public HotNew selectBoard(int hotnew_no) {
		return session.selectOne("hotnewMapper.selectBoard", hotnew_no);
	}

	public int updateBoardReadcount(int hotnew_no) {
		return session.update("hotnewMapper.updateBoardReadcount", hotnew_no);
	}

	public int insertBoard(HotNew hotnew) {
		return session.insert("hotnewMapper.insertBoard", hotnew);
	}

	public int insertReply(HotNew reply) {
		return session.insert("hotnewMapper.insertReply", reply);
	}

	public int updateReplySeq(HotNew reply) {
		return session.update("hotnewMapper.updateReplySeq", reply);
	}

	public int updateBoard(HotNew hotnew) {
		return session.update("hotnewMapper.updateBoard", hotnew);
	}

	public int updateReply(HotNew reply) {
		return session.update("hotnewMapper.updateReply", reply);
	}

	public int deleteBoard(HotNew hotnew) {
		return session.delete("hotnewMapper.deleteBoard", hotnew);
	}

	public ArrayList<HotNew> newSelectList(Paging page) {
		List<HotNew> list = session.selectList("hotnewMapper.newSelectList", page);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> newSelectSearchTitle(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.newSelectSearchTitle", searchs);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> newSelectSearchWriter(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.newSelectSearchWriter", searchs);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> newSelectSearchValue(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.newSelectSearchValue", searchs);
		return (ArrayList<HotNew>)list;
	}
	public ArrayList<HotNew> hotSelectList(Paging page) {
		List<HotNew> list = session.selectList("hotnewMapper.hotSelectList", page);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> hotSelectSearchTitle(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.hotSelectSearchTitle", searchs);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> hotSelectSearchWriter(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.hotSelectSearchWriter", searchs);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> hotSelectSearchValue(Searchs searchs) {
		List<HotNew> list = session.selectList("hotnewMapper.hotSelectSearchValue", searchs);
		return (ArrayList<HotNew>)list;
	}

	public ArrayList<HotNew> hotnewSelectTop5() {
		List<HotNew> list = session.selectList("hotnewMapper.hotnewSelectTop5");
		return (ArrayList<HotNew>)list;
	}
	
	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("hotnewMapper.selectSearchListCount", countSearch);
	}

	public HotNew selectFree(HotNew hotnew) {
		return session.selectOne("hotnewMapper.selectFree", hotnew);
	}

	public HotNew selectTip(HotNew hotnew) {
		return session.selectOne("hotnewMapper.selectTip", hotnew);
	}

	public HotNew selectEyebody(HotNew hotnew) {
		return session.selectOne("hotnewMapper.selectEyebody", hotnew);
	}

	public HotNew selectBfaf(HotNew hotnew) {
		return session.selectOne("hotnewMapper.selectBfaf", hotnew);
	}
}
