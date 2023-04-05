package org.sixpack.semi.kakao.model.service;

import org.sixpack.semi.kakao.model.dao.KakaoDao;
import org.sixpack.semi.kakao.model.vo.Kakao;
import org.sixpack.semi.member.model.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("kakaoService")
public class KakaoServiceImpl implements KakaoService {
	
	@Autowired
	private KakaoDao kakaoDao;

	@Override
	public Kakao selectKakaoLogin(String kid) {
		
		return kakaoDao.selectKakaoLogin(kid);
	}

	@Override
	public void insertKakaoMember(Kakao kakao) {
		// TODO Auto-generated method stub
		
	}
}
