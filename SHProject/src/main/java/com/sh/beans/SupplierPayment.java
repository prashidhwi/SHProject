/**
 * 
 */
package com.sh.beans;

import java.io.Serializable;
import java.sql.Date;

/**
 * @author pratik.maniyar
 *
 */
public class SupplierPayment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2130543634679015797L;
	private int supplierPaymentId;
	private String supplierName;
	private String supplierCity;
	private float amount;
	private String paymentDate;
	private Date payDate;
	private String note;
	private boolean status;
	private String inputDate;
	private String inputUser;
	/**
	 * @return the supplierName
	 */
	public String getSupplierName() {
		return supplierName;
	}
	/**
	 * @param supplierName the supplierName to set
	 */
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	/**
	 * @return the supplierCity
	 */
	public String getSupplierCity() {
		return supplierCity;
	}
	/**
	 * @param supplierCity the supplierCity to set
	 */
	public void setSupplierCity(String supplierCity) {
		this.supplierCity = supplierCity;
	}
	/**
	 * @return the amount
	 */
	public float getAmount() {
		return amount;
	}
	/**
	 * @param amount the amount to set
	 */
	public void setAmount(float amount) {
		this.amount = amount;
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
	public String getInputDate() {
		return inputDate;
	}
	/**
	 * @param inputDate the inputDate to set
	 */
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	/**
	 * @return the inputUser
	 */
	public String getInputUser() {
		return inputUser;
	}
	/**
	 * @param inputUser the inputUser to set
	 */
	public void setInputUser(String inputUser) {
		this.inputUser = inputUser;
	}
	/**
	 * @return the supplierPaymentId
	 */
	public int getSupplierPaymentId() {
		return supplierPaymentId;
	}
	/**
	 * @param supplierPaymentId the supplierPaymentId to set
	 */
	public void setSupplierPaymentId(int supplierPaymentId) {
		this.supplierPaymentId = supplierPaymentId;
	}
	/**
	 * @return the paymentDate
	 */
	public String getPaymentDate() {
		return paymentDate;
	}
	/**
	 * @param paymentDate the paymentDate to set
	 */
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	/**
	 * @return the payDate
	 */
	public Date getPayDate() {
		return payDate;
	}
	/**
	 * @param payDate the payDate to set
	 */
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

}
