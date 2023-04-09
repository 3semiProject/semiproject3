package org.sixpack.semi.kakao.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.sixpack.semi.kakao.model.dao.KakaoDao;
import org.sixpack.semi.member.controller.MemberController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service("kakaoService")
public class KakaoServiceImpl implements KakaoService {
	
	@Autowired
	private KakaoDao kakaoDao;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Override
	public String getAccessToken (String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=3205654a3e1700ef0d67201d929a9c56"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8889/semi/kakao_callback.do"); // 본인이 설정한 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}

	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	

	
	
	
	
	
//	@Override
//	public String getReturnAccessToken(String code) {
//        String access_token = "";
//        String refresh_token = "";
//        String reqURL = "https://kauth.kakao.com/oauth/token";
//       
//       try {
//           URL url = new URL(reqURL);
//           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//           
//            //HttpURLConnection 설정 값 셋팅
//            conn.setRequestMethod("POST");
//            conn.setDoOutput(true);
//            
//            
//            // buffer 스트림 객체 값 셋팅 후 요청
//            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//            StringBuilder sb = new StringBuilder();
//            sb.append("grant_type=authorization_code");
//            sb.append("&client_id=3205654a3e1700ef0d67201d929a9c56");  //앱 KEY VALUE
//            sb.append("&redirect_uri=http://localhost:8889/semi/kakao_callback.do"); // 앱 CALLBACK 경로
//            sb.append("&code=" + code);
//            bw.write(sb.toString());
//            bw.flush();
//            
//            //  RETURN 값 result 변수에 저장
//            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//            String br_line = "";
//            String result = "";
//
//            while ((br_line = br.readLine()) != null) {
//                result += br_line;
//            }
//
//            JsonParser parser = new JsonParser();
//            JsonElement element = parser.parse(result);
//
//            
//            // 토큰 값 저장 및 리턴
//            access_token = element.getAsJsonObject().get("access_token").getAsString();
//            refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
//
//            br.close();
//            bw.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return access_token;
//	}
//
//	@Override
//	public Map<String, Object> getUserInfo(String access_token) {
//        Map<String,Object> resultMap =new HashMap<>();
//        String reqURL = "https://kapi.kakao.com/v2/user/me";
//         try {
//             URL url = new URL(reqURL);
//             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//             conn.setRequestMethod("GET");
// 
//            //요청에 필요한 Header에 포함될 내용
//             conn.setRequestProperty("Authorization", "Bearer " + access_token);
// 
//             int responseCode = conn.getResponseCode();
//             System.out.println("responseCode : " + responseCode);
// 
//             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
// 
//             String br_line = "";
//             String result = "";
// 
//             while ((br_line = br.readLine()) != null) {
//                 result += br_line;
//             }
//            System.out.println("response:" + result);
// 
//             JsonParser parser = new JsonParser();
//             JsonElement element = parser.parse(result);
// 
//             JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//             JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
// 
//             String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//             String email = properties.getAsJsonObject().get("email").getAsString();
//             resultMap.put("nickname", nickname);
//             resultMap.put("email", email);
//             
//         } catch (IOException e) {
//             // TODO Auto-generated catch block
//             e.printStackTrace();
//         }
//         return resultMap;
//	}
//
//	@Override
//	public void getLogout(String access_token) {
//        String reqURL ="https://kapi.kakao.com/v1/user/logout";
//        try {
//            URL url = new URL(reqURL);
//            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//            conn.setRequestMethod("POST");
//            
//            conn.setRequestProperty("Authorization", "Bearer " + access_token);
//            int responseCode = conn.getResponseCode();
//            System.out.println("responseCode : " + responseCode);
// 
//            if(responseCode ==400)
//                throw new RuntimeException("카카오 로그아웃 도중 오류 발생");
//            
//            
//            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//            
//            String br_line = "";
//            String result = "";
//            while ((br_line = br.readLine()) != null) {
//                result += br_line;
//            }
//            System.out.println("결과");
//            System.out.println(result);
//        }catch(IOException e) {
//            
//        }
//		
//	}
	
	
}



