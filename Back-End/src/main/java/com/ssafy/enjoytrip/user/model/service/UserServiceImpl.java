package com.ssafy.enjoytrip.user.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.user.model.UserDto;
import com.ssafy.enjoytrip.user.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	private UserMapper userMapper;
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private UserServiceImpl(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public int checkID(String userId) throws Exception {
		return userMapper.checkID(userId);
	}

	@Override
	public String findPass(String userId, String userName) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.findPass(userId, userName);
	}

	@Override
	public void joinUser(UserDto userDto) throws Exception {
		userMapper.joinUser(userDto);
	}

	@Override
	public UserDto login(UserDto userDto) throws Exception {
		if (userDto.getId() == null || userDto.getPassword() == null)
			return null;
		return sqlSession.getMapper(UserMapper.class).login(userDto);
	}
	
	@Override
	public UserDto loginUser(String userId) throws Exception {
		return userMapper.loginUser(userId);
	}
	
	@Override
	public UserDto userInfo(String userid) throws Exception {
		return sqlSession.getMapper(UserMapper.class).userInfo(userid);
	}

	@Override
	public void modifyUser(UserDto userDto) throws Exception {
		userMapper.modifyUser(userDto);
	}

	@Override
	public void deleteUser(String userId) throws Exception {
		userMapper.deleteUser(userId);
	}
	
	@Override
	public void saveRefreshToken(String userid, String refreshToken) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("token", refreshToken);
		sqlSession.getMapper(UserMapper.class).saveRefreshToken(map);
	}

	@Override
	public Object getRefreshToken(String userid) throws Exception {
		return sqlSession.getMapper(UserMapper.class).getRefreshToken(userid);
	}

	@Override
	public void deletRefreshToken(String userid) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("token", null);
		sqlSession.getMapper(UserMapper.class).deleteRefreshToken(map);
	}

}
