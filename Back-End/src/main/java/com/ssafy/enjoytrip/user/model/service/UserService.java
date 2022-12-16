package com.ssafy.enjoytrip.user.model.service;

import com.ssafy.enjoytrip.user.model.UserDto;

public interface UserService {

	int checkID(String userId) throws Exception;
	String findPass(String userId, String userName) throws Exception;
	void joinUser(UserDto userDto) throws Exception;
	UserDto loginUser(String userId) throws Exception;
	public UserDto login(UserDto userDto) throws Exception;
	public UserDto userInfo(String userid) throws Exception;
	void modifyUser(UserDto userDto) throws Exception;
	void deleteUser(String userId) throws Exception;
	
	public void saveRefreshToken(String userid, String refreshToken) throws Exception;
	public Object getRefreshToken(String userid) throws Exception;
	public void deletRefreshToken(String userid) throws Exception;

}
