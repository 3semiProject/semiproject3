package org.sixpack.semi.act.model.vo;

public class Act implements java.io.Serializable{	
	private static final long serialVersionUID = 4602927908043346943L;
	//4.9 수정 : act_seq : int
	private int diary_no;	//다이어리번호
	private int act_seq;		//운동 순번
	private String move_code; 	//운동 일련번호 : 출력시에는 운동이름
	private int act_mm; 		//운동한 시간(m)
	private int act_kcal; 		//소모칼로리량(kcal)
	
	public Act() {
		super();
	}
	
	public Act(int diary_no, int act_seq, String move_code, int act_mm, int act_kcal) {
		super();
		this.diary_no = diary_no;
		this.act_seq = act_seq;
		this.move_code = move_code;
		this.act_mm = act_mm;
		this.act_kcal = act_kcal;
	}
	@Override
	public String toString() {
		return "Act [diary_no=" + diary_no + ", act_seq=" + act_seq + ", move_code=" + move_code + ", act_mm=" + act_mm
				+ ", act_kcal=" + act_kcal + "]";
	}
	public int getDiary_no() {
		return diary_no;
	}
	public void setDiary_no(int diary_no) {
		this.diary_no = diary_no;
	}
	public int getAct_seq() {
		return act_seq;
	}
	public void setAct_seq(int act_seq) {
		this.act_seq = act_seq;
	}
	public String getMove_code() {
		return move_code;
	}
	public void setMove_code(String move_code) {
		this.move_code = move_code;
	}
	public int getAct_mm() {
		return act_mm;
	}
	public void setAct_mm(int act_mm) {
		this.act_mm = act_mm;
	}
	public int getAct_kcal() {
		return act_kcal;
	}
	public void setAct_kcal(int act_kcal) {
		this.act_kcal = act_kcal;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	


}






