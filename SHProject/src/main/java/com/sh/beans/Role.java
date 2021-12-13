package com.sh.beans;

import org.springframework.security.core.GrantedAuthority;

public class Role implements GrantedAuthority {

	private static final long serialVersionUID = 1374492286642937020L;

	private String name;

	@Override
	public String getAuthority() {
		return this.name;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

}
