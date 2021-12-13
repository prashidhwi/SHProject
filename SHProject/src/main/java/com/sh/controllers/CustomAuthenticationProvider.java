package com.sh.controllers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Role;
import com.sh.beans.User;
import com.sh.service.LoginService;
import com.sh.util.SecurityUtil;


@Component(value = "customAuthenticationProvider")
@Transactional(readOnly = true)
public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	final static Logger logger = Logger.getLogger(CustomAuthenticationProvider.class);

	@Autowired
	private LoginService loginService;

	public static final String ADMIN_ROLE = "ADMIN";
	public static final String USER_ROLE = "USER";

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		User user = null;
		String username = authentication.getName();
		String password = (String) authentication.getCredentials();

		try {
			password = SecurityUtil.encrypt(password);
			user = loginService.validateLogin(username, password);
		} catch (Exception e) {
			logger.error("Error while Login - ",e);
		}
		if (user == null) {
			throw new BadCredentialsException("Invalid Username or Password!!!");
		}else if(!user.isStatus()){
			throw new BadCredentialsException("This user is inactive. You can not Login.");
		}

		Role role = new Role();
		role.setName(ADMIN_ROLE);
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		user.setAuthorities(roles);
		Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
		return new UsernamePasswordAuthenticationToken(user, password, authorities);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

}
