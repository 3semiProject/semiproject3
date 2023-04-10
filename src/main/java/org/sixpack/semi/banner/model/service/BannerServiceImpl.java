package org.sixpack.semi.banner.model.service;

import java.util.ArrayList;

import org.sixpack.semi.banner.model.dao.BannerDao;
import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.Paging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bannerService")
public class BannerServiceImpl implements BannerService {

	@Autowired
	private BannerDao bannerDao;

	@Override
	public Banner selectBanner(int banner_no) {
		return bannerDao.selectBanner(banner_no);
	}
	
	@Override
	public ArrayList<Banner> selectList(Paging page) {
		return bannerDao.selectList(page);
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

	@Override
	public int selectListCount() {
		return bannerDao.selectListCount();
	}
}
