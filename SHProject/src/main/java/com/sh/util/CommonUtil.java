package com.sh.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sh.beans.User;

public class CommonUtil {
	
	public static boolean isValidSession(HttpServletRequest request) {
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes();
		HttpSession session = attributes.getRequest().getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			if (user != null) {
				return true;
			}
		}
		return false;
	}
	
	public static User getUser() {
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes();
		HttpSession httpSession = attributes.getRequest().getSession(false);
		return (User) httpSession.getAttribute("user");
	}
}
