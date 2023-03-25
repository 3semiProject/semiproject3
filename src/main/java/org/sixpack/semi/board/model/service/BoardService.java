package org.sixpack.semi.board.model.service;

import java.sql.Date;
import java.util.ArrayList;

import org.sixpack.semi.board.model.vo.Board;


public interface BoardService {
	
	ArrayList<Board> selectBoardOneList(String board_item);
	Date selectSearchPost(Date date);
	ArrayList<Board> selectSearchKeyword(String keyword);
	int deleteBoard(int board_no);
}
