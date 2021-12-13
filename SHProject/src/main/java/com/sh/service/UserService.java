package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Payment;
import com.sh.beans.User;
import com.sh.dao.UserDao;
import com.sh.util.SecurityUtil;

@Service("userService")
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Transactional
	public String save(User user) throws Exception{
		if(user!=null){
			user.setPassword(SecurityUtil.encrypt(user.getPassword()));
		}
		if(user!=null && user.getUserId()>0){
			userDao.update(user);
		} else {
			userDao.save(user);
		}
		return "";
	}
	
	public List<User> getUserList(){
		return userDao.getUserList();
	}

	public User getUserById(int id) {
		return userDao.getUserById(id);
	}

}
