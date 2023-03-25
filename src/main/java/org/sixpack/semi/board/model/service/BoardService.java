package org.sixpack.semi.board.model.service;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.board.model.vo.Board;

import java.util.ArrayList;

public interface BoardService {
    ArrayList<Board> selectTop5();

    int selectListCount();

    ArrayList<Board> selectList(Paging page);


    Board selectBoard(int board_num);

    int updateBoardReadCount(int board_num);

    int insertBoard(Board board);

    int insertReply(Board reply);

    int updateReplySeq(Board reply);

    int updateBoard(Board board);

    int updateReply(Board reply);

    int deleteBoard(Board board);
}
