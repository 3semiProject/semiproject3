package org.sixpack.semi.member.model.vo;

import java.sql.Date;

public class AllBoardList {
	
	private int board_no;
	private String board_title;
	private String user_id;
	private String board_content;
	private int category;
	
	public AllBoardList() {
		
	}

	public AllBoardList(int board_no, String board_title, String user_id, String board_content, int category) {
		super();
		this.board_no = board_no;
		this.board_title = board_title;
		this.user_id = user_id;
		this.board_content = board_content;
		this.category = category;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "AllBoardList [board_no=" + board_no + ", board_title=" + board_title + ", user_id=" + user_id
				+ ", board_content=" + board_content + ", category=" + category + "]";
	}

	
	
	
}
