package com.sh.dao;

import com.sh.beans.Customer;
import com.sh.beans.Payment;
import com.sh.dao.BaseJdbcDaoSupport;
import java.util.List;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("customerDao")
public class CustomerDao extends BaseJdbcDaoSupport {
  public int save(Customer customer) {
    String sql = "insert into customer(customer_name,organization_name,address,contact,whatsapp_no,status,input_date,gst_no,city) values(?,?,?,?,?,1,sysdate(),?,?)";
    Object[] param = { customer.getCustomerName(), customer.getOrganizationName(), customer.getAddress(), 
        customer.getContact(), customer.getWhatsappNo(), customer.getGstNo(), customer.getCity() };
    return getJdbcTemplate().update(sql, param);
  }
  
  public int update(Customer customer) {
    String sql = "update customer set customer_name=?, organization_name=?,address=?,contact=?,whatsapp_no=?,update_date=sysdate(), city=?, gst_no=? where customer_id=?";
    Object[] param = { customer.getCustomerName(), customer.getOrganizationName(), customer.getAddress(), 
        customer.getContact(), customer.getWhatsappNo(), customer.getCity(), customer.getGstNo(), 
				customer.getCustomerId() };
    return getJdbcTemplate().update(sql, param);
  }
  
  public int delete(int customerId) {
    String sql = "update customer set status=0,update_date=sysdate() where customer_id=?";
		return getJdbcTemplate().update(sql, customerId);
  }
  
  public Customer getCustomerById(int id) {
    String sql = "select customer_id as customerId, customer_name as customerName, organization_name as organizationName, address, contact, whatsapp_no as whatsappNo, input_Date as inputDate, update_date as updateDate, city, gst_no as gstNo from customer where customer_id=? and status>0";
		return getJdbcTemplate().queryForObject(sql, new Object[] { id },
				new BeanPropertyRowMapper<Customer>(Customer.class));
  }
  
  public List<Customer> getCustomer() {
    return getJdbcTemplate().query(
        "select customer_id as customerId, customer_name as customerName, organization_name as organizationName, address, contact, whatsapp_no as whatsappNo, input_Date as inputDate, update_date as updateDate, city, gst_no as gstNo from customer where status>0", 
        (RowMapper)new BeanPropertyRowMapper(Customer.class));
  }
  
  public List<Customer> getMatchingCustomer(String customerName) {
		String sql = "select customer_id as customerId, customer_name as customerName, organization_name as organizationName, address,city, contact, whatsapp_no as whatsappNo, input_Date as inputDate, update_date as updateDate from customer where status>0 and upper(customer_name) like upper('"
				+ customerName + "%')";
		return getJdbcTemplate().query(sql, new BeanPropertyRowMapper<Customer>(Customer.class));
  }
  
  public List<Customer> getMatchingCity(String city) {
		String sql = "select customer_id as customerId, customer_name as customerName, organization_name as organizationName, address,city, contact, whatsapp_no as whatsappNo, input_Date as inputDate, update_date as updateDate from customer where status>0 and upper(city) like upper('"
				+ city + "%')";
		return getJdbcTemplate().query(sql, new BeanPropertyRowMapper<Customer>(Customer.class));
  }
  
  public List<Customer> getCustomerByCity(String city) {
    String sql = "select customer_id as customerId, customer_name as customerName, organization_name as organizationName, address,city, contact, whatsapp_no as whatsappNo, input_Date as inputDate, update_date as updateDate from customer where status>0 and upper(city) = upper(?)";
		return getJdbcTemplate().query(sql, new Object[] { city }, new BeanPropertyRowMapper<Customer>(Customer.class));
  }
  
  public int saveCustomerPayment(Payment payment) {
    String sql = "insert into payment (customer, city, amount, payment_date, reference) values (?,?,?,str_to_date(?,'%d/%m/%Y'),?)";
		Object[] param = { payment.getCustomer(), payment.getCity(), payment.getAmount(), payment.getPayDate(),
        payment.getReference() };
    return getJdbcTemplate().update(sql, param);
  }
  
  public List<Payment> getPaymentDetails(String customerName, String city) {
    String sql = "select payment_id as paymentId, customer, city, amount, date_format(payment_date,'%d/%m/%Y') as payDate, payment_date as paymentDate, reference, verified from payment where customer=? and city=?";
    Object[] param = { customerName, city };
		return getJdbcTemplate().query(sql, param, new BeanPropertyRowMapper<Payment>(Payment.class));
  }
  
  public List<Payment> getUnVerifiedPaymentDetails(String customerName, String city) {
    String sql = "select payment_id as paymentId, customer, city, amount, date_format(payment_date,'%d/%m/%Y') as payDate, payment_date as paymentDate, reference, verified from payment where customer=? and city=? and verified=0";
    Object[] param = { customerName, city };
		return getJdbcTemplate().query(sql, param, new BeanPropertyRowMapper<Payment>(Payment.class));
  }
  
  public List<Payment> getPaymentDetailsByCity(String city) {
    String sql = "select payment_id as paymentId, customer, city, amount, date_format(payment_date,'%d/%m/%Y') as payDate, reference from payment where city=? and verified=0 order by customer,city,payment_date";
    Object[] param = { city };
		return getJdbcTemplate().query(sql, param, new BeanPropertyRowMapper<Payment>(Payment.class));
  }
  
  public int verifyPayment(int paymentId, boolean verified) {
    String sql = "update payment set verified=? where payment_id=?";
		Object[] param = { verified, paymentId };
    return getJdbcTemplate().update(sql, param);
  }
  
  public int deletePayment(int paymentId) {
    String sql = "delete from payment where payment_id=?";
    return getJdbcTemplate().update(sql, new Object[] { Integer.valueOf(paymentId) });
  }
  
  public Payment getPaymentByPaymentId(int paymentId) {
    String sql = "select payment_id as paymentId, customer, city, amount, date_format(payment_date,'%d/%m/%Y') as payDate, payment_date as paymentDate, reference, verified from payment where payment_id=?";
    Object[] param = { Integer.valueOf(paymentId) };
    return (Payment)getJdbcTemplate().queryForObject(sql, param, (RowMapper)new BeanPropertyRowMapper(Payment.class));
  }
}
