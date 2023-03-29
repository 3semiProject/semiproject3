package org.sixpack.semi.stats.model.vo;

import java.sql.Date;

public class StatsDate {
    private String user_id;        //유저 아이디
    private int date_range;     //1: 7일, 2: 한달, 3: 3개월, 4: 6개월

    @Override
    public String toString() {
        return "StatsDate{" +
                "user_id='" + user_id + '\'' +
                ", date_range=" + date_range +
                '}';
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getDate_range() {
        return date_range;
    }

    public void setDate_range(int date_range) {
        this.date_range = date_range;
    }

    public StatsDate() {
    }

    public StatsDate(String user_id, int date_range) {
        this.user_id = user_id;
        this.date_range = date_range;
    }
}
