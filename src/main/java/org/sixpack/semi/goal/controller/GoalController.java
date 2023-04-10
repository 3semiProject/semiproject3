package org.sixpack.semi.goal.controller;

import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.goal.model.service.GoalService;
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

import net.sf.json.JSONObject;

@Controller("goalCon")
public class GoalController {

    @Autowired
    private GoalService goalService;
    @Autowired
    private DiaryServiceImpl diaryService;

    private static final Logger logger =
            LoggerFactory.getLogger(GoalController.class);

    //목표관리 화면출력용
    @RequestMapping("diary_showGoalView.do")
    public ModelAndView showGoalView(ModelAndView mv,
                                     HttpSession session) {

        String user_id = ((Member) session.getAttribute("loginMember")).getUser_id();


        Goal goal = goalService.selectRecentGoal(user_id);


        if (goal != null) {
            mv.addObject("goal", goal);
            mv.setViewName("diary/goal/goalView");
        } else {
            mv.addObject("message", "목표관리 페이지 표시 실패");
        }
        return mv;
    }


    @RequestMapping("diary_showGoalModify.do")
    public ModelAndView showGoalModifyView(ModelAndView mv,
                                           HttpSession session) {

        String user_id = ((Member) session.getAttribute("loginMember")).getUser_id();


        Goal goal = goalService.selectRecentGoal(user_id);


        if (goal != null) {
            goal = new Goal();
        }
        mv.addObject("goal", goal);
        mv.setViewName("diary/goal/goalModify");

        return mv;

    }

    //수정버튼 클릭시 수정 화면출력용
    @RequestMapping(name = "diary_GoalModify.do")
    public String showGoalModify(ModelAndView mv,
                                 Goal goal,
                                 HttpSession session) {

        if (goalService.insertGoalInfo(goal) > 0) {
            mv.addObject("goal", goal);
            return "redirect:diary_showGoalView.do";
        } else {
            mv.addObject("message", "목표관리 수정 실패");
            return "common/error";
        }
    }
}
