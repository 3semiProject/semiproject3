package org.sixpack.semi.stats.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.diary.model.vo.Diary;
import org.sixpack.semi.diary.model.vo.Period;
import org.sixpack.semi.stats.model.service.StatsEatService;
import org.sixpack.semi.stats.model.vo.EatStats;
import org.sixpack.semi.stats.model.vo.Graph;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller()
public class StatsEatController {

	
	private StatsEatService eatService;
	
	private DiaryService diaryService;
	//로그객체 생성구문 넣어야함

	//식단통계 화면출력용
	@RequestMapping("diary_showEatStats.do")
	public String showEatDiary(ModelAndView mv,
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
			Diary dry= new Diary();
			String userid = request.getSession().getId(); // userid 추출코드 작성하기
			dry.setUser_id(userid);
			dry.setDiary_post_date(today); // 다이어리에 오늘날짜 담기

			mv.addObject("diary", dry);
			mv.addObject("period", period);
			
			return "diary/eat/eatStats";
		}else {
			mv.addObject("message","다이어리 조회 실패");
			return "common/error";
		}
		
	}
	
	//식단통계 분석내용과 식단top3 ajax
	@RequestMapping("diary_eatStats.do")
	public String eatStatsMethod(ModelAndView mv,
			@RequestParam("diary") Diary diary, 
			@RequestParam("period") Period period, 
			EatStats stats,JSONObject sendJSON) {
		//userid, 조회할 기간, 오늘날짜 -> period set
		//period로 selectEatperiod(period) -> EatStats
		stats = eatService.selectPeriodEat(period);		
		EatStats top3 = eatService.selectPeriodTop3Eat(period);
		stats.setMany_foodfile(top3.getMany_foodfile());
		stats.setMaxKcal_foodfile(top3.getMaxKcal_foodfile());
		stats.setMinKcal_foodfile(top3.getMinKcal_foodfile());
		//EatStats를 ajax객체에 담아 String으로 내보냄
		sendJSON.put("stats", stats);
	return sendJSON.toJSONString();
	}
	
	//식단통계 그래프 ajax
	@RequestMapping("diary_eatGraph.do")
	public String eatGraphMethod(ModelAndView mv,
			@RequestParam("diary") Diary diary, 
			@RequestParam("period")	Period period, 
			ArrayList<Graph> graphs,JSONObject sendJSON) {
		//userid, 조회할 기간, 오늘날짜
		//period로 selectEatGraph(period) -> ArrayList<Graph>
		//ArrayList<Graph>를 ajax객체에 담아 String으로 내보냄
		//String selectPeriod = period.getBegin()+"~" + period.getEnd();
		graphs = eatService.selectGraphEat(period);
	
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
