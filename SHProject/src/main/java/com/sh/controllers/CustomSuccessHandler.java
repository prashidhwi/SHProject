package com.sh.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.sh.beans.User;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {
	final static Logger log = Logger.getLogger(CustomSuccessHandler.class);

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		session.setAttribute("user", ((User)authentication.getPrincipal()));
		redirectStrategy.sendRedirect(request, response, "/dashboard.do");
	}
	
	/**
	 * @return the redirectStrategy
	 */
	public RedirectStrategy getRedirectStrategy() {
		return redirectStrategy;
	}

	/**
	 * @param redirectStrategy
	 *            the redirectStrategy to set
	 */
	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}

}
