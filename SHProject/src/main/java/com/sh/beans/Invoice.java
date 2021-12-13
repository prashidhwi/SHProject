	/**
 * 
 */
package com.sh.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

/**
 * @author pratik.maniyar
 *
 */
public class Invoice implements Serializable {
	
	private int invoiceNo;
	private String customer;
	private String city;
	private String invDate;
	private Date invoiceDate;
	private float grandTotal;
	private int discount;
	private boolean isPaid;
	private String receiptId;
	private String note;
	private int status = 1;
	private String editFlag;
	
	private List<InvoiceDetails> invoiceDetails;
	/**
	 * @return the invoiceNo
	 */
	public int getInvoiceNo() {
		return invoiceNo;
	}
	/**
	 * @param invoiceNo the invoiceNo to set
	 */
	public void setInvoiceNo(int invoiceNo) {
		this.invoiceNo = invoiceNo;
	}
	/**
	 * @return the customer
	 */
	public String getCustomer() {
		return customer;
	}
	/**
	 * @param customer the customer to set
	 */
	public void setCustomer(String customer) {
		this.customer = customer;
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
	 * @return the invoiceDate
	 */
	public Date getInvoiceDate() {
		return invoiceDate;
	}
	/**
	 * @param invoiceDate the invoiceDate to set
	 */
	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
	/**
	 * @return the grandTotal
	 */
	public float getGrandTotal() {
		return grandTotal;
	}
	/**
	 * @param grandTotal the grandTotal to set
	 */
	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
	}
	/**
	 * @return the discount
	 */
	public int getDiscount() {
		return discount;
	}
	/**
	 * @param discount the discount to set
	 */
	public void setDiscount(int discount) {
		this.discount = discount;
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
	 * @return the invoiceDetails
	 */
	public List<InvoiceDetails> getInvoiceDetails() {
		return invoiceDetails;
	}
	/**
	 * @param invoiceDetails the invoiceDetails to set
	 */
	public void setInvoiceDetails(List<InvoiceDetails> invoiceDetails) {
		this.invoiceDetails = invoiceDetails;
	}
	/**
	 * @return the receiptId
	 */
	public String getReceiptId() {
		return receiptId;
	}
	/**
	 * @param receiptId the receiptId to set
	 */
	public void setReceiptId(String receiptId) {
		this.receiptId = receiptId;
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
	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
	/**
	 * @return the invDate
	 */
	public String getInvDate() {
		return invDate;
	}
	/**
	 * @param invDate the invDate to set
	 */
	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}
	/**
	 * @return the editFlag
	 */
	public String getEditFlag() {
		return editFlag;
	}
	/**
	 * @param editFlag the editFlag to set
	 */
	public void setEditFlag(String editFlag) {
		this.editFlag = editFlag;
	}
	
}
