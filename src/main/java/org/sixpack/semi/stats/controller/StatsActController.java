package org.sixpack.semi.stats.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.member.model.vo.Member;
import org.sixpack.semi.stats.model.service.StatsActService;
import org.sixpack.semi.stats.model.service.StatsActServiceImpl;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.sixpack.semi.stats.model.vo.StatsDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
    @RequestMapping("diary_showActStats.do")
    public String showActDiary(ModelAndView mv,
                               @RequestParam(value = "diary", required = false) Diary diary,
                               @RequestParam(value = "term", required = false) int term,
                               HttpServletRequest request, Period period, Date today) {
        //누구의 어떤 카테고리 다이어리로
        //어떤기간에 대한 화면을 볼지
        //view로 보내고 ajax에서 조회

        //diary 없으면 session에서 뽑아서 식단으로 조회
        //term 없으면 7일짜리로 조회
        period.setEnd(today);
        switch (term) {
            case 1:
                period.setBegin(null);
                break; //오늘날짜-7일인 Date값
            case 2:
                period.setBegin(null);
                break; //오늘날짜 일인 Date값
            case 3:
                period.setBegin(null);
                break;    //오늘날짜 일인 Date값
            default:
                period.setBegin(null); //오늘날짜-7일인 Date값
        }

        if (diary == null) {
            String userid = request.getSession().getId(); // userid 추출코드 작성하기
            diary.setUser_id(userid);
            diary.setDiary_post_date(today); // 다이어리에 오늘날짜 담기

            mv.addObject("diary", diary);
            mv.addObject("period", period);

            return "diary/act/actStats";
        } else {
            mv.addObject("message", "다이어리 조회 실패");
            return "common/error";
        }

    }

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

    //운동통계 그래프 ajax
    @RequestMapping("diary_ActGraph.do")
    public String actGraphMethod(ModelAndView mv,
                                 @RequestParam("diary") Diary diary,
                                 @RequestParam("period") Period period,
                                 ArrayList<Graph> graphs, JSONObject sendJSON) {
        //userid, 조회할 기간, 오늘날짜
        //period로 selectActGraph(period) -> ArrayList<Graph>
        //ArrayList<Graph>를 ajax객체에 담아 String으로 내보냄
        //String selectPeriod = period.getBegin()+"~" + period.getEnd();
        graphs = statsActService.selectGraphAct(period);

        JSONArray jarr = new JSONArray();
        JSONObject job = new JSONObject();
        for (Graph g : graphs) {
            job.put("value1", g.getValue1());
            job.put("value2", g.getValue2());
            job.put("value3", g.getValue3());
            jarr.add(job);
        }

        sendJSON.put("graphs", jarr);
        sendJSON.put("period", period.getBegin() + " ~ " + period.getEnd());
        sendJSON.put("title", "최근 7일 조회한 그래프");
        return sendJSON.toJSONString();
    }

}
