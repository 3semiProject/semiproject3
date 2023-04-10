package org.sixpack.semi.stats.model.vo;

import java.sql.Date;

public class ActChart {

    private int act_kcal; // 칼로리 소모량
    private int act_mm;  // 운동 시간
    private Date date; // 하단 날짜 표시용


    @Override
    public String toString() {
        return "ActChart{" +
                "act_kcal=" + act_kcal +
                ", act_mm=" + act_mm +
                ", date=" + date +
                '}';
    }

    public int getAct_kcal() {
        return act_kcal;
    }

    public void setAct_kcal(int act_kcal) {
        this.act_kcal = act_kcal;
    }

    public int getAct_mm() {
        return act_mm;
    }

    public void setAct_mm(int act_mm) {
        this.act_mm = act_mm;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public ActChart() {
    }

    public ActChart(int act_kcal, int act_mm, Date date) {
        this.act_kcal = act_kcal;
        this.act_mm = act_mm;
        this.date = date;
    }
}

