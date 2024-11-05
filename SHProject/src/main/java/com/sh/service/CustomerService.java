package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.beans.Customer;
import com.sh.beans.Payment;
import com.sh.dao.CustomerDao;

@Service("customerService")
public class CustomerService {
	
	@Autowired
	private CustomerDao customerDao;
	
	@Transactional
	public String save(Customer customer){
		if(customer!=null && customer.getCustomerId()>0){
			customerDao.update(customer);
		} else {
			customerDao.save(customer);
		}
		return "";
	}
	
	public List<Payment> getCustomerPaymentDetails(String customerName, String city){
		return customerDao.getPaymentDetails(customerName,city);
	}
	
	public List<Payment> getUnVerifiedPaymentDetails(String customerName, String city){
		return customerDao.getUnVerifiedPaymentDetails(customerName, city);
	}
	
	public List<Payment> getPaymentDetailsByCity(String city){
		return customerDao.getPaymentDetailsByCity(city);
	}

	public String verifyPayment(int paymentId, boolean verified) {
		int row = customerDao.verifyPayment(paymentId, verified);
		if(row>0){
			return "Payment Verified.";
		} else {
			return "Error in Payment verfication.";
		}
	}
	
	public List<Customer> getCustomerByCity(String city) {
		return customerDao.getCustomerByCity(city);
	}
	
	public int deletePayment(int paymentId) {
		return customerDao.deletePayment(paymentId);
	}

	public Payment getPaymentByPaymentId(int paymentId) {
		return customerDao.getPaymentByPaymentId(paymentId);
	}
}
