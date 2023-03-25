package org.sixpack.semi.board.model.vo;

import java.sql.Date;

public class Board {

	private int board_no;
	private String board_title;
	private String user_id;
	private Date board_post_date;
	private int board_views;
	private String board_item;
	
	public Board() {
		super();
	}

	public Board(int board_no, String board_title, String user_id, Date board_post_date, int board_views,
			String board_item) {
		super();
		this.board_no = board_no;
		this.board_title = board_title;
		this.user_id = user_id;
		this.board_post_date = board_post_date;
		this.board_views = board_views;
		this.board_item = board_item;
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

	public Date getBoard_post_date() {
		return board_post_date;
	}

	public void setBoard_post_date(Date board_post_date) {
		this.board_post_date = board_post_date;
	}

	public int getboard_views() {
		return board_views;
	}

	public void setboard_views(int board_views) {
		this.board_views = board_views;
	}

	public String getBoard_item() {
		return board_item;
	}

	public void setBoard_item(String board_item) {
		this.board_item = board_item;
	}

	@Override
	public String toString() {
		return "AdminBoard [board_no=" + board_no + ", board_title=" + board_title + ", user_id=" + user_id
				+ ", board_post_date=" + board_post_date + ", board_views=" + board_views + ", board_item=" + board_item
				+ "]";
	}

	
}
