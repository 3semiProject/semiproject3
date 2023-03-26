package org.sixpack.semi.tip.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.tip.model.vo.Tip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
		return session.selectOne("TipMapper.selectBoard", tip_no);
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
}
