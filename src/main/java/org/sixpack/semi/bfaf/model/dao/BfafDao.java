package org.sixpack.semi.bfaf.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.common.Paging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bfafDao")

public class BfafDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("bfafMapper.selectListCount");
	}

	public ArrayList<Bfaf> selectList(Paging page) {
		List<Bfaf> list = session.selectList("bfafMapper.selectList", page);
		return (ArrayList<Bfaf>)list;
	}

	public Bfaf selectBoard(int bfaf_no) {
		return session.selectOne("bfafMapper.selectBoard", bfaf_no);
	}

	public int updateBoardReadcount(int bfaf_no) {
		return session.update("bfafMapper.updateBoardReadcount", bfaf_no);
	}

	public int insertBoard(Bfaf bfaf) {
		return session.insert("bfafMapper.insertBoard", bfaf);
	}

	public int insertReply(Bfaf reply) {
		return session.insert("bfafMapper.insertReply", reply);
	}

	public int updateReplySeq(Bfaf reply) {
		return session.update("bfafMapper.updateReplySeq", reply);
	}

	public int updateBoard(Bfaf bfaf) {
		return session.update("bfafMapper.updateBoard", bfaf);
	}

	public int updateReply(Bfaf reply) {
		return session.update("bfafMapper.updateReply", reply);
	}

	public int deleteBoard(Bfaf bfaf) {
		return session.delete("bfafMapper.deleteBoard", bfaf);
	}
}
