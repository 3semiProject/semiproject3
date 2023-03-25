package org.sixpack.semi.banner.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.banner.model.vo.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bannerDao")
public class BannerDao {

	@Autowired
	private SqlSessionTemplate session;

	public int selectBanner(Banner banner) {
		// TODO Auto-generated method stub
		return 0;
	}

	public ArrayList<Banner> selectBannerList() {
		// TODO Auto-generated method stub
		return null;
	}

	public int insertBanner(Banner banner) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateBanner(Banner banner) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteBanner(Banner banner) {
		// TODO Auto-generated method stub
		return 0;
	}
}
