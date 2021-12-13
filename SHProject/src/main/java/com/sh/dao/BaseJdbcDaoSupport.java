package com.sh.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.sh.beans.User;
import com.sh.util.CommonUtil;

public abstract class BaseJdbcDaoSupport extends JdbcDaoSupport {

	@Autowired
	public void setSuperDataSource(DataSource dataSource) {
		super.setDataSource(dataSource);
	}

	public User getUser() {
		return CommonUtil.getUser();
	}

}
