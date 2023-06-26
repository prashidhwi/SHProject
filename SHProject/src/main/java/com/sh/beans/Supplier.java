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
public class Supplier implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6056398249069628849L;
	
	private int supplierId;
	private String supplierName;
	private String supplierCity;
	private int billId;
	private float amount;
	private String billDate;
	private Date invDate;
	private boolean isPaid;
	private boolean status;
	private String note;
	private String inputDate;
	private String inputUser;
	private String updateDate;
	private String updateUser;
	/**
	 * @return the supplierId
	 */
	public int getSupplierId() {
		return supplierId;
	}
	/**
	 * @param supplierId the supplierId to set
	 */
	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}
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
	 * @return the billId
	 */
	public int getBillId() {
		return billId;
	}
	/**
	 * @param billId the billId to set
	 */
	public void setBillId(int billId) {
		this.billId = billId;
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
	 * @return the billDate
	 */
	public String getBillDate() {
		return billDate;
	}
	/**
	 * @param billDate the billDate to set
	 */
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	/**
	 * @return the invDate
	 */
	public Date getInvDate() {
		return invDate;
	}
	/**
	 * @param invDate the invDate to set
	 */
	public void setInvDate(Date invDate) {
		this.invDate = invDate;
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
	 * @return the updateDate
	 */
	public String getUpdateDate() {
		return updateDate;
	}
	/**
	 * @param updateDate the updateDate to set
	 */
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	/**
	 * @return the updateUser
	 */
	public String getUpdateUser() {
		return updateUser;
	}
	/**
	 * @param updateUser the updateUser to set
	 */
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	/**
	 * @return the isPaid
	 */
	public boolean isPaid() {
		return isPaid;
	}
	/**
	 * @param isPaid the isPaid to set
	 */
	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
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
