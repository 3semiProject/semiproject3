package org.sixpack.semi.log.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletResponse;

import org.sixpack.semi.log.model.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LogController {

	@Autowired
	private LogService logService;
	
	@RequestMapping("insertUserLog.do")
	public String inserUserLogMethod(Model model, @RequestParam("user_id") String user_id, HttpServletResponse response) {
		return null;
	}
	
	@RequestMapping("selectUserLog.do")
	public String selectUserLogMethod(Model model, Date date) {
		return null;
	}
}
