package org.sixpack.semi.stats.model.vo;

public class EatStats implements java.io.Serializable{

	private static final long serialVersionUID = 4109721404398390725L;
	private int rec_eat; // 권장 섭취kcal
	private int avg_eat; // 평균 섭취kcal
	private int contrast_eat; // 대비 kcal
	private int tan_rage; // 탄수화물 섭취비율
	private int dan_rage; // 단백질 섭취비율
	private int zi_rage; // 지방 섭취비율
	private String many_foodfile; // 가장자주 먹은 식단 이미지
	private String maxKcal_foodfile; // 총kcal 가장 높은 식단의 이미지
	private String minKcal_foodfile; // 총kcal 가장 낮은 식단의 이미지

	//회원정보와 조회할 기간을 전달
	//ArrayLsit<Eat>로 받아서 가공후
	//화면출력할때 사용할 VO
	
	// 식단 통계에만 쓰이는 필드
	// 음식 메뉴를 등록한 다이어리중, 등록된 메뉴 수가 가장 적은 다이어리의 이미지로 추출
	
	protected EatStats() {
		super();
	}
	protected EatStats(int rec_eat, int avg_eat, int contrast_eat, int tan_rage, int dan_rage, int zi_rage,
			String many_foodfile, String maxKcal_foodfile, String minKcal_foodfile) {
		super();
		this.rec_eat = rec_eat;
		this.avg_eat = avg_eat;
		this.contrast_eat = contrast_eat;
		this.tan_rage = tan_rage;
		this.dan_rage = dan_rage;
		this.zi_rage = zi_rage;
		this.many_foodfile = many_foodfile;
		this.maxKcal_foodfile = maxKcal_foodfile;
		this.minKcal_foodfile = minKcal_foodfile;
	}
	@Override
	public String toString() {
		return "EatStats [rec_eat=" + rec_eat + ", avg_eat=" + avg_eat + ", contrast_eat=" + contrast_eat
				+ ", tan_rage=" + tan_rage + ", dan_rage=" + dan_rage + ", zi_rage=" + zi_rage + ", many_foodfile="
				+ many_foodfile + ", maxKcal_foodfile=" + maxKcal_foodfile + ", minKcal_foodfile=" + minKcal_foodfile
				+ "]";
	}
	public int getRec_eat() {
		return rec_eat;
	}
	public void setRec_eat(int rec_eat) {
		this.rec_eat = rec_eat;
	}
	public int getAvg_eat() {
		return avg_eat;
	}
	public void setAvg_eat(int avg_eat) {
		this.avg_eat = avg_eat;
	}
	public int getContrast_eat() {
		return contrast_eat;
	}
	public void setContrast_eat(int contrast_eat) {
		this.contrast_eat = contrast_eat;
	}
	public int getTan_rage() {
		return tan_rage;
	}
	public void setTan_rage(int tan_rage) {
		this.tan_rage = tan_rage;
	}
	public int getDan_rage() {
		return dan_rage;
	}
	public void setDan_rage(int dan_rage) {
		this.dan_rage = dan_rage;
	}
	public int getZi_rage() {
		return zi_rage;
	}
	public void setZi_rage(int zi_rage) {
		this.zi_rage = zi_rage;
	}
	public String getMany_foodfile() {
		return many_foodfile;
	}
	public void setMany_foodfile(String many_foodfile) {
		this.many_foodfile = many_foodfile;
	}
	public String getMaxKcal_foodfile() {
		return maxKcal_foodfile;
	}
	public void setMaxKcal_foodfile(String maxKcal_foodfile) {
		this.maxKcal_foodfile = maxKcal_foodfile;
	}
	public String getMinKcal_foodfile() {
		return minKcal_foodfile;
	}
	public void setMinKcal_foodfile(String minKcal_foodfile) {
		this.minKcal_foodfile = minKcal_foodfile;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

}
