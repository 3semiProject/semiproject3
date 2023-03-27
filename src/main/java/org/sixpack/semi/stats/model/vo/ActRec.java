package org.sixpack.semi.stats.model.vo;

public class ActRec implements java.io.Serializable {
	private static final long serialVersionUID = -4804906935956435619L;
	
	private int rec_act_code; //코멘트 코드
	private int rec_act_lev; // 저중고 강도 확인용
	private String rec_act_title; //코멘트 글
	private String rec_act_image; //코멘트 이미지이름
	private String rec_act_link; //백과사전 링크
	public ActRec() {
		super();
	}
	public ActRec(int rec_act_code, String rec_act_title, String rec_act_image, String rec_act_link) {
		super();
		this.rec_act_code = rec_act_code;
		this.rec_act_title = rec_act_title;
		this.rec_act_image = rec_act_image;
		this.rec_act_link = rec_act_link;
	}
	@Override
	public String toString() {
		return "ActRec [rec_act_code=" + rec_act_code + ", rec_act_title=" + rec_act_title + ", rec_act_image="
				+ rec_act_image + ", rec_act_link=" + rec_act_link + "]";
	}
	public int getRec_act_code() {
		return rec_act_code;
	}
	public void setRec_act_code(int rec_act_code) {
		this.rec_act_code = rec_act_code;
	}
	public String getRec_act_title() {
		return rec_act_title;
	}
	public void setRec_act_title(String rec_act_title) {
		this.rec_act_title = rec_act_title;
	}
	public String getRec_act_image() {
		return rec_act_image;
	}
	public void setRec_act_image(String rec_act_image) {
		this.rec_act_image = rec_act_image;
	}
	public String getRec_act_link() {
		return rec_act_link;
	}
	public void setRec_act_link(String rec_act_link) {
		this.rec_act_link = rec_act_link;
	}
	
	
	
}
