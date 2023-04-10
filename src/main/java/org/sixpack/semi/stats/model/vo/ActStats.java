package org.sixpack.semi.stats.model.vo;

public class ActStats implements java.io.Serializable {
    private static final long serialVersionUID = -4551156690758679866L;
    private int tot_act_val;        //총 운동 횟수
    private int tot_act_time;        //총 운동 시간
    private int avg_act_time;        //평균 운동시간대
    private int avg_act_one;        //1회 평균 운동시간(분)
    private int tot_weak_time;    //저강도 총시간(분)
    private int tot_middle_time;    //중강도 총시간(분)
    private int tot_strong_time;      //고강도 총시간(분)

    private String maxDay_actName;    //가장 많이한 운동 :
    private String maxKcal_actName; //최대 소모 kcal 운동이름 : 한번인지 총합인지
    private String maxTime_actName; //가장 오래한 운동이름


    @Override
    public String toString() {
        return "ActStats{" +
                "tot_act_val=" + tot_act_val +
                ", tot_act_time=" + tot_act_time +
                ", avg_act_time=" + avg_act_time +
                ", avg_act_one=" + avg_act_one +
                ", tot_weak_time=" + tot_weak_time +
                ", tot_middle_time=" + tot_middle_time +
                ", tot_strong_time=" + tot_strong_time +
                ", maxDay_actName='" + maxDay_actName + '\'' +
                ", maxKcal_actName='" + maxKcal_actName + '\'' +
                ", maxTime_actName='" + maxTime_actName + '\'' +
                '}';
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

    public int getTot_weak_time() {
        return tot_weak_time;
    }

    public void setTot_weak_time(int tot_weak_time) {
        this.tot_weak_time = tot_weak_time;
    }

    public int getTot_middle_time() {
        return tot_middle_time;
    }

    public void setTot_middle_time(int tot_middle_time) {
        this.tot_middle_time = tot_middle_time;
    }

    public int getTot_strong_time() {
        return tot_strong_time;
    }

    public void setTot_strong_time(int tot_strong_time) {
        this.tot_strong_time = tot_strong_time;
    }

    public String getMaxDay_actName() {
        return maxDay_actName;
    }

    public void setMaxDay_actName(String maxDay_actName) {
        this.maxDay_actName = maxDay_actName;
    }

    public String getMaxKcal_actName() {
        return maxKcal_actName;
    }

    public void setMaxKcal_actName(String maxKcal_actName) {
        this.maxKcal_actName = maxKcal_actName;
    }

    public String getMaxTime_actName() {
        return maxTime_actName;
    }

    public void setMaxTime_actName(String maxTime_actName) {
        this.maxTime_actName = maxTime_actName;
    }

    public ActStats() {
    }

    public ActStats(int tot_act_val, int tot_act_time, int avg_act_time, int avg_act_one, int tot_weak_time, int tot_middle_time, int tot_strong_time, String maxDay_actName, String maxKcal_actName, String maxTime_actName) {
        this.tot_act_val = tot_act_val;
        this.tot_act_time = tot_act_time;
        this.avg_act_time = avg_act_time;
        this.avg_act_one = avg_act_one;
        this.tot_weak_time = tot_weak_time;
        this.tot_middle_time = tot_middle_time;
        this.tot_strong_time = tot_strong_time;
        this.maxDay_actName = maxDay_actName;
        this.maxKcal_actName = maxKcal_actName;
        this.maxTime_actName = maxTime_actName;
    }
}






