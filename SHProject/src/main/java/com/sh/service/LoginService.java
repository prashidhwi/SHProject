package com.sh.service;

import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.beans.User;
import com.sh.dao.LoginDao;

@Service("loginService")
public class LoginService {
	
	final static Logger logger = Logger.getLogger(LoginService.class);
	
	@Autowired
	private LoginDao loginDao;

	public User validateLogin(String username, String password) throws SQLException {
		// TODO Auto-generated method stub
		return loginDao.validateUser(username, password);
	}

}
