package com.sh.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Invoice;
import com.sh.beans.InvoiceDetails;
import com.sh.dao.InvoiceDao;
import com.sh.dao.ItemDao;

@Service("invoiceService")
public class InvoiceService {
	
	@Autowired
	private InvoiceDao invoiceDao;
	
	@Autowired
	private ItemDao itemDao;
	
	@Transactional
	public String save(Invoice invoice){
		int insertedInvoiceCount = 0;
		if(invoice.getEditFlag()!=null && invoice.getEditFlag().equalsIgnoreCase("true")){
			insertedInvoiceCount = invoiceDao.updateInvoiceHeader(invoice);
		} else {
			insertedInvoiceCount = invoiceDao.insertInvoiceHeader(invoice);
		}
		String message = "";
		if(insertedInvoiceCount>0 && invoice.getInvoiceDetails()!= null && invoice.getInvoiceDetails().size()>0){
			int invoiceDetailsCount = invoice.getInvoiceDetails().size();
			List<InvoiceDetails> oldInvoiceDetails = null;
			if(invoice.getEditFlag()!=null && invoice.getEditFlag().equalsIgnoreCase("true")){
				oldInvoiceDetails = invoiceDao.getInvoiceDetailsByInvoiceNo(invoice.getInvoiceNo());
				invoiceDao.deleteInvoiceDetails(invoice.getInvoiceNo());
			}
			int[] insertedInvoiceDetailsCounts = invoiceDao.insertInvoiceDetails(invoice.getInvoiceDetails());
			if(insertedInvoiceDetailsCounts.length==invoiceDetailsCount){
				if (oldInvoiceDetails != null) {
					List<Map<String, Object>> oldItemList = new ArrayList<Map<String, Object>>();
					for (InvoiceDetails invoiceDetails : oldInvoiceDetails) {
						Map<String, Object> itemMap = new HashMap<String, Object>();
						itemMap.put("itemName", invoiceDetails.getItemName());
						itemMap.put("qty", invoiceDetails.getQty());
						oldItemList.add(itemMap);
					}
					itemDao.addQuantity(oldItemList);
				}
				List<Map<String, Object>> itemList = new ArrayList<Map<String,Object>>();
				for(InvoiceDetails invoiceDetails:invoice.getInvoiceDetails()){
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("itemName", invoiceDetails.getItemName());
					itemMap.put("qty", invoiceDetails.getQty());
					itemList.add(itemMap);
				}
				int[] qtyUpdate = itemDao.subtractQuantity(itemList);
				if(qtyUpdate.length==itemList.size()){
					message = "Invoice Saved Successfully";
				} else {
					message = "Error updating Stock of Items.";
				}
			} else {
				message = "Error saving Invoice.";
			}
		} else {
			message = "Error saving Invoice.";
		}
		
		return message;
	}
	
	public List<Invoice> getAllInvoices() {
		return invoiceDao.getAllInvoices();
	}
	
	public Invoice getInvoice(int invoiceNo) {
		Invoice invoice = invoiceDao.getInvoiceByInvoiceNo(invoiceNo);
		if(invoice != null){
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			invoice.setInvDate(dateFormat.format(new Date(invoice.getInvoiceDate().getTime())));
			invoice.setInvoiceDetails(invoiceDao.getInvoiceDetailsByInvoiceNo(invoiceNo));
		}
		
		return invoice;
	}
	
	public String updateInvoicePaymentStatus(int invoiceNo,boolean isPaid){
		int updatePayment = invoiceDao.updateInvoicePaymentStatus(invoiceNo, isPaid);
		if(updatePayment>0){
			return "Invoice is marked as " + (isPaid?"Paid":"UnPaid");
		} else {
			return "Failed to update Invoice Payment Status";
		}
	}
	
	public Integer getMaxInvoiceNumber() {
		return invoiceDao.getMaxInvoiceNumber();
	}
	
	public List<Invoice> getUnPaidInvoicesByCustomer(Invoice invoice) {
		return invoiceDao.getUnPaidInvoicesByCustomer(invoice.getCustomer(), invoice.getCity());
	}
	
	public List<Invoice> getAllInvoicesByCustomer(String customerName, String city){
		return invoiceDao.getInvoicesByCustomer(customerName, city);
	}
	
	public List<Invoice> getAllInvoicesByCity(String city){
		return invoiceDao.getInvoicesByCity(city);
	}

	public void deleteInvoice(int invoiceNo) {
		Invoice invoice = invoiceDao.getInvoiceByInvoiceNo(invoiceNo);
		if (null != invoice && !invoice.isPaid()) {
			List<InvoiceDetails> invoiceDetailList = invoiceDao.getInvoiceDetailsByInvoiceNo(invoiceNo);
			List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
			if (null != invoiceDetailList) {
				for (InvoiceDetails invoiceDetails : invoiceDetailList) {
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("itemName", invoiceDetails.getItemName());
					itemMap.put("qty", invoiceDetails.getQty());
					itemList.add(itemMap);
				}
			}
			itemDao.addQuantity(itemList);
		}
		invoiceDao.deleteInvoice(invoiceNo);
	}
	
	public Invoice getNetInvoice(List<Integer> invoiceNoList){
		return invoiceDao.getNetInvoice(invoiceNoList);
	}
}
