package org.sixpack.semi.eat.model.vo;

public class Eat implements java.io.Serializable{
	private static final long serialVersionUID = -8752520660149781460L;
	private String diary_no; 		//다이어리번호
	private String eat_seq; 		//식단 순번
	private String food_code; 		//음식 일련번호
	private int eat_g; 				//섭취한 양(g)
	private int eat_kcal; 			//섭취칼로리량(kcal)
	private int eat_carbohydrate; 	//섭취한 탄수화물(g)
	private int eat_protein; 		//섭취한 단백질(g)
	private int eat_fat; 			//섭취한지방(g)
	
	
	public Eat() {
		super();
	}
	
	public Eat(String diary_no, String eat_seq, String food_code, int eat_g, int eat_kcal, int eat_carbohydrate,
			int eat_protein, int eat_fat) {
		super();
		this.diary_no = diary_no;
		this.eat_seq = eat_seq;
		this.food_code = food_code;
		this.eat_g = eat_g;
		this.eat_kcal = eat_kcal;
		this.eat_carbohydrate = eat_carbohydrate;
		this.eat_protein = eat_protein;
		this.eat_fat = eat_fat;
	}

	@Override
	public String toString() {
		return "Eat [diary_no=" + diary_no + ", eat_seq=" + eat_seq + ", food_code=" + food_code + ", eat_g=" + eat_g
				+ ", eat_kcal=" + eat_kcal + ", eat_carbohydrate=" + eat_carbohydrate + ", eat_protein=" + eat_protein
				+ ", eat_fat=" + eat_fat + "]";
	}

	public String getDiary_no() {
		return diary_no;
	}
	public void setDiary_no(String diary_no) {
		this.diary_no = diary_no;
	}
	public String getEat_no() {
		return eat_seq;
	}
	public void setEat_no(String eat_seq) {
		this.eat_seq = eat_seq;
	}
	public String getFood_no() {
		return food_code;
	}
	public void setFood_no(String food_code) {
		this.food_code = food_code;
	}
	public int getEat_g() {
		return eat_g;
	}
	public void setEat_g(int eat_g) {
		this.eat_g = eat_g;
	}
	public int getEat_kcal() {
		return eat_kcal;
	}
	public void setEat_kcal(int eat_kcal) {
		this.eat_kcal = eat_kcal;
	}
	public int getEat_carbohydrate() {
		return eat_carbohydrate;
	}
	public void setEat_carbohydrate(int eat_carbohydrate) {
		this.eat_carbohydrate = eat_carbohydrate;
	}
	public int getEat_protein() {
		return eat_protein;
	}
	public void setEat_protein(int eat_protein) {
		this.eat_protein = eat_protein;
	}
	public int getEat_fat() {
		return eat_fat;
	}
	public void setEat_fat(int eat_fat) {
		this.eat_fat = eat_fat;
	}
	
}
