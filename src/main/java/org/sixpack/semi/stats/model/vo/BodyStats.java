package org.sixpack.semi.stats.model.vo;

public class BodyStats implements java.io.Serializable{
	private static final long serialVersionUID = -3783764109624756326L;
	private int target_weight; //목표체중
	private int current_weight; //현재체중
	private int contrast_weight;//목표까지 남은 체중
	private int increase_weight;//체중 증감량
	private int increase_fat;//체지방량 증감량
	private int increase_muscle;//골격근량 증감량
	private int increase_waistline;//허리둘레 증감량
	private int increase_bmi;//BMI 증감량
	private int increase_bmr;//BMR 증감량S
	private int min_weight;//최저 몸무게
	private int max_weight;//최고 몸무게
	private int standard_weight; //권장 몸무게 = 표준체중
	//회원정보와 조회할 기간을 전달
	//ArrayLsit<Body>로 받아서 가공후
	//화면출력할때 사용할 VO
	//체형 통계에만 쓰이는 필드
	protected BodyStats() {		
		super();
	}
	protected BodyStats(int target_weight, int current_weight, int contrast_weight, int increase_weight,
			int increase_fat, int increase_muscle, int increase_waistline, int increase_bmi, int increase_bmr,
			int min_weight, int max_weight, int standard_weight) {
		super();
		this.target_weight = target_weight;
		this.current_weight = current_weight;
		this.contrast_weight = contrast_weight;
		this.increase_weight = increase_weight;
		this.increase_fat = increase_fat;
		this.increase_muscle = increase_muscle;
		this.increase_waistline = increase_waistline;
		this.increase_bmi = increase_bmi;
		this.increase_bmr = increase_bmr;
		this.min_weight = min_weight;
		this.max_weight = max_weight;
		this.standard_weight = standard_weight;
	}
	@Override
	public String toString() {
		return "BodyStats [target_weight=" + target_weight + ", current_weight=" + current_weight + ", contrast_weight="
				+ contrast_weight + ", increase_weight=" + increase_weight + ", increase_fat=" + increase_fat
				+ ", increase_muscle=" + increase_muscle + ", increase_waistline=" + increase_waistline
				+ ", increase_bmi=" + increase_bmi + ", increase_bmr=" + increase_bmr + ", min_weight=" + min_weight
				+ ", max_weight=" + max_weight + ", standard_weight=" + standard_weight + "]";
	}
	public int getTarget_weight() {
		return target_weight;
	}
	public void setTarget_weight(int target_weight) {
		this.target_weight = target_weight;
	}
	public int getCurrent_weight() {
		return current_weight;
	}
	public void setCurrent_weight(int current_weight) {
		this.current_weight = current_weight;
	}
	public int getContrast_weight() {
		return contrast_weight;
	}
	public void setContrast_weight(int contrast_weight) {
		this.contrast_weight = contrast_weight;
	}
	public int getIncrease_weight() {
		return increase_weight;
	}
	public void setIncrease_weight(int increase_weight) {
		this.increase_weight = increase_weight;
	}
	public int getIncrease_fat() {
		return increase_fat;
	}
	public void setIncrease_fat(int increase_fat) {
		this.increase_fat = increase_fat;
	}
	public int getIncrease_muscle() {
		return increase_muscle;
	}
	public void setIncrease_muscle(int increase_muscle) {
		this.increase_muscle = increase_muscle;
	}
	public int getIncrease_waistline() {
		return increase_waistline;
	}
	public void setIncrease_waistline(int increase_waistline) {
		this.increase_waistline = increase_waistline;
	}
	public int getIncrease_bmi() {
		return increase_bmi;
	}
	public void setIncrease_bmi(int increase_bmi) {
		this.increase_bmi = increase_bmi;
	}
	public int getIncrease_bmr() {
		return increase_bmr;
	}
	public void setIncrease_bmr(int increase_bmr) {
		this.increase_bmr = increase_bmr;
	}
	public int getMin_weight() {
		return min_weight;
	}
	public void setMin_weight(int min_weight) {
		this.min_weight = min_weight;
	}
	public int getMax_weight() {
		return max_weight;
	}
	public void setMax_weight(int max_weight) {
		this.max_weight = max_weight;
	}
	public int getStandard_weight() {
		return standard_weight;
	}
	public void setStandard_weight(int standard_weight) {
		this.standard_weight = standard_weight;
	}
	

}
