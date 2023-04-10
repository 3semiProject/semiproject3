package org.sixpack.semi.stats.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.stats.model.service.StatsEatService;
import org.sixpack.semi.stats.model.vo.BodyChart;
import org.sixpack.semi.stats.model.vo.EatStats;
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
public class StatsEatController {

    @Autowired
    private StatsEatService statsEatService;
    @Autowired
    private DiaryService diaryService;
    //로그객체 생성구문 넣어야함


    @RequestMapping(value = "diary_moveEatStats.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String moveEatStatsMethod() {
        return "diary/stats/eatStats";
    }

    //식단통계 화면출력용
    //식단통계 분석내용과 식단top3 ajax
    @RequestMapping("diary_EatStats.do")
    @ResponseBody
    public String eatStatsMethod(ModelAndView mv,
                                 @RequestParam(value = "statsRange", required = false) String statsRange,
                                 HttpSession session) {
        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        System.out.println(statsDate);

        EatStats eatStatsResult = statsEatService.eatStatsTotal(statsDate);


        JSONObject sendJSON = new JSONObject();


        sendJSON.put("rec_eat", eatStatsResult.getRec_eat());
        sendJSON.put("avg_eat", eatStatsResult.getAvg_eat());
        sendJSON.put("contrast_eat", eatStatsResult.getContrast_eat());
        sendJSON.put("tan_g", eatStatsResult.getTan_g());
        sendJSON.put("dan_g", eatStatsResult.getDan_g());
        sendJSON.put("zi_g", eatStatsResult.getZi_g());
        sendJSON.put("many_food", eatStatsResult.getMany_food());
        sendJSON.put("maxKcal_food", eatStatsResult.getMaxKcal_food());

        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();
    }

    //식단통계 그래프 ajax



    @RequestMapping("diary_EatChart.do")
    @ResponseBody
    public String bodyChartMethod(ModelAndView mv,
                                  @RequestParam(value = "statsRange", required = false) String statsRange,
                                  HttpSession session) {
        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        ArrayList<EatStats> arr = statsEatService.eatChartList(statsDate);

        System.out.println(arr);
        JSONObject sendJSON = new JSONObject();
        JSONArray jsonArray = new JSONArray();

        for (EatStats eat : arr) {

            JSONObject jobj = new JSONObject();

            jobj.put("rec_eat", eat.getRec_eat());
            jobj.put("avg_eat", eat.getAvg_eat());
            jobj.put("date", eat.getDate().toString());

            jsonArray.add(jobj);
        }

        sendJSON.put("list", jsonArray);
        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();

    }










}
