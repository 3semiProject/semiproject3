package org.sixpack.semi.board.model.service;

import java.sql.Date;
import java.util.ArrayList;

import org.sixpack.semi.board.model.dao.BoardDao;
import org.sixpack.semi.board.model.vo.Board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public ArrayList<Board> selectBoardOneList(String board_item) {
		return boardDao.selectBoardOneList(board_item);
	}

	@Override
	public Date selectSearchPost(Date date) {
		return boardDao.selectSearchPost(date);
	}

	@Override
	public ArrayList<Board> selectSearchKeyword(String keyword) {
		return boardDao.selectSearchKeyword(keyword);
	}

	@Override
	public int deleteBoard(int board_no) {
		return boardDao.deleteBoard(board_no);
	}
}
