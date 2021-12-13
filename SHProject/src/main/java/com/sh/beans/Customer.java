package com.sh.beans;

import java.sql.Date;

public class Customer {
	private int customerId;
	private String customerName;
	private String organizationName;
	private String address;
	private String city;
	private String contact;
	private String whatsappNo;
	private boolean status;
	private Date inputDate;
	private Date updateDate;
	private String gstNo;
	/**
	 * @return the customerId
	 */
	public int getCustomerId() {
		return customerId;
	}
	/**
	 * @param customerId the customerId to set
	 */
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	/**
	 * @return the customerName
	 */
	public String getCustomerName() {
		return customerName;
	}
	/**
	 * @param customerName the customerName to set
	 */
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	/**
	 * @return the organizationName
	 */
	public String getOrganizationName() {
		return organizationName;
	}
	/**
	 * @param organizationName the organizationName to set
	 */
	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the contact
	 */
	public String getContact() {
		return contact;
	}
	/**
	 * @param contact the contact to set
	 */
	public void setContact(String contact) {
		this.contact = contact;
	}
	/**
	 * @return the whatsappNo
	 */
	public String getWhatsappNo() {
		return whatsappNo;
	}
	/**
	 * @param whatsappNo the whatsappNo to set
	 */
	public void setWhatsappNo(String whatsappNo) {
		this.whatsappNo = whatsappNo;
	}
	/**
	 * @return the status
	 */
	public boolean isStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(boolean status) {
		this.status = status;
	}
	/**
	 * @return the inputDate
	 */
	public Date getInputDate() {
		return inputDate;
	}
	/**
	 * @param inputDate the inputDate to set
	 */
	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}
	/**
	 * @return the updateDate
	 */
	public Date getUpdateDate() {
		return updateDate;
	}
	/**
	 * @param updateDate the updateDate to set
	 */
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the gstNo
	 */
	public String getGstNo() {
		return gstNo;
	}
	/**
	 * @param gstNo the gstNo to set
	 */
	public void setGstNo(String gstNo) {
		this.gstNo = gstNo;
	}
	
	

}
