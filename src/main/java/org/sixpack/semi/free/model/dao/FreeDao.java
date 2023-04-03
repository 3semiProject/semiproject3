package org.sixpack.semi.free.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.vo.Free;
import org.sixpack.semi.free.model.vo.LikeFree;
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

	public int deleteFreeBoard(int free_no) {
		return session.delete("freeMapper.deleteFreeBoard", free_no);
	}

	public ArrayList<Free> selectTop5() {
		List<Free> list = session.selectList("freeMapper.selectTop5");
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchValue(Searchs searchs) {
		List<Free> list = session.selectList("freeMapper.selectSearchValue", searchs);
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchWriter(Searchs searchs) {
		List<Free> list = session.selectList("freeMapper.selectSearchWriter", searchs);
		return (ArrayList<Free>)list;
	}

	public ArrayList<Free> selectSearchTitle(Searchs searchs) {
		List<Free> list = session.selectList("freeMapper.selectSearchTitle", searchs);
		return (ArrayList<Free>)list;
	}

	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("freeMapper.selectSearchListCount", countSearch);
	}

	public ArrayList<Free> selectRepleList(int free_no) {
		List<Free> list = session.selectList("freeMapper.selectRepleList", free_no);
		return (ArrayList<Free>)list;
	}

	public int deleteBoard(Free free) {
		return session.delete("freeMapper.deleteBoard", free);
	}

	public int deleteReple(Free free) {
		return session.delete("freeMapper.deleteReple", free);
	}

	public int insertReple(Free free) {
		return session.insert("freeMapper.insertReple", free);
	}

	public int updateReple(Free free) {
		return session.update("freeMapper.updateReple", free);
	}

	public int insertReple2(Free free) {
		return session.insert("freeMapper.insertReple2", free);
	}

	public int insertLikeFree(Free free) {
		return session.insert("freeMapper.insertLikeFree", free);
	}

	public int updatePFreeLikeNo(Free free) {
		return session.update("freeMapper.updatePFreeLikeNo", free);
	}

	public int deleteLikeFree(Free free) {
		return session.delete("freeMapper.deleteLikeFree", free);
	}

	public int updateMFreeLikeNo(Free free) {
		return session.update("freeMapper.updateMFreeLikeNo", free);
	}

	public LikeFree selectLikeFree(Free free) {
		return session.selectOne("freeMapper.selectLikeFree", free);
	}

	public int updateMBoardCount(Free free) {
		return session.update("freeMapper.updateMBoardCount", free);
	}
}
