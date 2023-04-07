package org.sixpack.semi.stats.model.vo;

import java.sql.Date;

public class BodyChart {
    private int target_weight; //목표체중

    private int current_weight; //현재체중

    private Date date; // 하단 날짜 표시용

    @Override
    public String toString() {
        return "BodyChart{" +
                "target_weight=" + target_weight +
                ", current_weight=" + current_weight +
                ", date=" + date +
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public BodyChart() {
    }

    public BodyChart(int target_weight, int current_weight, Date date) {
        this.target_weight = target_weight;
        this.current_weight = current_weight;
        this.date = date;
    }
}
