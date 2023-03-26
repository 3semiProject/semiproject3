package org.sixpack.semi.eyebody.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("eyebodyDao")

public class EyebodyDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("eyebodyMapper.selectListCount");
	}

	public ArrayList<Eyebody> selectList(Paging page) {
		List<Eyebody> list = session.selectList("eyebodyMapper.selectList", page);
		return (ArrayList<Eyebody>)list;
	}

	public Eyebody selectBoard(int eyebody_no) {
		return session.selectOne("eyebodyMapper.selectBoard", eyebody_no);
	}

	public int updateBoardReadcount(int eyebody_no) {
		return session.update("eyebodyMapper.updateBoardReadcount", eyebody_no);
	}

	public int insertBoard(Eyebody eyebody) {
		return session.insert("eyebodyMapper.insertBoard", eyebody);
	}

	public int insertReply(Eyebody reply) {
		return session.insert("eyebodyMapper.insertReply", reply);
	}

	public int updateReplySeq(Eyebody reply) {
		return session.update("eyebodyMapper.updateReplySeq", reply);
	}

	public int updateBoard(Eyebody eyebody) {
		return session.update("eyebodyMapper.updateBoard", eyebody);
	}

	public int updateReply(Eyebody reply) {
		return session.update("eyebodyMapper.updateReply", reply);
	}

	public int deleteBoard(Eyebody eyebody) {
		return session.delete("eyebodyMapper.deleteBoard", eyebody);
	}
}
