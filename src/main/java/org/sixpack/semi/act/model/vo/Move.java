package org.sixpack.semi.act.model.vo;

public class Move implements java.io.Serializable {
    private static final long serialVersionUID = 1507401368568522299L;
    private String move_code; //운동 일련번호
    private String move_name; //운동이름
    private double move_met; //met
    private String move_intensity; //운동강도

    public Move() {
    }
    
	public Move(String move_code, String move_name, double move_met, String move_intensity) {
		super();
		this.move_code = move_code;
		this.move_name = move_name;
		this.move_met = move_met;
		this.move_intensity = move_intensity;
	}
	@Override
	public String toString() {
		return "Move [move_code=" + move_code + ", move_name=" + move_name + ", move_met=" + move_met
				+ ", move_intensity=" + move_intensity + "]";
	}
	public String getMove_code() {
		return move_code;
	}
	public void setMove_code(String move_code) {
		this.move_code = move_code;
	}
	public String getMove_name() {
		return move_name;
	}
	public void setMove_name(String move_name) {
		this.move_name = move_name;
	}
	public double getMove_met() {
		return move_met;
	}
	public void setMove_met(double move_met) {
		this.move_met = move_met;
	}
	public String getMove_intensity() {
		return move_intensity;
	}
	public void setMove_intensity(String move_intensity) {
		this.move_intensity = move_intensity;
	}
	
    
    
}