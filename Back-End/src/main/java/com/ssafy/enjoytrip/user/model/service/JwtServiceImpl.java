package com.ssafy.enjoytrip.user.model.service;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.exception.UnAuthorizedException;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class JwtServiceImpl implements JwtService {

	public static final Logger logger = LoggerFactory.getLogger(JwtServiceImpl.class);

	private static final String SALT = "ssafySecret";
	private static final int ACCESS_TOKEN_EXPIRE_MINUTES = 10; // 분단위
	private static final int REFRESH_TOKEN_EXPIRE_MINUTES = 2; // 주단위

	@Override
	public <T> String createAccessToken(String key, T data) {
		return create(key, data, "access-token", 1000 * 60 * ACCESS_TOKEN_EXPIRE_MINUTES);
//		return create(key, data, "access-token", 1000 * 10 * ACCESS_TOKEN_EXPIRE_MINUTES);
	}

//	AccessToken에 비해 유효기간을 길게...
	@Override
	public <T> String createRefreshToken(String key, T data) {
		return create(key, data, "refresh-token", 1000 * 60 * 60 * 24 * 7 * REFRESH_TOKEN_EXPIRE_MINUTES);
//		return create(key, data, "refresh-token", 1000 * 30 * ACCESS_TOKEN_EXPIRE_MINUTES);
	}

	//Token 발급
	/**
	 * key : Claim에 셋팅될 key 값
	 * data : Claim에 셋팅 될 data 값
	 * subject : payload에 sub의 value로 들어갈 subject값
	 * expire : 토큰 유효기간 설정을 위한 값
	 * jwt 토큰의 구성 : header+payload+signature
	 */
	@Override
	public <T> String create(String key, T data, String subject, long expire) {
		String jwt = Jwts.builder()
				// Header 설정 : 토큰의 타입, 해쉬 알고리즘 정보 세팅.
				.setHeaderParam("typ", "JWT")
				.setHeaderParam("regDate", System.currentTimeMillis()) // 생성 시간
				// Payload 설정 : 유효기간(Expiration), 토큰 제목 (Subject), 데이터 (Claim) 등 정보 세팅.
				.setExpiration(new Date(System.currentTimeMillis() + expire)) // 토큰 유효기간
				.setSubject(subject) // 토큰 제목 설정 ex) access-token, refresh-token
				.claim(key, data) // 저장할 데이터
				// Signature 설정 : secret key를 활용한 암호화.
				.signWith(SignatureAlgorithm.HS256, this.generateKey())
				.compact(); // 직렬화 처리.
		return jwt;
	}

	// Signature 설정에 들어갈 key 생성.
	private byte[] generateKey() {
		byte[] key = null;
		try {
			// charset 설정 안하면 사용자 플랫폼의 기본 인코딩 설정으로 인코딩 됨.
			key = SALT.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			if (logger.isInfoEnabled()) {
				e.printStackTrace();
			} else {
				logger.error("Making JWT Key Error ::: {}", e.getMessage());
			}
		}

		return key;
	}

//	전달 받은 토큰이 제대로 생성된것인지 확인 하고 문제가 있다면 UnauthorizedException을 발생.
	@Override
	public boolean checkToken(String jwt) {
		try {
//			Json Web Signature? 서버에서 인증을 근거로 인증정보를 서버의 private key로 서명 한것을 토큰화 한것
//			setSigningKey : JWS 서명 검증을 위한  secret key 세팅
//			parseClaimsJws : 파싱하여 원본 jws 만들기
			Jws<Claims> claims = Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(jwt);
//			Claims 는 Map의 구현체 형태
			logger.debug("claims: {}", claims);
			return true;
		} catch (Exception e) {
//			if (logger.isInfoEnabled()) {
//				e.printStackTrace();
//			} else {
			logger.error(e.getMessage());
//			}
			throw new UnAuthorizedException();
//			개발환경
//			return false;
		}
	}
	
//	전달 받은 토큰이 제대로 생성된것인지 확인 하고 문제가 있다면 UnauthorizedException을 발생.
	@Override
	public Map<String, Object> getClaims(String jwt) {
		try {
			Jws<Claims> claims = Jwts.parser().setSigningKey(this.generateKey()).parseClaimsJws(jwt);
			logger.debug("claims: {}", claims);
			
			return new HashMap<String, Object>(claims.getBody());
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new UnAuthorizedException();
		}
	}

}
