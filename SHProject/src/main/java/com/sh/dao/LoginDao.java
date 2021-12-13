package com.sh.dao;

import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.sh.beans.User;

@Repository("loginDao")
public class LoginDao extends BaseJdbcDaoSupport {

	final static Logger logger = Logger.getLogger(LoginDao.class);

	private final String validateUserQuery = "select user_id as userId, username, password, full_name as fullName, status from user WHERE username=? AND password=?";

	public User validateUser(String username, String password) throws SQLException {
		Object[] params = { username, password };
		try {
			User user = getJdbcTemplate().queryForObject(validateUserQuery, params,
					new BeanPropertyRowMapper<User>(User.class));
			return user;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
}
