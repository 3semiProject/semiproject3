package org.sixpack.semi.goal.controller;

import org.sixpack.semi.goal.model.vo.Goal;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Component("goalCalc")
public class GoalCalculate {
    public GoalCalculate() {
    }

    public Goal defaultGoal(String user_id, String gender) {
        Goal goal;
        if ("M".equals(gender)) {
            double height = 170.0;
            goal = new Goal(
                    user_id,
                    null,
                    new Date(new java.util.Date().getTime() + (1000L * 60 * 60 * 24 * 30)), //현재 날짜에서 한달 후
                    35,
                    height,
                    70.0,
                    (int) (height * height * 22 / 100) / 100.0,
                    65.0
            );
        } else {
            double height = 160.0;
            goal = new Goal(
                    user_id,
                    null,
                    new Date(new java.util.Date().getTime() + (1000L * 60 * 60 * 24 * 30)), //현재 날짜에서 한달 후
                    35,
                    height,
                    60.0,
                    (int) (height * height * 21 / 100) / 100.0,
                    55.0
            );
        }
        return goal;
    }


}
