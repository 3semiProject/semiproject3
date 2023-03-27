package org.sixpack.semi.eat.model.vo;

public class Food implements java.io.Serializable{
	private static final long serialVersionUID = -7185772055734391529L;

	private String food_code;	//음식 일련번호
	private String food_name;	//음식이름
	private int food_kcal;	//열량(kcal)
	private int food_carbohydrate;	//탄수화물 (g)
	private int food_protein;	//단백질 (g)
	private int food_fat;	//지방 (g)
	private int food_cholesterol;	//콜레스테롤 (g)
	private int food_roughage;	//식이섬유 (g)
	private int food_vitamin;	//비타민c (g)
	
	protected Food() {
		super();
	}
	protected Food(String food_code, String food_name, int food_kcal, int food_carbohydrate, int food_protein,
			int food_fat, int food_cholesterol, int food_roughage, int food_vitamin) {
		super();
		this.food_code = food_code;
		this.food_name = food_name;
		this.food_kcal = food_kcal;
		this.food_carbohydrate = food_carbohydrate;
		this.food_protein = food_protein;
		this.food_fat = food_fat;
		this.food_cholesterol = food_cholesterol;
		this.food_roughage = food_roughage;
		this.food_vitamin = food_vitamin;
	}
	@Override
	public String toString() {
		return "Food [food_code=" + food_code + ", food_name=" + food_name + ", food_kcal=" + food_kcal
				+ ", food_carbohydrate=" + food_carbohydrate + ", food_protein=" + food_protein + ", food_fat="
				+ food_fat + ", food_cholesterol=" + food_cholesterol + ", food_roughage=" + food_roughage
				+ ", food_vitamin=" + food_vitamin + "]";
	}
	public String getFood_no() {
		return food_code;
	}
	public void setFood_no(String food_code) {
		this.food_code = food_code;
	}
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	public int getFood_kcal() {
		return food_kcal;
	}
	public void setFood_kcal(int food_kcal) {
		this.food_kcal = food_kcal;
	}
	public int getFood_carbohydrate() {
		return food_carbohydrate;
	}
	public void setFood_carbohydrate(int food_carbohydrate) {
		this.food_carbohydrate = food_carbohydrate;
	}
	public int getFood_protein() {
		return food_protein;
	}
	public void setFood_protein(int food_protein) {
		this.food_protein = food_protein;
	}
	public int getFood_fat() {
		return food_fat;
	}
	public void setFood_fat(int food_fat) {
		this.food_fat = food_fat;
	}
	public int getFood_cholesterol() {
		return food_cholesterol;
	}
	public void setFood_cholesterol(int food_cholesterol) {
		this.food_cholesterol = food_cholesterol;
	}
	public int getFood_roughage() {
		return food_roughage;
	}
	public void setFood_roughage(int food_roughage) {
		this.food_roughage = food_roughage;
	}
	public int getFood_vitamin() {
		return food_vitamin;
	}
	public void setFood_vitamin(int food_vitamin) {
		this.food_vitamin = food_vitamin;
	}
	
}
