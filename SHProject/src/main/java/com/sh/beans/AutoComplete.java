package com.sh.beans;

import java.io.Serializable;

public class AutoComplete implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4007797141358105481L;
	String label;
	String value;
	/**
	 * @return the label
	 */
	public String getLabel() {
		return label;
	}
	/**
	 * @param label the label to set
	 */
	public void setLabel(String label) {
		this.label = label;
	}
	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
	
	
}
