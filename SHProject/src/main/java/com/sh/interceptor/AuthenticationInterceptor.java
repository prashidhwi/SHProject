package com.sh.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sh.util.CommonUtil;


@Component
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if (!CommonUtil.isValidSession(request)) {
			response.sendRedirect(request.getContextPath() + "/login.do");
			return false;
		}
		return true;
	}
	
	
}