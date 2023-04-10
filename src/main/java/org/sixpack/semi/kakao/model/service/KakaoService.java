package org.sixpack.semi.kakao.model.service;

import java.util.HashMap;

public interface KakaoService {

//	String getReturnAccessToken(String code);
//	
//	Map<String,Object> getUserInfo(String access_token);
//	void getLogout(String access_token);
	
	String getAccessToken (String authorize_code);
	HashMap<String, Object> getUserInfo(String access_Token);
}
