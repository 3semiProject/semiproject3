package org.sixpack.semi.stats.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.stats.model.service.StatsBodyService;
import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.BodyStats;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller()
public class StatsBodyController {

    @Autowired
    private StatsBodyService statsBodyService;
    @Autowired
    private DiaryServiceImpl diaryService;
    // 체형통계 화면출력용


    @RequestMapping(value = "diary_moveBodyStats.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String moveBodyStatsMethod() {
        return "diary/stats/bodyStats";
    }

    // 체형통계 분석내용과 체형top3 ajax
    @RequestMapping("diary_BodyStats.do")
    @ResponseBody
    public String bodyStatsMethod(ModelAndView mv,
                                  @RequestParam(value = "statsRange", required = false) String statsRange,
                                  HttpSession session) {
        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        System.out.println(statsDate);

        BodyStats bodyStatsResult = statsBodyService.bodyStatsTotal(statsDate);

        JSONObject sendJSON = new JSONObject();

        sendJSON.put("target_weight", bodyStatsResult.getTarget_weight());
        sendJSON.put("current_weight", bodyStatsResult.getCurrent_weight());
        sendJSON.put("standard_weight", bodyStatsResult.getStandard_weight());
        sendJSON.put("average_weight", bodyStatsResult.getAverage_weight());
        sendJSON.put("average_fat", bodyStatsResult.getAverage_fat());
        sendJSON.put("average_muscle", bodyStatsResult.getAverage_muscle());

        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();

    }


    @RequestMapping("diary_BodyChart.do")
    @ResponseBody
    public String bodyChartMethod(ModelAndView mv,
                                  @RequestParam(value = "statsRange", required = false) String statsRange,
                                  HttpSession session) {
        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        ArrayList<BodyChart> arr = statsBodyService.bodyChartList(statsDate);

        JSONObject sendJSON = new JSONObject();
        JSONArray jsonArray = new JSONArray();

        for (BodyChart body : arr) {

            JSONObject jobj = new JSONObject();

            jobj.put("target_weight", body.getTarget_weight());
            jobj.put("current_weight", body.getCurrent_weight());
            jobj.put("date", body.getDate().toString());

            jsonArray.add(jobj);
        }

        sendJSON.put("list", jsonArray);
        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();

    }
}