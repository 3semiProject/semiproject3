package org.sixpack.semi.notice.model.vo;

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
public class Notice implements java.io.Serializable {
	private static final long serialVersionUID = -236616028496183775L;

	private int noticeno;
	private String noticetitle;
	private java.sql.Date noticedate;
	private String noticewriter;
	private String noticecontent;
	private String original_filepath;
	private String rename_filepath;	
}
