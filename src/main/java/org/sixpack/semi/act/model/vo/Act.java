package org.sixpack.semi.act.model.vo;

public class Act implements java.io.Serializable{	
	private static final long serialVersionUID = -1122694301283848688L;
	
	private String diary_no;	//다이어리번호
	private String act_seq;		//운동 순번
	private String move_code; 	//운동 일련번호
	private int act_mm; 		//운동한 시간(m)
	private int act_kcal; 		//소모칼로리량(kcal)
	private String move_name;	//운동 이름
	
	protected Act() {
		super();	
	}

	protected Act(String diary_no, String act_seq, String move_code, int act_mm, int act_kcal, String move_name) {
		super();
		this.diary_no = diary_no;
		this.act_seq = act_seq;
		this.move_code = move_code;
		this.act_mm = act_mm;
		this.act_kcal = act_kcal;
		this.move_name = move_name;
	}

	@Override
	public String toString() {
		return "Act [diary_no=" + diary_no + ", act_seq=" + act_seq + ", move_code=" + move_code + ", act_mm=" + act_mm
				+ ", act_kcal=" + act_kcal + ", move_name=" + move_name + "]";
	}

	public String getDiary_no() {
		return diary_no;
	}

	public void setDiary_no(String diary_no) {
		this.diary_no = diary_no;
	}

	public String getAct_seq() {
		return act_seq;
	}

	public void setAct_seq(String act_seq) {
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

	public String getMove_name() {
		return move_name;
	}

	public void setMove_name(String move_name) {
		this.move_name = move_name;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}






