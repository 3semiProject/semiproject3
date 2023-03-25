package org.sixpack.semi.banner.model.service;

import java.util.ArrayList;

import org.sixpack.semi.banner.model.vo.Banner;

public interface BannerService {
	
	int selectBanner(Banner banner);
	ArrayList<Banner> selectBannerList();
	int insertBanner(Banner banner);
	int updateBanner(Banner banner);
	int deleteBanner(Banner banner);

}
