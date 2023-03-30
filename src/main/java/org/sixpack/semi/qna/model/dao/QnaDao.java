package org.sixpack.semi.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
import org.sixpack.semi.qna.model.vo.Qna;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("qnaDao")
public class QnaDao {
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("qnaMapper.selectListCount");
	}

	public ArrayList<Qna> selectList(Paging page) {
		List<Qna> list = session.selectList("qnaMapper.selectList", page);
		return (ArrayList<Qna>)list;
	}

	public Qna selectQna(int qna_no) {
		return session.selectOne("qnaMapper.selectQna", qna_no);
	}

	public int updateQnaReadcount(int qna_no) {
		return session.update("qnaMapper.updateQnaReadcount", qna_no);
	}

	public int insertQna(Qna qna) {
		return session.insert("qnaMapper.insertQna", qna);
	}

	public int updateQna(Qna qna) {
		return session.update("qnaMapper.updateQna", qna);
	}

	public int deleteQna(int qna_no) {
		return session.delete("qnaMapper.deleteQna", qna_no);
	}

	public ArrayList<Qna> selectSearchTitle(Searchs searchs) {
		List<Qna> list = session.selectList("qnaMapper.selectSearchTitle", searchs);
		return (ArrayList<Qna>)list;
	}

	public ArrayList<Qna> selectSearchWriter(Searchs searchs) {
		List<Qna> list = session.selectList("qnaMapper.selectSearchWriter", searchs);
		return (ArrayList<Qna>)list;
	}

	public ArrayList<Qna> selectSearchContent(Searchs searchs) {
		List<Qna> list = session.selectList("qnaMapper.selectSearchContent", searchs);
		return (ArrayList<Qna>)list;
	}

	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("qnaMapper.selectSearchListCount", countSearch);
	}

	
}
