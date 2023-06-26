package com.sh.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Supplier;
import com.sh.beans.SupplierPayment;
import com.sh.dao.SupplierDao;

@Service("supplierService")
public class SupplierService {
	
	@Autowired
	private  SupplierDao supplierDao;
	
	@Transactional
	public String save(Supplier supplier){
		int row = supplierDao.save(supplier);
		if(row > 0) {
			return "Supplier Bill saved successfully.";
		} else {
			return "Supplier Bill is not saved.";
		}
	}

	public List<Supplier> getMatchingSupplier(String supplierName) {
		return supplierDao.getMatchingSupplier(supplierName);
	}

	public List<Supplier> getBillsBySupplier(Supplier supplierBean) {
		List<Supplier> supplierList = supplierDao.getBillsBySupplier(supplierBean);
		if(null != supplierList){
			for(Supplier supplier: supplierList){
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				supplier.setBillDate(dateFormat.format(new Date(supplier.getInvDate().getTime())));
			}
		}
		return supplierList;
	}

	public List<SupplierPayment> getSupplierPaymentList(Supplier supplierBean) {
		List<SupplierPayment> supplierPaymentList = supplierDao.getSupplierPaymentDetails(supplierBean.getSupplierName(), supplierBean.getSupplierCity());
		if(null != supplierPaymentList){
			for(SupplierPayment supplierPayment: supplierPaymentList){
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				supplierPayment.setPaymentDate(dateFormat.format(new Date(supplierPayment.getPayDate().getTime())));
			}
		}
		
		return supplierPaymentList;
	}

	@Transactional
	public String savePayment(SupplierPayment supplierPayment) {
		int row = supplierDao.savePayment(supplierPayment);
		if(row > 0) {
			return "Supplier Payment saved successfully.";
		} else {
			return "Supplier Payment is not saved.";
		}
	}

}
