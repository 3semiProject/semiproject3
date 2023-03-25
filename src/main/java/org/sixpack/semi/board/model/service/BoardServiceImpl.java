package org.sixpack.semi.board.model.service;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.board.model.dao.BoardDao;
import org.sixpack.semi.board.model.vo.Board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
    @Autowired
    private BoardDao bdao = new BoardDao();

    @Override
    public ArrayList<Board> selectTop5() {
        return bdao.selectTop5();
    }

    @Override
    public int selectListCount() {
        return bdao.selectListCount();
    }

    @Override
    public ArrayList<Board> selectList(Paging page) {
        return bdao.selectList(page);
    }

    @Override
    public Board selectBoard(int board_num) {
        return bdao.selectBoard(board_num);
    }

    @Override
    public int updateBoardReadCount(int board_num) {
        return bdao.updateBoardReadCount(board_num);
    }

    @Override
    public int insertBoard(Board board) {
        return bdao.insertBoard(board);
    }

    @Override
    public int insertReply(Board reply) {
        return bdao.insertReply(reply);
    }

    @Override
    public int updateReplySeq(Board reply) {
        return bdao.updateReplySeq(reply);
    }

    @Override
    public int updateBoard(Board board) {
        return bdao.updateBoard(board);
    }

    @Override
    public int updateReply(Board reply) {
        return bdao.updateReply(reply);
    }

    @Override
    public int deleteBoard(Board board) {
        return bdao.deleteBoard(board);
    }
}
