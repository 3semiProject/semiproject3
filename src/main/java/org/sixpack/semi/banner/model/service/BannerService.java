package org.sixpack.semi.banner.model.service;

import java.util.ArrayList;

import org.sixpack.semi.banner.model.vo.Banner;
import org.sixpack.semi.common.Paging;

public interface BannerService {
	
	Banner selectBanner(int banner_no);
	ArrayList<Banner> selectList(Paging page);
	int insertBanner(Banner banner);
	int updateBanner(Banner banner);
	int deleteBanner(Banner banner);
	int selectListCount();

}
