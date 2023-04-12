package org.sixpack.semi.banner.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;
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

	public int deleteBanner(int banner_no) {
		return session.delete("bannerMapper.deleteBanner", banner_no);
	}

	public int selectListCount() {
		return session.selectOne("bannerMapper.selectListCount");
	}

	public ArrayList<String> selectyoutubelink() {
		List<String> list = session.selectList("bannerMapper.selectyoutubelink");
		return (ArrayList<String>)list;

	}

	public ArrayList<Banner> selectarticlelink() {
		List<Banner> list = session.selectList("bannerMapper.selectarticlelink");
		return (ArrayList<Banner>)list;
	}

	public int selectSearchListCount(CountSearch countSearch) {
		return session.selectOne("bannerMapper.selectSearchListCount", countSearch);
	}

	public ArrayList<Banner> selectSearchTitle(Searchs searchs) {
		List<Banner> list = session.selectList("bannerMapper.selectSearchTitle", searchs);
		return (ArrayList<Banner>)list;
	}

	public ArrayList<Banner> selectSearchWriter(Searchs searchs) {
		List<Banner> list = session.selectList("bannerMapper.selectSearchWriter", searchs);
		return (ArrayList<Banner>)list;
	}


}
