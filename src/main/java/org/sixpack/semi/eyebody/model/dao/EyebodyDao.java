package org.sixpack.semi.eyebody.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.bfaf.model.vo.Bfaf;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.eyebody.model.vo.Eyebody;
import org.sixpack.semi.eyebody.model.vo.LikeEyebody;
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
	
	public ArrayList<Eyebody> selectSearchValue(Searchs searchs) {
		List<Eyebody> list = session.selectList("eyebodyMapper.selectSearchValue", searchs);
		return (ArrayList<Eyebody>)list;
	}

	public ArrayList<Eyebody> selectSearchWriter(Searchs searchs) {
		List<Eyebody> list = session.selectList("eyebodyMapper.selectSearchWriter", searchs);
		return (ArrayList<Eyebody>)list;
	}

	public ArrayList<Eyebody> selectSearchTitle(Searchs searchs) {
		List<Eyebody> list = session.selectList("eyebodyMapper.selectSearchTitle", searchs);
		return (ArrayList<Eyebody>)list;
	}
	
	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("eyebodyMapper.selectSearchListCount", countSearch);
	}
	
	public ArrayList<Eyebody> selectRepleList(int eyebody_no) {
		List<Eyebody> list = session.selectList("eyebodyMapper.selectRepleList", eyebody_no);
		return (ArrayList<Eyebody>)list;
	}
	
	public int deleteEyebodyBoard(int eyebody_no) {
		return session.delete("eyebodyMapper.deleteEyebodyBoard", eyebody_no);
	}
	
	public int deleteReple(Eyebody eyebody) {
		return session.delete("eyebodyMapper.deleteReple", eyebody);
	}

	public int insertReple(Eyebody eyebody) {
		return session.insert("eyebodyMapper.insertReple", eyebody);
	}

	public int updateReple(Eyebody eyebody) {
		return session.update("eyebodyMapper.updateReple", eyebody);
	}

	public int insertReple2(Eyebody eyebody) {
		return session.insert("eyebodyMapper.insertReple2", eyebody);
	}

	public int insertLikeEyebody(Eyebody eyebody) {
		return session.insert("eyebodyMapper.insertLikeEyebody", eyebody);
	}

	public int updatePEyebodyLikeNo(Eyebody eyebody) {
		return session.update("eyebodyMapper.updatePEyebodyLikeNo", eyebody);
	}

	public int deleteLikeEyebody(Eyebody eyebody) {
		return session.delete("eyebodyMapper.deleteLikeEyebody", eyebody);
	}

	public int updateMEyebodyLikeNo(Eyebody eyebody) {
		return session.update("eyebodyMapper.updateMEyebodyLikeNo", eyebody);
	}

	public LikeEyebody selectLikeEyebody(Eyebody eyebody) {
		return session.selectOne("eyebodyMapper.selectLikeEyebody", eyebody);
	}

	public int updateMBoardCount(Eyebody eyebody) {
		return session.update("eyebodyMapper.updateMBoardCount", eyebody);
	}
}
