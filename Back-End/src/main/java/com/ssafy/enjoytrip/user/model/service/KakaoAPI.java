package com.ssafy.enjoytrip.user.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ssafy.enjoytrip.exception.UnAuthorizedException;

@Service
public class KakaoAPI {
	
	private String KAKAO_REST_API_KEY = "45a25999e574b6f259245561243926f1";

	public Map<String, Object> getAccessToken(String code, String redirectURL) {
		Map<String, Object> token = new HashMap<>();
		String accessToken = "";
		String refreshToken = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + KAKAO_REST_API_KEY); //
			sb.append("&redirect_uri=" + redirectURL);
			sb.append("&code="+code);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			System.out.println("response code = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body = " + result);
			
			// 다른점 (3)
//			JsonParser parser = new JsonParser();
//			JsonElement element = JsonParser.parse(result);
			JsonElement element = JsonParser.parseString(result);
			
			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();
			
			token.put("access_token", accessToken);
			token.put("refresh_token", refreshToken);
			
			System.out.println("access_token : " + accessToken);
			System.out.println("refresh_token : " + refreshToken);
			
			br.close();
			bw.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UnAuthorizedException();
		}
		
		return token;
	}

	public HashMap<String, Object> getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqUrl = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body = " + result);
			
			// 다른점 (1)
//			JsonParser parser = new JsonParser();
//			JsonElement element = JsonParser.parse(result);
			JsonElement element = JsonParser.parseString(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//			Boolean isEmailValid = kakaoAccount.getAsJsonObject().get("is_email_valid").getAsBoolean();
			Boolean hasEmail = kakaoAccount.getAsJsonObject().get("has_email").getAsBoolean();
			
			userInfo.put("id", element.getAsJsonObject().get("id").getAsString());
			userInfo.put("name", nickname);
			if (hasEmail) {
				String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
				userInfo.put("email", email);
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw new UnAuthorizedException();
		}
		return userInfo;
	}

	public void kakaoLogout(String accessToken) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			conn.setDoOutput(true);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body = " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public Map<String, Object> refreshToken(String refreshToken) {
		Map<String, Object> token = new HashMap<>();
		String reqURL = "https://kauth.kakao.com/oauth/token";
		String accessToken = "";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=refresh_token");
			sb.append("&client_id=" + KAKAO_REST_API_KEY); //
			sb.append("&refresh_token="+refreshToken);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			System.out.println("response code = " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body = " + result);
			
			JsonElement element = JsonParser.parseString(result);
			
			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			
			token.put("access_token", accessToken);
			token.put("refresh_token", refreshToken);
			
			System.out.println("access_token : " + accessToken);
			System.out.println("refresh_token : " + refreshToken);
			
			br.close();
			bw.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new UnAuthorizedException();
		}
		
		return token;
		
	}

}
