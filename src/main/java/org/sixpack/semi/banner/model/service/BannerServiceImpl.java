package org.sixpack.semi.banner.model.service;

import java.util.ArrayList;

import org.sixpack.semi.banner.model.dao.BannerDao;
import org.sixpack.semi.banner.model.vo.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bannerService")
public class BannerServiceImpl implements BannerService {

	@Autowired
	private BannerDao bannerDao;

	@Override
	public int selectBanner(Banner banner) {
		return bannerDao.selectBanner(banner);
	}
	
	@Override
	public ArrayList<Banner> selectBannerList() {
		return bannerDao.selectBannerList();
	}

	@Override
	public int insertBanner(Banner banner) {
		return bannerDao.insertBanner(banner);
	}

	@Override
	public int updateBanner(Banner banner) {
		return bannerDao.updateBanner(banner);
	}

	@Override
	public int deleteBanner(Banner adminbanner) {
		return bannerDao.deleteBanner(adminbanner);
	}
}
