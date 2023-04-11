package org.sixpack.semi.banner.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.Paging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bannerDao")
public class BannerDao {

	@Autowired
	private SqlSessionTemplate session;

	public Banner selectBanner(int banner_no) {
		return session.selectOne("bannerMapper.selectBanner", banner_no);
	}

	public ArrayList<Banner> selectList(Paging page) {
		List<Banner> list = session.selectList("bannerMapper.selectList", page);
		return (ArrayList<Banner>)list;
	}

	public int insertBanner(Banner banner) {
		return session.insert("bannerMapper.insertBanner", banner);
	}

	public int updateBanner(Banner banner) {
		return session.update("bannerMapper.updateBanner", banner);
	}

	public int deleteBanner(Banner banner) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectListCount() {
		return session.selectOne("bannerMapper.selectListCount");
	}

	public ArrayList<String> selectlink() {
		List<String> list = session.selectList("bannerMapper.selectlink");
		return (ArrayList<String>)list;

	}


}
