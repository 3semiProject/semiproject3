package org.sixpack.semi.stats.model.vo;

public class BodyStats implements java.io.Serializable {
    private static final long serialVersionUID = -3783764109624756326L;
    private int target_weight; //목표체중
    private int current_weight; //현재체중
    private int standard_weight; //권장 몸무게 = 표준체중
    private int average_weight;//평균 체중
    private int average_fat;//평균 체지방량
    private int average_muscle;//평균 골격근량

    //회원정보와 조회할 기간을 전달
    //ArrayLsit<Body>로 받아서 가공후
    //화면출력할때 사용할 VO
    //체형 통계에만 쓰이는 필드


    @Override
    public String toString() {
        return "BodyStats{" +
                "target_weight=" + target_weight +
                ", current_weight=" + current_weight +
                ", average_weight=" + average_weight +
                ", average_fat=" + average_fat +
                ", average_muscle=" + average_muscle +
                ", standard_weight=" + standard_weight +
                '}';
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

    public int getAverage_weight() {
        return average_weight;
    }

    public void setAverage_weight(int average_weight) {
        this.average_weight = average_weight;
    }

    public int getAverage_fat() {
        return average_fat;
    }

    public void setAverage_fat(int average_fat) {
        this.average_fat = average_fat;
    }

    public int getAverage_muscle() {
        return average_muscle;
    }

    public void setAverage_muscle(int average_muscle) {
        this.average_muscle = average_muscle;
    }

    public int getStandard_weight() {
        return standard_weight;
    }

    public void setStandard_weight(int standard_weight) {
        this.standard_weight = standard_weight;
    }

    public BodyStats() {
    }

    public BodyStats(int target_weight, int current_weight, int average_weight, int average_fat, int average_muscle, int standard_weight) {
        this.target_weight = target_weight;
        this.current_weight = current_weight;
        this.average_weight = average_weight;
        this.average_fat = average_fat;
        this.average_muscle = average_muscle;
        this.standard_weight = standard_weight;
    }
}
