package org.sixpack.semi.stats.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryServiceImpl;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.service.StatsActService;
import org.sixpack.semi.stats.model.vo.ActRec;
import org.sixpack.semi.stats.model.vo.ActStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public class StatsActController {

	private StatsActService actService;
	private DiaryServiceImpl diaryService;
	
	//운동추천 ajax
	@RequestMapping("diary_showActRec.do")
	public String actRecommendMethod(ModelAndView mv,JSONObject sendJSON,
			ArrayList<ActRec> recs, ActRec rec) {
		//랜덤으로 운동추천코드 3가지
		for(int i =0; i <3; i++) {
		String recCode = "A10"; //A,B,C +random값 
		rec = actService.selectRecAct(recCode);
		recs.add(rec);
		}
		
		JSONArray jarr = new JSONArray();
		JSONObject job = new JSONObject();
		for(ActRec r : recs) {
			job.put("title", r.getRec_act_title());
			job.put("image", r.getRec_act_image());
			job.put("link", r.getRec_act_link());
			jarr.add(job);
		}
		
		if(recs !=null && recs.size() > 0) {
			//json에 담기
			sendJSON.put("recs", jarr);
			return sendJSON.toJSONString();
		}else {
			mv.addObject("message","운동추천 조회 실패");
			return "common/error";
		}
	}
	//운동통계 화면출력용
	@RequestMapping("diary_showActStats.do")
	public String showActDiary(ModelAndView mv,
			@RequestParam(value="diary", required=false) Diary diary,
			@RequestParam(value="term", required=false) int term,
		HttpServletRequest request, Period period, Date today ) {
		//누구의 어떤 카테고리 다이어리로
		//어떤기간에 대한 화면을 볼지
		//view로 보내고 ajax에서 조회
		
		//diary 없으면 session에서 뽑아서 식단으로 조회
		//term 없으면 7일짜리로 조회
		period.setEnd(today);
		switch(term) {
		case 1 : period.setBegin(null); break; //오늘날짜-7일인 Date값
		case 2 : period.setBegin(null); break; //오늘날짜 일인 Date값
		case 3 : period.setBegin(null); break;	//오늘날짜 일인 Date값
		default : period.setBegin(null); //오늘날짜-7일인 Date값
		}

		if (diary == null) {
			String userid = request.getSession().getId(); // userid 추출코드 작성하기
			diary.setUser_id(userid);
			diary.setDiary_post_date(today); // 다이어리에 오늘날짜 담기

			mv.addObject("diary", diary);
			mv.addObject("period", period);
			
			return "diary/act/actStats";
		}else {
			mv.addObject("message","다이어리 조회 실패");
			return "common/error";
		}
		
	}
	
	//운동통계 분석내용과 운동top3 ajax
	@RequestMapping("diary_ActStats.do")
	public String actStatsMethod(ModelAndView mv,
			@RequestParam("diary") Diary diary, 
			@RequestParam("period") Period period, 
			ActStats stats,JSONObject sendJSON) {
		//userid, 조회할 기간, 오늘날짜 -> period set
		//period로 selectActperiod(period) -> ActStats
		stats = actService.selectPeriodAct(period);		
		ActStats top3 = actService.selectPeriodTop3Act(period);
		stats.setMany_actName(top3.getMany_actName());
		stats.setMaxKcal_actName(top3.getMaxKcal_actName());
		stats.setMinKcal_actName(top3.getMinKcal_actName());
		//ActStats를 ajax객체에 담아 String으로 내보냄
		sendJSON.put("stats", stats);
	return sendJSON.toJSONString();
	}
	
	//운동통계 그래프 ajax
	@RequestMapping("diary_ActGraph.do")
	public String actGraphMethod(ModelAndView mv,
			@RequestParam("diary") Diary diary, 
			@RequestParam("period")	Period period, 
			ArrayList<Graph> graphs,JSONObject sendJSON) {
		//userid, 조회할 기간, 오늘날짜
		//period로 selectActGraph(period) -> ArrayList<Graph>
		//ArrayList<Graph>를 ajax객체에 담아 String으로 내보냄
		//String selectPeriod = period.getBegin()+"~" + period.getEnd();
		graphs = actService.selectGraphAct(period);
	
		JSONArray jarr = new JSONArray();
		JSONObject job = new JSONObject();
		for(Graph g : graphs) {
			job.put("value1", g.getValue1());
			job.put("value2", g.getValue2());
			job.put("value3", g.getValue3());
			jarr.add(job);
		}
				
		sendJSON.put("graphs",jarr);
		sendJSON.put("period",period.getBegin()+" ~ "+period.getEnd());
		sendJSON.put("title","최근 7일 조회한 그래프");
	return sendJSON.toJSONString();	
	}
	
}
