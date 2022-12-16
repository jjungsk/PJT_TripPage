package com.ssafy.enjoytrip.user.model.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.user.model.UserDto;

@Mapper
public interface UserMapper {
	
	int checkID(String userId) throws SQLException;
	String findPass(String userId, String userName) throws SQLException;
	void joinUser(UserDto userDto) throws SQLException;
	UserDto loginUser(String userId) throws SQLException;
	public UserDto login(UserDto userDto) throws SQLException;
	public UserDto userInfo(String userId) throws SQLException;
	void modifyUser(UserDto userDto) throws SQLException;
	void deleteUser(String userId) throws SQLException;
	
	public void saveRefreshToken(Map<String, String> map) throws SQLException;
	public Object getRefreshToken(String userId) throws SQLException;
	public void deleteRefreshToken(Map<String, String> map) throws SQLException;

}

/*
@Override
public int checkID(String userId) throws SQLException {
	int cnt = 1;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn = dbUtil.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("select count(user_id) \n");
		sql.append("from users \n");
		sql.append("where user_id = ?");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, userId);
		rs = pstmt.executeQuery();
		rs.next();
		cnt = rs.getInt(1);
	} finally {
		dbUtil.close(rs, pstmt, conn);
	}
	return cnt;
}

@Override
public String findPass(String userId, String userName) throws SQLException {
	String password = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn = dbUtil.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("select user_password \n");
		sql.append("from users \n");
		sql.append("where user_id = ? and user_name = ? ");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, userId);
		pstmt.setString(2, userName);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			password = rs.getString("user_password");
		}
	} finally {
		dbUtil.close(rs, pstmt, conn);
	}
	return password;
}

@Override
public int joinUser(UserDto userDto) throws SQLException {
	int cnt = 0;
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn = dbUtil.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("insert into users (user_id, user_password, user_name, user_email, user_tel, manager) \n");
		sql.append("values (?, ?, ?, ?, ?, ?)");
		pstmt = conn.prepareStatement(sql.toString());
		int idx = 0;
		pstmt.setString(++idx, userDto.getId());
		pstmt.setString(++idx, userDto.getPassword());
		pstmt.setString(++idx, userDto.getName());
		pstmt.setString(++idx, userDto.getEmail());
		pstmt.setString(++idx, userDto.getTel());
		pstmt.setInt(++idx, userDto.getIsManager());

		cnt = pstmt.executeUpdate();
	} finally {
		dbUtil.close(pstmt, conn);
	}
	return cnt;
}

@Override
public UserDto loginUser(String userId) throws SQLException {
	UserDto user = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn = dbUtil.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("select user_id, user_password, user_name, user_email, user_tel, manager \n");
		sql.append("from users \n");
		sql.append("where user_id = ?");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, userId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			user = new UserDto();
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setIsManager(rs.getInt("manager"));
		}
	} finally {
		dbUtil.close(rs, pstmt, conn);
	}
	return user;
}

@Override
public int modifyUser(UserDto userDto) throws SQLException {
	int cnt = 0;
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn = dbUtil.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("update users \n");
		sql.append("set user_password=?, user_name=?, user_email=?, user_tel=? \n");
		sql.append("where user_id = ?");
		pstmt = conn.prepareStatement(sql.toString());
		int idx = 0;
		pstmt.setString(++idx, userDto.getPassword());
		pstmt.setString(++idx, userDto.getName());
		pstmt.setString(++idx, userDto.getEmail());
		pstmt.setString(++idx, userDto.getTel());
		pstmt.setString(++idx, userDto.getId());
		cnt = pstmt.executeUpdate();
	} finally {
		dbUtil.close(pstmt, conn);
	}
	return cnt;
}

@Override
public int deleteUser(String userId) throws SQLException {
	int cnt = 0;
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn = dbUtil.getConnection();
		conn.setAutoCommit(false);
		StringBuilder sql = new StringBuilder();
		sql.append("SET foreign_key_checks = 0 \n");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.executeUpdate();
		sql.setLength(0);
		pstmt.close();

		sql.append("delete from users \n");
		sql.append("where user_id = ?");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, userId);
		cnt = pstmt.executeUpdate();
		sql.setLength(0);
		pstmt.close();

		sql.append("SET foreign_key_checks = 1 \n");
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.executeUpdate();
		conn.commit();
	} catch (SQLException e) {
		conn.rollback();
	} finally {
		dbUtil.close(pstmt, conn);
	}
	return cnt;
}
*/