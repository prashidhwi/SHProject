/**
 * 
 */
package com.sh.beans;

import java.io.Serializable;

/**
 * @author pratik.maniyar
 *
 */
public class InvoiceDetails implements Serializable {
	
	private int invoiceNo;
	private int itemNo;
	private String itemName;
	private String details;
	private int qty;
	private float amount;
	private float total;
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
	 * @return the itemNo
	 */
	public int getItemNo() {
		return itemNo;
	}
	/**
	 * @param itemNo the itemNo to set
	 */
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	/**
	 * @return the itemName
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName the itemName to set
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return the qty
	 */
	public int getQty() {
		return qty;
	}
	/**
	 * @param qty the qty to set
	 */
	public void setQty(int qty) {
		this.qty = qty;
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
	 * @return the total
	 */
	public float getTotal() {
		return total;
	}
	/**
	 * @param total the total to set
	 */
	public void setTotal(float total) {
		this.total = total;
	}
	/**
	 * @return the details
	 */
	public String getDetails() {
		return details;
	}
	/**
	 * @param details the details to set
	 */
	public void setDetails(String details) {
		this.details = details;
	}

}
