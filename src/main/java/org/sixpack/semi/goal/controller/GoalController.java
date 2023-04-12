package org.sixpack.semi.goal.controller;

import javax.servlet.http.HttpSession;

import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.goal.model.service.GoalService;
import org.sixpack.semi.goal.model.service.GoalServiceImpl;
import org.sixpack.semi.goal.model.vo.Goal;
import org.sixpack.semi.member.model.vo.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Date;


@Controller("goalController")
public class GoalController {
    @Autowired
    private GoalService goalService;

    @Autowired
    private GoalCalculate goalCalculate;
    private static final Logger logger =
            LoggerFactory.getLogger(GoalController.class);

    //목표관리 화면출력용
    @RequestMapping("diary_showGoalView.do")
    public ModelAndView showGoalView(ModelAndView mv,
                                     HttpSession session) {

        String user_id = ((Member) session.getAttribute("loginMember")).getUser_id();


        Goal goal = goalService.selectRecentGoal(user_id);

        mv.setViewName("diary/goal/goalView");
        mv.addObject("goal", goal);

        return mv;
    }


    @RequestMapping("diary_showGoalModify.do")
    public ModelAndView showGoalModifyView(ModelAndView mv,
                                           HttpSession session,
                                           Goal goal,
                                           @RequestParam("isExist") String isExist) {


        Member member = (Member) session.getAttribute("loginMember");
        String user_id = member.getUser_id();
        String gender = member.getGender();
        if (isExist.equals("Y")) {
            goal = goalService.selectRecentGoal(user_id);
        } else if (isExist.equals("D")) {
            goal.setGoal_date(new Date(new java.util.Date().getTime() + (1000L * 60 * 60 * 24 * 30)));
        } else {
            goal = goalCalculate.defaultGoal(user_id, gender);
        }

        mv.addObject("isExist", isExist);
        mv.addObject("goal", goal);
        mv.setViewName("diary/goal/goalModify");

        return mv;

    }


    //수정버튼 클릭시 수정 화면출력용
    @RequestMapping(value = "diary_GoalModify.do", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView goalModifyMethod(
            ModelAndView mv,
            Goal goal,
            HttpSession session) {


        Member member = (Member) session.getAttribute("loginMember");
        try {
            goal.setStandard_weight(
                    (int) (goal.getHeight() * goal.getHeight() *
                            (member.getGender().equals("M") ? 22 : 21) / 100) / 100.0);
            goal.setUser_id(member.getUser_id());

        } catch (Exception e) {
            mv.addObject("message", "세션 만료");
            mv.setViewName("common/error");
            return mv;
        }


        if (!(goalService.updateGoalInfo(goal) > 0)) {  // 오늘날짜 목표관리 수정,
                                                        // 오늘 날짜 없을시(= 목표관리 설정이 안됐을 시) if 문 실행
            goalService.insertGoalInfo(goal); // 목표등록
        }
        mv.addObject("goal", goal);
        mv.addObject("isExist", "Y");

        mv.setViewName("diary/goal/goalView");

        return mv;

    }


}
