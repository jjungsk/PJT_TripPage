package com.ssafy.enjoytrip.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.user.model.UserDto;
import com.ssafy.enjoytrip.user.model.service.JwtServiceImpl;
import com.ssafy.enjoytrip.user.model.service.KakaoAPI;
import com.ssafy.enjoytrip.user.model.service.UserService;

import io.swagger.annotations.Api;

@RestController
@RequestMapping("/user")
@Api
public class UserController extends HttpServlet {
	
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	private final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	private static final long serialVersionUID = 1L;
	

	private final UserService userService;

	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	@Autowired
	private JwtServiceImpl jwtService;
	
	@Autowired
	private KakaoAPI kakaoApi;
	
	@PostMapping("/login/{service}")
	public ResponseEntity<?> login(@PathVariable String service, @RequestBody Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		
		try {
			if (service.equals("default")) {
				// 기본 로그인
				UserDto userDto = new UserDto();
				userDto.setId((String)params.get("id"));
				userDto.setPassword((String)params.get("password"));
				UserDto loginUser = userService.login(userDto);
				if (loginUser != null) {
					// token 저장
					String accessToken = jwtService.createAccessToken("userid", loginUser.getId());// key, data
					String refreshToken = jwtService.createRefreshToken("userid", loginUser.getId());// key, data
					userService.saveRefreshToken(userDto.getId(), refreshToken);
					resultMap.put("access-token", accessToken);
					resultMap.put("refresh-token", refreshToken);
					resultMap.put("service", "default");
					resultMap.put("message", SUCCESS);
					status = HttpStatus.ACCEPTED;
				} else {
					resultMap.put("message", FAIL);
					status = HttpStatus.ACCEPTED;
				}
				
			} else if (service.equals("kakao")) {
				// 카카오를 이용한 로그인
				// 1. 인증코드 전달
				Map<String, Object> token = kakaoApi.getAccessToken((String)params.get("code"), (String)params.get("redirect-url"));
				String accessToken = jwtService.createAccessToken("access_token", (String)token.get("access_token"));
				String refreshToken = jwtService.createRefreshToken("refresh_token", (String)token.get("refresh_token"));
				
				// DB에 회원정보 저장
				HashMap<String, Object> userinfo = kakaoApi.getUserInfo((String)jwtService.getClaims(accessToken).get("access_token"));
				String userId = (String)userinfo.get("id");
				if (userService.checkID(userId) == 0) {
					UserDto userDto = new UserDto();
					userDto.setId((String)userinfo.get("id"));
					userDto.setIsManager(0);
					userDto.setEmail((String)userinfo.get("email"));
					userDto.setName((String)userinfo.get("name"));
					userService.joinUser(userDto);					
				}
				
				resultMap.put("access-token", accessToken);
				resultMap.put("refresh-token", refreshToken);
				resultMap.put("service", "kakao");
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	// (1) 로그인 - 체크한 로그인 아이디로 사용자 정보 불러오기
	@GetMapping({"/info/{service}", "/info/{service}/{userid}"})
	public ResponseEntity<Map<String, Object>> getInfo(@PathVariable("service") String service,
			@PathVariable(value = "userid", required = false) String userid, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.UNAUTHORIZED;
		try {
			logger.debug("어세스 토큰 가지고 있나? {}", request.getHeader("access-token"));
			if (jwtService.checkToken(request.getHeader("access-token"))) {
				if (service.equals("default")) {
					// 기본 로그인
					UserDto userDto = userService.userInfo(userid);
					resultMap.put("userInfo", userDto);
					resultMap.put("service", "default");
					resultMap.put("message", SUCCESS);
					status = HttpStatus.ACCEPTED;
				} else if (service.equals("kakao")) {
					// 카카오를 이용한 로그인
					String accessToken = (String)jwtService.getClaims(request.getHeader("access-token")).get("access_token");
					// 2. 인증코드로 토큰 전달
					HashMap<String, Object> userinfo = kakaoApi.getUserInfo(accessToken);
					resultMap.put("userInfo", userinfo);
					resultMap.put("service", "kakao");
					resultMap.put("message", SUCCESS);
					status = HttpStatus.ACCEPTED;
				}
			} else {
				logger.error("사용 불가능 토큰!!!");
				resultMap.put("message", FAIL);
				status = HttpStatus.UNAUTHORIZED;
			}
		} catch (Exception e) {
			logger.error("정보조회 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	
	// (1) 로그인 - 비밀번호 찾기
	@PostMapping("/findPass")
	private ResponseEntity<?> findPass(@RequestBody UserDto userDto) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		String userId = userDto.getId();
		String userName = userDto.getName();
		try {
			String pass = userService.findPass(userId, userName);
			if (pass != null) {
				resultMap.put("pass", pass);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} else {
				resultMap.put("message", FAIL);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			resultMap.put("message", FAIL);
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	// (2) 회원 가입 - 메인
	@PostMapping("/join")
	private ResponseEntity<?> join(@RequestBody UserDto userDto) {
//		Map<String, Object> resultMap = new HashMap<>();
//		HttpStatus status = null;
		try {
			userService.joinUser(userDto);
			return new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("0", HttpStatus.OK);
	}
	
	// (2) 회원 가입 - 아이디 중복 체크
	@GetMapping("/idcheck/{userid}")
	private ResponseEntity<?> idCheck(@PathVariable("userid") String userId) {
//		Map<String, Object> resultMap = new HashMap<>();
//		HttpStatus status = null;
		try {
			int cnt = userService.checkID(userId);
			return new ResponseEntity<String>(cnt+"", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("0", HttpStatus.OK);
	}
	
	// (3) 회원 정보 - 수정
	@PostMapping("/modify")
	private ResponseEntity<?> modify(@RequestBody UserDto userDto, HttpServletRequest request) throws ServletException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			userService.modifyUser(userDto);
			resultMap.put("userInfo", userDto);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			resultMap.put("message", FAIL);
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	// (3) 회원 정보 - 삭제
	@DeleteMapping("/delete/{userid}")
	private ResponseEntity<?> delete(@PathVariable("userid") String userid, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
			userService.deleteUser(userid); // 삭제 성공
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			resultMap.put("message", FAIL);
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	// (4) 로그아웃
	@GetMapping({"/logout/{service}", "/logout/{service}/{userid}"})
	public ResponseEntity<?> removeToken(@PathVariable("service") String service, @PathVariable(value = "userid", required = false) String userid, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			if (service.equals("default")) {
				userService.deletRefreshToken(userid);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} else if (service.equals("kakao")) {
				String accessToken = (String)jwtService.getClaims(request.getHeader("access-token")).get("access_token");
				logger.info("access token for logout : {}", accessToken);
				kakaoApi.kakaoLogout(accessToken);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			logger.error("로그아웃 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	// (5) access token 재발급
	@PostMapping("/refresh")
	public ResponseEntity<?> refreshToken(@RequestBody UserDto userDto, HttpServletRequest request)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		String token = request.getHeader("refresh-token");
		logger.debug("token : {}, userDto : {}", token, userDto);
		if (jwtService.checkToken(token)) {
			if (token.equals(userService.getRefreshToken(userDto.getId()))) {
				String accessToken = jwtService.createAccessToken("userid", userDto.getId());
				logger.debug("token : {}", accessToken);
				logger.debug("정상적으로 액세스토큰 재발급!!!");
				resultMap.put("access-token", accessToken);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			}
		} else {
			logger.debug("리프레쉬토큰도 사용불!!!!!!!");
			status = HttpStatus.UNAUTHORIZED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
}
