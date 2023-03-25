package org.sixpack.semi.board.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.board.model.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService BoardService;
	
	@RequestMapping("selectBoardOneList.do")
	public String selectBoardOneMethod(String board_item, Model model) {
		return null;
	}
	
	@RequestMapping("selectSearchPost.do")
	public String BoardSearchPostMethod(Date date, Model model) {
		return null;
	}
	
	@RequestMapping("selectSearchKeyword.do")
	public String BoardSearchKeywordMethod(@RequestParam("keyword") String keyword, Model model) {
		return null;
	}
	
	@RequestMapping("selectBoardDetail.do")
	public String BoardDetailMethod(@RequestParam("board_no") int notice_no, Model model, HttpSession session) {
		return null;
	}
	
	@RequestMapping("deleteBoard.do")
	public String deleteBoardMethod(@RequestParam("board_no") int board_no, @RequestParam(name="rfile", required = false) String renameFileName,
            Model model, HttpServletRequest request) {
		return null;
	}
	
	
	
}
