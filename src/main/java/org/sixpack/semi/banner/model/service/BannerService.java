package org.sixpack.semi.banner.model.service;

import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.CountSearch;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.common.Searchs;

import java.util.ArrayList;

public interface BannerService {
	
	Banner selectBanner(int banner_no);
	ArrayList<Banner> selectList(Paging page);
	int insertBanner(Banner banner);
	int updateBanner(Banner banner);
	int deleteBanner(int banner_no);
	int selectListCount();
	ArrayList<String> selectyoutubelink();
	ArrayList<Banner> selectarticlelink();
	int selectSearchListCount(CountSearch countSearch);
	ArrayList<Banner> selectSearchTitle(Searchs searchs);
	ArrayList<Banner> selectSearchWriter(Searchs searchs);
	
}
