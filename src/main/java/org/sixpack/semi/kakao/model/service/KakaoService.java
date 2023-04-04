package org.sixpack.semi.kakao.model.service;

import org.sixpack.semi.kakao.model.vo.Kakao;

public interface KakaoService {

	Kakao selectKakaoLogin(String kid);

	void insertKakaoMember(Kakao kakao);
}
