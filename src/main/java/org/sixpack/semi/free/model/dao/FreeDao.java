package org.sixpack.semi.free.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.free.model.vo.Free;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("freeDao")
public class FreeDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("freeMapper.selectListCount");
	}

	public ArrayList<Free> selectList(Paging page) {
		List<Free> list = session.selectList("freeMapper.selectList", page);
		return (ArrayList<Free>)list;
	}

	public Free selectBoard(int free_no) {
		return session.selectOne("freeMapper.selectBoard", free_no);
	}

	public int updateBoardReadcount(int free_no) {
		return session.update("freeMapper.updateBoardReadcount", free_no);
	}

	public int insertBoard(Free free) {
		return session.insert("freeMapper.insertBoard", free);
	}

	public int insertReply(Free reply) {
		return session.insert("freeMapper.insertReply", reply);
	}

	public int updateReplySeq(Free reply) {
		return session.update("freeMapper.updateReplySeq", reply);
	}

	public int updateBoard(Free free) {
		return session.update("freeMapper.updateBoard", free);
	}

	public int updateReply(Free reply) {
		return session.update("freeMapper.updateReply", reply);
	}

	public int deleteBoard(Free free) {
		return session.delete("freeMapper.deleteBoard", free);
	}
	
	public ArrayList<Free> selectTop5() {
		List<Free> list = session.selectList("freeMapper.selectTop5");
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchValue(String keyword) {
		List<Free> list = session.selectList("freeMapper.selectSearchValue", keyword);
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchWriter(String keyword) {
		List<Free> list = session.selectList("freeMapper.selectSearchWriter", keyword);
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchTitle(String keyword) {
		List<Free> list = session.selectList("freeMapper.selectSearchTitle", keyword);
		return (ArrayList<Free>)list;
	}

}
