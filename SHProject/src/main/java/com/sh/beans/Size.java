package com.sh.beans;

import java.io.Serializable;

public class Size implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2362582083625479464L;
	private int sizeId;
	private String sizeCode;
	public int getSizeId() {
		return sizeId;
	}
	public void setSizeId(int sizeId) {
		this.sizeId = sizeId;
	}
	/**
	 * @return the sizeCode
	 */
	public String getSizeCode() {
		return sizeCode;
	}
	/**
	 * @param sizeCode the sizeCode to set
	 */
	public void setSizeCode(String sizeCode) {
		this.sizeCode = sizeCode;
	}

}
