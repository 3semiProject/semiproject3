package org.sixpack.semi.log.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.sixpack.semi.log.model.service.LogService;
import org.sixpack.semi.member.controller.AdminController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;

@Controller
public class LogController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(LogController.class);

	
	
	

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
	
	
	
	//회원 ip 메소드
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR");
	    if(ip == null || ip.length() == 0){
	    	ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0){
	    	ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0){
	    	ip = request.getRemoteAddr();
	    }
	    
	    return ip;
	}
}
