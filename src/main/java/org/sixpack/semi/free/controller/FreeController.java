package org.sixpack.semi.free.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.sixpack.semi.free.model.service.FreeService;
import org.sixpack.semi.free.model.vo.Free;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FreeController {
	private static final Logger logger = LoggerFactory.getLogger(FreeController.class);
	
	@Autowired
	private FreeService freeService;
	
	@RequestMapping("commu.do")
	public String moveFreeListMethod() {
		return "free/freeListView";
	}
	
	@RequestMapping(value="ftop5.do", method=RequestMethod.POST)
	@ResponseBody
	public String freeNewTop5Method() throws UnsupportedEncodingException {
		ArrayList<Free> list = freeService.selectTop5();
		logger.info("ftop5.do : " + list.size());
		
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(Free free : list) {
			JSONObject job = new JSONObject();
			
			job.put("free_no", free.getFree_no());
			job.put("free_name", URLEncoder.encode(free.getFree_name(), "utf-8"));
			job.put("write_free_date", free.getWrite_free_date().toString());
			
			jarr.add(job);
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
}
