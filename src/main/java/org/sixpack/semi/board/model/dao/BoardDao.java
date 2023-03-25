package org.sixpack.semi.board.model.dao;

import java.sql.Date;
import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.board.model.vo.Board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDao {

	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Board> selectBoardOneList(String board_item) {
		// TODO Auto-generated method stub
		return null;
	}

	public Date selectSearchPost(Date date) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Board> selectSearchKeyword(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

	public int deleteBoard(int board_no) {
		// TODO Auto-generated method stub
		return 0;
	}
}
