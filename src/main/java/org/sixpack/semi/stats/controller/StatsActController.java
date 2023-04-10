package org.sixpack.semi.stats.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.stats.model.service.StatsActServiceImpl;
import org.sixpack.semi.stats.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class StatsActController {

    @Autowired
    private StatsActServiceImpl statsActService;
    @Autowired
    private DiaryServiceImpl diaryService;


    @RequestMapping(value = "diary_moveActStats.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String moveActStatsMethod() {
        return "diary/stats/actStats";
    }


    //운동추천 ajax
    @RequestMapping(value = "diary_showActRec.do", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String actRecommendMethod() {


        ArrayList<ActRec> recs = new ArrayList<ActRec>();
        //랜덤으로 운동추천코드 3가지
        for (int i = 1; i <= 3; i++) {
            ActRec rec = new ActRec();
            rec = statsActService.selectRecAct(i);
            recs.add(rec);
        }

        JSONObject sendJSON = new JSONObject();
        JSONArray jarr = new JSONArray();

        for (ActRec r : recs) {
            JSONObject job = new JSONObject();
            job.put("title", r.getRec_act_title());
            job.put("image", r.getRec_act_image());
            job.put("link", r.getRec_act_link());
            jarr.add(job);
        }

        //json에 담기
        sendJSON.put("list", jarr);
        return sendJSON.toJSONString();

    }

    //운동통계 화면출력용
    //운동통계 분석내용과 운동top3 ajax
    @RequestMapping("diary_ActStats.do")
    @ResponseBody
    public String actStatsMethod(ModelAndView mv,
                                 @RequestParam(value = "statsRange", required = false) String statsRange,
                                 HttpSession session) {
        //userid, 조회할 기간, 오늘날짜 -> period set
        //period로 selectActperiod(period) -> ActStats

        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        ActStats actStatsResult = statsActService.actStatsTotal(statsDate);

        JSONObject sendJSON = new JSONObject();


        sendJSON.put("tot_act_val", actStatsResult.getTot_act_val());
        sendJSON.put("tot_act_time", actStatsResult.getTot_act_time());
        sendJSON.put("avg_act_one", actStatsResult.getAvg_act_one());
        sendJSON.put("tot_weak_time", actStatsResult.getTot_weak_time());
        sendJSON.put("tot_middle_time", actStatsResult.getTot_middle_time());
        sendJSON.put("tot_strong_time", actStatsResult.getTot_strong_time());
        sendJSON.put("maxDay_actName", actStatsResult.getMaxDay_actName());
        sendJSON.put("maxKcal_actName", actStatsResult.getMaxKcal_actName());
        sendJSON.put("maxTime_actName", actStatsResult.getMaxTime_actName());

        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();
    }


    @RequestMapping("diary_ActChart.do")
    @ResponseBody
    public String bodyChartMethod(ModelAndView mv,
                                  @RequestParam(value = "statsRange", required = false) String statsRange,
                                  HttpSession session) {
        StatsDate statsDate = new StatsDate(
                ((Member) session.getAttribute("loginMember")).getUser_id(),
                Integer.parseInt(statsRange));

        ArrayList<ActChart> arr = statsActService.actChartList(statsDate);

        JSONObject sendJSON = new JSONObject();
        JSONArray jsonArray = new JSONArray();

        for (ActChart act : arr) {

            JSONObject jobj = new JSONObject();

            jobj.put("act_kcal", act.getAct_kcal());
            jobj.put("act_mm", act.getAct_mm());
            jobj.put("date", act.getDate().toString());

            jsonArray.add(jobj);
        }

        sendJSON.put("list", jsonArray);
        System.out.println("sendJSON : " + sendJSON);
        return sendJSON.toJSONString();

    }
}
