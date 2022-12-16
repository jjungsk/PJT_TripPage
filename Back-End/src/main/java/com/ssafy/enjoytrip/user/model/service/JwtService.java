package com.ssafy.enjoytrip.user.model.service;

import java.util.Map;

public interface JwtService {

	<T> String createAccessToken(String key, T data);
	<T> String createRefreshToken(String key, T data);
	<T> String create(String key, T data, String subject, long expir);
	boolean checkToken(String jwt);
	Map<String, Object> getClaims(String jwt);
	
}
