package org.sixpack.semi.board.controller;

import org.sixpack.semi.board.model.service.BoardService;
import org.sixpack.semi.board.model.vo.Board;
import org.sixpack.semi.common.Paging;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

@Controller
public class BoardController {
    private static final Logger logger =
            LoggerFactory.getLogger(BoardController.class);
    @Autowired
    private BoardService boardService;


    @RequestMapping(value = "btop5.do", method = RequestMethod.POST)
    @ResponseBody
    private String boardTop5Method() {

        ArrayList<Board> list = boardService.selectTop5();
        logger.info("ntop5.do : " + list.size());

        JSONObject sendJson = new JSONObject();
        JSONArray jarr = new JSONArray();

        for (Board board : list) {
            {
                JSONObject job = new JSONObject();
                job.put("board_num", board.getBoard_num());
                job.put("board_title", URLEncoder.encode(board.getBoard_title(), StandardCharsets.UTF_8));
                job.put("board_readcount", board.getBoard_readcount());
                jarr.add(job);
            }
        }
        sendJson.put("list", jarr);
        return sendJson.toJSONString();
    }


    @RequestMapping("blist.do")
    public ModelAndView boardListMethod(
            @RequestParam(name = "page", required = false) String page,
            ModelAndView mv) {


        int currentPage = 1;
        if (page != null) {
            currentPage = Integer.parseInt(page);
        }
        // 한 페이지에 10개씩 출력되게 한다면
        // 페이징 계산 처리 - 별도의 클래스로 작성해서 이용해도 됨

        int limit = 10;
        //전체 페이지 수 계산을 위해 게시글 총 갯수 조회
        int listCount = boardService.selectListCount();

        Paging paging = new Paging(listCount, currentPage, limit);
        paging.calculator();
        ArrayList<Board> list = boardService.selectList(paging);
        if (list != null && list.size() > 0) {
            mv.addObject("list", list);
            mv.addObject("listCount", listCount);
            mv.addObject("maxPage", paging.getMaxPage());
            mv.addObject("startPage", paging.getStartPage());
            mv.addObject("currentPage", currentPage);
            mv.addObject("endPage", paging.getEndPage());
            mv.addObject("limit", limit);

            mv.setViewName("board/boardListView");
            return mv;

        } else {
            mv.addObject("message", currentPage + "번 페이지 목록 조회 실패");

            mv.setViewName("common/error");
            return mv;
        }
    }

    @RequestMapping("bdetail.do")
    public ModelAndView boardDetailMethod(
            ModelAndView mv,
            @RequestParam("board_num") int board_num,
            @RequestParam(name = "page", required = false) String page) {
        int currentPage = 1;
        if (page != null) {
            currentPage = Integer.parseInt(page);
        }

        Board board = boardService.selectBoard(board_num);
        if (board != null) {
            boardService.updateBoardReadCount(board_num);
            mv.addObject("board", board);
            mv.addObject("currentPage", currentPage);

            mv.setViewName("board/boardDetailView");

        } else {
            mv.addObject("message", "게시글 조회 실패");

            mv.setViewName("common/error");
        }
        return mv;
    }

    @RequestMapping("breplyform.do")
    public String moveReplyForm(
            Model model,
            @RequestParam("board_num") int origin_num,
            @RequestParam("page") int current_page) {
        model.addAttribute("board_num", origin_num);
        model.addAttribute("page", current_page);

        return "board/boardReplyForm";
    }

    @RequestMapping(value = "breply.do", method = RequestMethod.POST)
    public String replyMethod(
            Model model, Board reply,
            @RequestParam("page") int current_page) {

        Board origin = boardService.selectBoard(reply.getBoard_ref());

        // 현재 등록할 댓글의 레벨을 설정
        reply.setBoard_lev(origin.getBoard_lev() + 1);

        if (reply.getBoard_lev() == 3) { // 쓴 댓글이 대댓글인경우
            reply.setBoard_ref(origin.getBoard_ref());
            reply.setBoard_reply_ref(origin.getBoard_num());
        }

        // 댓글과 대댓글은 최신글을 board_reply_seq 를 1로
        reply.setBoard_reply_seq(1);

        //기존 댓글 순번을 1 증가
        boardService.updateReplySeq(reply);
        if (boardService.insertReply(reply) > 0) {
            return "redirect:blist.do?page=" + current_page;
        } else {
            model.addAttribute("message" ,current_page+"번글 댓글 쓰기 실패");
            return "common/error";
        }
    }


}
