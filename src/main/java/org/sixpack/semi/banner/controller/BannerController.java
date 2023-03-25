package org.sixpack.semi.banner.controller;

import org.sixpack.semi.banner.model.service.BannerService;
import org.sixpack.semi.banner.model.vo.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BannerController {
	
	@Autowired
	private BannerService bannerService;
	
	@RequestMapping("showBanner.do")
	public String showBannerMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("showBannerList.do")
	public String showBannerListMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("bannerInsert.do")
	public String BannerInsertMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("bannerUpdate.do")
	public String BannerUpdateMethod(Banner banner, Model model) {
		return null;
	}
	@RequestMapping("bannerDelete.do")
	public String BannerDeleteMethod(int banner_no, Model model) {
		return null;
	}

}
