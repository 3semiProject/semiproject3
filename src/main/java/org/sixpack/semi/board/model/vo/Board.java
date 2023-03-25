package org.sixpack.semi.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board implements java.io.Serializable {
	private static final long serialVersionUID = -5760196298931028886L;

	private int board_num;			//게시글 번호
	private String board_writer;		//게시글 작성자 아이디
	private String board_title;		//게시글 제목
	private String board_content;	//게시글 내용
	private String board_original_filename;	//첨부파일 원래이름
	private String board_rename_filename;		//첨부파일 바뀐이름
	private int board_ref;			//참조 원글번호
	private int board_reply_ref;		//참조 댓글번호
	private int board_lev;		//글레벨(원글:1, 댓글:2, 대댓글:3)
	private int board_reply_seq;	//댓글 순번
	private int board_readcount;	//조회수
	private java.sql.Date board_date;	//게시글 등록날짜
	
}
