package org.sixpack.semi.stats.model.vo;

import java.sql.Date;

public class EatStats implements java.io.Serializable {

    private static final long serialVersionUID = 4109721404398390725L;
    private int rec_eat; // 권장 섭취kcal
    //
    //      ( (표준체중 - 현재체중) * 7000 / d-day)*(3/5) + (현재체중 * 에너지 요구량)
    //			 (남자or여자 * 키^2 /10000)
    // 성별, 키, 에너지 요구량, dday, 현재 체중,

    private int avg_eat; // 평균 섭취kcal
    private int contrast_eat; // 대비 kcal
    private double tan_g; // 탄수화물 섭취비율
    private double dan_g; // 단백질 섭취비율
    private double zi_g; // 지방 섭취비율
    private String many_food; // 가장자주 먹은 식단
    private String maxKcal_food; // 총 kcal 가장 높은 식단

    private Date date;

    //회원정보와 조회할 기간을 전달
    //ArrayLsit<Eat>로 받아서 가공후
    //화면출력할때 사용할 VO

    // 식단 통계에만 쓰이는 필드
    // 음식 메뉴를 등록한 다이어리중, 등록된 메뉴 수가 가장 적은 다이어리의 이미지로 추출


    @Override
    public String toString() {
        return "EatStats{" +
                "rec_eat=" + rec_eat +
                ", avg_eat=" + avg_eat +
                ", contrast_eat=" + contrast_eat +
                ", tan_g=" + tan_g +
                ", dan_g=" + dan_g +
                ", zi_g=" + zi_g +
                ", many_food='" + many_food + '\'' +
                ", maxKcal_food='" + maxKcal_food + '\'' +
                ", date=" + date +
                '}';
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

    public double getTan_g() {
        return tan_g;
    }

    public void setTan_g(double tan_g) {
        this.tan_g = tan_g;
    }

    public double getDan_g() {
        return dan_g;
    }

    public void setDan_g(double dan_g) {
        this.dan_g = dan_g;
    }

    public double getZi_g() {
        return zi_g;
    }

    public void setZi_g(double zi_g) {
        this.zi_g = zi_g;
    }

    public String getMany_food() {
        return many_food;
    }

    public void setMany_food(String many_food) {
        this.many_food = many_food;
    }

    public String getMaxKcal_food() {
        return maxKcal_food;
    }

    public void setMaxKcal_food(String maxKcal_food) {
        this.maxKcal_food = maxKcal_food;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public EatStats() {
    }

    public EatStats(int rec_eat, int avg_eat, int contrast_eat, double tan_g, double dan_g, double zi_g, String many_food, String maxKcal_food, Date date) {
        this.rec_eat = rec_eat;
        this.avg_eat = avg_eat;
        this.contrast_eat = contrast_eat;
        this.tan_g = tan_g;
        this.dan_g = dan_g;
        this.zi_g = zi_g;
        this.many_food = many_food;
        this.maxKcal_food = maxKcal_food;
        this.date = date;
    }
}