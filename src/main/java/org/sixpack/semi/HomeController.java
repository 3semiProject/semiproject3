package org.sixpack.semi;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.sixpack.semi.banner.model.service.BannerService;
import org.sixpack.semi.banner.model.vo.Banner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private BannerService bannerService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	//index.jsp 가 웰컴될 때 포워딩된 요청을 받아서 
	//common/main.jsp 를 내보내기 위해 리턴하는 메소드
	@RequestMapping("main.do")
	public String forwardMainView(Model model) {
		ArrayList<String> bannerlink = bannerService.selectlink();
		
		model.addAttribute("bannerlink", bannerlink);
		return "common/main";  //내보낼 뷰파일명 리턴
	}
}
