package org.sixpack.semi.body.model.vo;

public class Body implements java.io.Serializable{

	private static final long serialVersionUID = -1367031958131982741L;
	
	private String diary_no;				 //다이어리번호
	private int body_weight;				 //체중(kg)
	private String body_weight_rating;		 //체중 평가
	private int body_fat;					 //체지방량(g)
	private int body_muscle;				 //골격근량(g)
	private int body_waistline;				 //허리둘레(cm)
	private int body_bmi;					 //계산된 bmi
	private int body_bmr;					 //계산된 bmr(kcal)
	
	private String body_fat_rating;			 //체지방 평가
	private String body_muscle_rating;		 //골격근량 평가
	private String body_waistline_rating;	 //허리둘레 평가
	private String body_bmi_rating;			 //bmi 평가
	
	public String getMuscleRating() {
		//가지고 있는 int값으로 Stirng 평가내용을 설정해줌
		//추가로 필요한 변수는 성별(member), 표준체중(goal)
		return "표준";
	}
		
	public Body() {
		super();
	}
	public Body(String diary_no, int body_weight, String body_weight_rating, int body_fat, String body_fat_rating,
			int body_muscle, String body_muscle_rating, int body_waistline, String body_waistline_rating, int body_bmi,
			String body_bmi_rating, int body_bmr) {
		super();
		this.diary_no = diary_no;
		this.body_weight = body_weight;
		this.body_weight_rating = body_weight_rating;
		this.body_fat = body_fat;
		this.body_fat_rating = body_fat_rating;
		this.body_muscle = body_muscle;
		this.body_muscle_rating = body_muscle_rating;
		this.body_waistline = body_waistline;
		this.body_waistline_rating = body_waistline_rating;
		this.body_bmi = body_bmi;
		this.body_bmi_rating = body_bmi_rating;
		this.body_bmr = body_bmr;
	}
	@Override
	public String toString() {
		return "Body [diary_no=" + diary_no + ", body_weight=" + body_weight + ", body_weight_rating="
				+ body_weight_rating + ", body_fat=" + body_fat + ", body_fat_rating=" + body_fat_rating
				+ ", body_muscle=" + body_muscle + ", body_muscle_rating=" + body_muscle_rating + ", body_waistline="
				+ body_waistline + ", body_waistline_rating=" + body_waistline_rating + ", body_bmi=" + body_bmi
				+ ", body_bmi_rating=" + body_bmi_rating + ", body_bmr=" + body_bmr + "]";
	}
	public String getDiary_no() {
		return diary_no;
	}
	public void setDiary_no(String diary_no) {
		this.diary_no = diary_no;
	}
	public int getBody_weight() {
		return body_weight;
	}
	public void setBody_weight(int body_weight) {
		this.body_weight = body_weight;
	}
	public String getBody_weight_rating() {
		return body_weight_rating;
	}
	public void setBody_weight_rating(String body_weight_rating) {
		this.body_weight_rating = body_weight_rating;
	}
	public int getBody_fat() {
		return body_fat;
	}
	public void setBody_fat(int body_fat) {
		this.body_fat = body_fat;
	}
	public String getBody_fat_rating() {
		return body_fat_rating;
	}
	public void setBody_fat_rating(String body_fat_rating) {
		this.body_fat_rating = body_fat_rating;
	}
	public int getBody_muscle() {
		return body_muscle;
	}
	public void setBody_muscle(int body_muscle) {
		this.body_muscle = body_muscle;
	}
	public String getBody_muscle_rating() {
		return body_muscle_rating;
	}
	public void setBody_muscle_rating(String body_muscle_rating) {
		this.body_muscle_rating = body_muscle_rating;
	}
	public int getBody_waistline() {
		return body_waistline;
	}
	public void setBody_waistline(int body_waistline) {
		this.body_waistline = body_waistline;
	}
	public String getBody_waistline_rating() {
		return body_waistline_rating;
	}
	public void setBody_waistline_rating(String body_waistline_rating) {
		this.body_waistline_rating = body_waistline_rating;
	}
	public int getBody_bmi() {
		return body_bmi;
	}
	public void setBody_bmi(int body_bmi) {
		this.body_bmi = body_bmi;
	}
	public String getBody_bmi_rating() {
		return body_bmi_rating;
	}
	public void setBody_bmi_rating(String body_bmi_rating) {
		this.body_bmi_rating = body_bmi_rating;
	}
	public int getBody_bmr() {
		return body_bmr;
	}
	public void setBody_bmr(int body_bmr) {
		this.body_bmr = body_bmr;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

	
	
}
