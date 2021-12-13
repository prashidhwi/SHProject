package com.sh.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.sh.beans.User;

@Repository("userDao")
public class UserDao extends BaseJdbcDaoSupport {

	public int save(User user) {
		String sql = "insert into user(username,password,full_name,status) values(?,?,?,1)";
		Object[] param = { user.getUsername(), user.getPassword(), user.getFullName() };
		return getJdbcTemplate().update(sql, param);
	}

	public int update(User user) {
		String sql = "update user set password=?, full_name=? where user_id=?";
		Object[] param = { user.getPassword(), user.getFullName(), user.getUserId() };
		return getJdbcTemplate().update(sql, param);
	}

	public List<User> getUserList() {
		return getJdbcTemplate().query(
				"select user_id as userId, username as username, full_name as fullName, status from user where status>0",
				new BeanPropertyRowMapper<User>(User.class));
	}

	public User getUserById(int id) {
		String sql = "select user_id as userId, username as username, full_name as fullName from user where user_id=? and status>0";
		return getJdbcTemplate().queryForObject(sql, new Object[] { id },
				new BeanPropertyRowMapper<User>(User.class));
	}

}