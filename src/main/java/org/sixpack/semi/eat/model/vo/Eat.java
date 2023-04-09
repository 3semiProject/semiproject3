package org.sixpack.semi.eat.model.vo;
//4.9수정 :  다이어리번호,eat_seq int로 수정 -> sql문 수정
public class Eat implements java.io.Serializable{
	private static final long serialVersionUID = -8752520660149781460L;
	private int diary_no; 		//다이어리번호
	private int eat_seq; 		//식단 순번
	private String food_code; 		//음식 일련번호 or 이름
	private int eat_g; 				//섭취한 양(g)
	private int eat_kcal; 			//섭취칼로리량(kcal)
	private int eat_carbohydrate; 	//섭취한 탄수화물(g)
	private int eat_protein; 		//섭취한 단백질(g)
	private int eat_fat; 			//섭취한지방(g)
	
	public Eat() {
		super();
	}

	public Eat(int diary_no, int eat_seq, String food_code, int eat_g, int eat_kcal, int eat_carbohydrate,
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

	public int getDiary_no() {
		return diary_no;
	}

	public void setDiary_no(int diary_no) {
		this.diary_no = diary_no;
	}

	public int getEat_seq() {
		return eat_seq;
	}

	public void setEat_seq(int eat_seq) {
		this.eat_seq = eat_seq;
	}

	public String getFood_code() {
		return food_code;
	}


	public void setFood_code(String food_code) {
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


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	


	
}
