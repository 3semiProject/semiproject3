package org.sixpack.semi.bfaf.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.bfaf.model.vo.LikeBfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.free.model.vo.Free;
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
	
	public ArrayList<Bfaf> selectSearchValue(Searchs searchs) {
		List<Bfaf> list = session.selectList("bfafMapper.selectSearchValue", searchs);
		return (ArrayList<Bfaf>)list;
	}

	public ArrayList<Bfaf> selectSearchWriter(Searchs searchs) {
		List<Bfaf> list = session.selectList("bfafMapper.selectSearchWriter", searchs);
		return (ArrayList<Bfaf>)list;
	}

	public ArrayList<Bfaf> selectSearchTitle(Searchs searchs) {
		List<Bfaf> list = session.selectList("bfafMapper.selectSearchTitle", searchs);
		return (ArrayList<Bfaf>)list;
	}
	
	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("bfafMapper.selectSearchListCount", countSearch);
	}
	
	public ArrayList<Bfaf> selectRepleList(int bfaf_no) {
		List<Bfaf> list = session.selectList("bfafMapper.selectRepleList", bfaf_no);
		return (ArrayList<Bfaf>)list;
	}
	
	public int deleteBfafBoard(int bfaf_no) {
		return session.delete("bfafMapper.deleteBfafBoard", bfaf_no);
	}
	
	public int deleteReple(Bfaf bfaf) {
		return session.delete("bfafMapper.deleteReple", bfaf);
	}

	public int insertReple(Bfaf bfaf) {
		return session.insert("bfafMapper.insertReple", bfaf);
	}

	public int updateReple(Bfaf bfaf) {
		return session.update("bfafMapper.updateReple", bfaf);
	}

	public int insertReple2(Bfaf bfaf) {
		return session.insert("bfafMapper.insertReple2", bfaf);
	}

	public int insertLikeBfaf(Bfaf bfaf) {
		return session.insert("bfafMapper.insertLikeBfaf", bfaf);
	}

	public int updatePBfafLikeNo(Bfaf bfaf) {
		return session.update("bfafMapper.updatePBfafLikeNo", bfaf);
	}

	public int deleteLikeBfaf(Bfaf bfaf) {
		return session.delete("bfafMapper.deleteLikeBfaf", bfaf);
	}

	public int updateMBfafLikeNo(Bfaf bfaf) {
		return session.update("bfafMapper.updateMBfafLikeNo", bfaf);
	}

	public LikeBfaf selectLikeBfaf(Bfaf bfaf) {
		return session.selectOne("bfafMapper.selectLikeBfaf", bfaf);
	}

	public int updateMBoardCount(Bfaf bfaf) {
		return session.update("bfafMapper.updateMBoardCount", bfaf);
	}
}
