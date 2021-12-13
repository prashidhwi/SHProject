package com.sh.beans;

import java.io.Serializable;

public class Color implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2362582083625479464L;
	private int colorId;
	private String color;
	/**
	 * @return the colorId
	 */
	public int getColorId() {
		return colorId;
	}
	/**
	 * @param colorId the colorId to set
	 */
	public void setColorId(int colorId) {
		this.colorId = colorId;
	}
	/**
	 * @return the color
	 */
	public String getColor() {
		return color;
	}
	/**
	 * @param color the color to set
	 */
	public void setColor(String color) {
		this.color = color;
	}
	
	
}
