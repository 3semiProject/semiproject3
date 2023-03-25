package org.sixpack.semi.board.model.dao;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.board.model.vo.Board;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("boardDao")
public class BoardDao {

    @Autowired
    private SqlSessionTemplate session;

    public ArrayList<Board> selectTop5() {

        List<Board> list = session.selectList("boardMapper.selectTop5");
        return (ArrayList<Board>) list;
    }

    public int selectListCount() {
        return session.selectOne("boardMapper.selectListCount");
    }

    public ArrayList<Board> selectList(Paging page) {

        List<Board> list = session.selectList("boardMapper.selectList", page);
        return (ArrayList<Board>) list;
    }


    public Board selectBoard(int boardNum) {
        return session.selectOne("boardMapper.selectBoard", boardNum);

    }


    public int insertReply(Board reply) {
        return session.insert("boardMapper.insertReply", reply);

    }

    public int insertBoard(Board board) {
        return session.insert("boardMapper.insertBoard", board);

    }

    public int updateReply(Board reply) {
        return session.update("boardMapper.updateReply", reply);

    }

    public int updateBoard(Board board) {
        return session.update("boardMapper.updateBoard", board);

    }

    public int updateReplySeq(Board reply) {
        return session.update("boardMapper.updateReplySeq", reply);
    }


    public int updateBoardReadCount(int boardNum) {
        return session.update("boardMapper.updateBoardReadCount", boardNum);

    }


    public int deleteBoard(Board board) {
        return session.delete("boardMapper.deleteBoard", board);

    }

}
