package org.sixpack.semi.stats.model.vo;

public class ActStats implements java.io.Serializable{
	private static final long serialVersionUID = -4551156690758679866L;	
	private int tot_act_val; 		//총 운동 횟수 	  
	private int tot_act_time; 		//총 운동 시간
	private int avg_act_time; 		//평균 운동시간대      
	private int avg_act_one; 		//1회 평균 운동시간(분)    
	private int avg_weak;			//저강도 비율   
	private int tot_weak_time;   	//저강도 총시간(분)
	private int avg_middle; 		//중강도 비율
	private int tot_middle_time; 	//중강도 총시간(분)
	private int avg_strong;  		//고강도 비율
	private int tot_strongTime;		//고강도 총시간(분) 
	
	private String many_actName; 	//가장 많이한 운동 :  
	private String maxKcal_actName; //최대 소모 kcal 운동이름 : 한번인지 총합인지 
	private String minKcal_actName; //가장 오래한 운동이름
	
	protected ActStats() {
		super();
	}
	protected ActStats(int tot_act_val, int tot_act_time, int avg_act_time, int avg_act_one, int avg_weak,
			int tot_weak_time, int avg_middle, int tot_middle_time, int avg_strong, int tot_strongTime,
			String many_actName, String maxKcal_actName, String minKcal_actName) {
		super();
		this.tot_act_val = tot_act_val;
		this.tot_act_time = tot_act_time;
		this.avg_act_time = avg_act_time;
		this.avg_act_one = avg_act_one;
		this.avg_weak = avg_weak;
		this.tot_weak_time = tot_weak_time;
		this.avg_middle = avg_middle;
		this.tot_middle_time = tot_middle_time;
		this.avg_strong = avg_strong;
		this.tot_strongTime = tot_strongTime;
		this.many_actName = many_actName;
		this.maxKcal_actName = maxKcal_actName;
		this.minKcal_actName = minKcal_actName;
	}
	@Override
	public String toString() {
		return "ActStats [tot_act_val=" + tot_act_val + ", tot_act_time=" + tot_act_time + ", avg_act_time="
				+ avg_act_time + ", avg_act_one=" + avg_act_one + ", avg_weak=" + avg_weak + ", tot_weak_time="
				+ tot_weak_time + ", avg_middle=" + avg_middle + ", tot_middle_time=" + tot_middle_time
				+ ", avg_strong=" + avg_strong + ", tot_strongTime=" + tot_strongTime + ", many_actName=" + many_actName
				+ ", maxKcal_actName=" + maxKcal_actName + ", minKcal_actName=" + minKcal_actName + "]";
	}
	public int getTot_act_val() {
		return tot_act_val;
	}
	public void setTot_act_val(int tot_act_val) {
		this.tot_act_val = tot_act_val;
	}
	public int getTot_act_time() {
		return tot_act_time;
	}
	public void setTot_act_time(int tot_act_time) {
		this.tot_act_time = tot_act_time;
	}
	public int getAvg_act_time() {
		return avg_act_time;
	}
	public void setAvg_act_time(int avg_act_time) {
		this.avg_act_time = avg_act_time;
	}
	public int getAvg_act_one() {
		return avg_act_one;
	}
	public void setAvg_act_one(int avg_act_one) {
		this.avg_act_one = avg_act_one;
	}
	public int getAvg_weak() {
		return avg_weak;
	}
	public void setAvg_weak(int avg_weak) {
		this.avg_weak = avg_weak;
	}
	public int getTot_weak_time() {
		return tot_weak_time;
	}
	public void setTot_weak_time(int tot_weak_time) {
		this.tot_weak_time = tot_weak_time;
	}
	public int getAvg_middle() {
		return avg_middle;
	}
	public void setAvg_middle(int avg_middle) {
		this.avg_middle = avg_middle;
	}
	public int getTot_middle_time() {
		return tot_middle_time;
	}
	public void setTot_middle_time(int tot_middle_time) {
		this.tot_middle_time = tot_middle_time;
	}
	public int getAvg_strong() {
		return avg_strong;
	}
	public void setAvg_strong(int avg_strong) {
		this.avg_strong = avg_strong;
	}
	public int getTot_strongTime() {
		return tot_strongTime;
	}
	public void setTot_strongTime(int tot_strongTime) {
		this.tot_strongTime = tot_strongTime;
	}
	public String getMany_actName() {
		return many_actName;
	}
	public void setMany_actName(String many_actName) {
		this.many_actName = many_actName;
	}
	public String getMaxKcal_actName() {
		return maxKcal_actName;
	}
	public void setMaxKcal_actName(String maxKcal_actName) {
		this.maxKcal_actName = maxKcal_actName;
	}
	public String getMinKcal_actName() {
		return minKcal_actName;
	}
	public void setMinKcal_actName(String minKcal_actName) {
		this.minKcal_actName = minKcal_actName;
	}
	
	
	  
  
	//회원정보와 조회할 기간을 전달
	//ArrayLsit<act>로 받아서 가공후
	//화면출력할때 사용할 VO
	
	//기간에 대한 운동 통계 정보
     
     
     
      
      
	 
	
}






