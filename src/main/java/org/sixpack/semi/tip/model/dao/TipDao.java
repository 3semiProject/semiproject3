package org.sixpack.semi.tip.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.tip.model.vo.LikeTip;
import org.sixpack.semi.tip.model.vo.Tip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("tipDao")

public class TipDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("tipMapper.selectListCount");
	}

	public ArrayList<Tip> selectList(Paging page) {
		List<Tip> list = session.selectList("tipMapper.selectList", page);
		return (ArrayList<Tip>)list;
	}

	public Tip selectBoard(int tip_no) {
		return session.selectOne("tipMapper.selectBoard", tip_no);
	}

	public int updateBoardReadcount(int tip_no) {
		return session.update("tipMapper.updateBoardReadcount", tip_no);
	}

	public int insertBoard(Tip tip) {
		return session.insert("tipMapper.insertBoard", tip);
	}

	public int insertReply(Tip reply) {
		return session.insert("tipMapper.insertReply", reply);
	}

	public int updateReplySeq(Tip reply) {
		return session.update("tipMapper.updateReplySeq", reply);
	}

	public int updateBoard(Tip tip) {
		return session.update("tipMapper.updateBoard", tip);
	}

	public int updateReply(Tip reply) {
		return session.update("tipMapper.updateReply", reply);
	}

	public int deleteBoard(Tip tip) {
		return session.delete("tipMapper.deleteBoard", tip);
	}
	
	public ArrayList<Tip> selectSearchValue(Searchs searchs) {
		List<Tip> list = session.selectList("tipMapper.selectSearchValue", searchs);
		return (ArrayList<Tip>)list;
	}

	public ArrayList<Tip> selectSearchWriter(Searchs searchs) {
		List<Tip> list = session.selectList("tipMapper.selectSearchWriter", searchs);
		return (ArrayList<Tip>)list;
	}

	public ArrayList<Tip> selectSearchTitle(Searchs searchs) {
		List<Tip> list = session.selectList("tipMapper.selectSearchTitle", searchs);
		return (ArrayList<Tip>)list;
	}
	
	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("tipMapper.selectSearchListCount", countSearch);
	}
	
	public ArrayList<Tip> selectRepleList(int tip_no) {
		List<Tip> list = session.selectList("tipMapper.selectRepleList", tip_no);
		return (ArrayList<Tip>)list;
	}
	
	public int deleteTipBoard(int tip_no) {
		return session.delete("tipMapper.deleteTipBoard", tip_no);
	}
	
	public int deleteReple(Tip tip) {
		return session.delete("tipMapper.deleteReple", tip);
	}

	public int insertReple(Tip tip) {
		return session.insert("tipMapper.insertReple", tip);
	}

	public int updateReple(Tip tip) {
		return session.update("tipMapper.updateReple", tip);
	}

	public int insertReple2(Tip tip) {
		return session.insert("tipMapper.insertReple2", tip);
	}

	public int insertLikeTip(Tip tip) {
		return session.insert("tipMapper.insertLikeTip", tip);
	}

	public int updatePTipLikeNo(Tip tip) {
		return session.update("tipMapper.updatePTipLikeNo", tip);
	}

	public int deleteLikeTip(Tip tip) {
		return session.delete("tipMapper.deleteLikeTip", tip);
	}

	public int updateMTipLikeNo(Tip tip) {
		return session.update("tipMapper.updateMTipLikeNo", tip);
	}

	public LikeTip selectLikeTip(Tip tip) {
		return session.selectOne("tipMapper.selectLikeTip", tip);
	}

	public int updateMBoardCount(Tip tip) {
		return session.update("tipMapper.updateMBoardCount", tip);
	}
}
