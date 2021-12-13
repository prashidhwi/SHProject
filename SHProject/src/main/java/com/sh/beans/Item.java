package com.sh.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Item implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3515433300337503683L;
	private int itemId;
	private String itemName;
	private int qty;
	private float purchasePrice;
	private float price;
	private boolean status;
	private Timestamp inputDate;
	private Timestamp updateDate;
	private Boolean isAddStock;
	/**
	 * @return the itemId
	 */
	public int getItemId() {
		return itemId;
	}
	/**
	 * @param itemId the itemId to set
	 */
	public void setItemId(int itemId) {
		this.itemId = itemId;
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
	 * @return the price
	 */
	public float getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(float price) {
		this.price = price;
	}
	
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public Timestamp getInputDate() {
		return inputDate;
	}
	public void setInputDate(Timestamp inputDate) {
		this.inputDate = inputDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	/**
	 * @return the purchasePrice
	 */
	public float getPurchasePrice() {
		return purchasePrice;
	}
	/**
	 * @param purchasePrice the purchasePrice to set
	 */
	public void setPurchasePrice(float purchasePrice) {
		this.purchasePrice = purchasePrice;
	}
	/**
	 * @return the isAddStock
	 */
	public Boolean getIsAddStock() {
		return isAddStock;
	}
	/**
	 * @param isAddStock the isAddStock to set
	 */
	public void setIsAddStock(Boolean isAddStock) {
		this.isAddStock = isAddStock;
	}
	
	
}