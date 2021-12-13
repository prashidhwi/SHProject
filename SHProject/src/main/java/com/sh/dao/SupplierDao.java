package com.sh.dao;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.sh.beans.Supplier;
import com.sh.beans.SupplierPayment;

@Repository("supplierDao")
public class SupplierDao extends BaseJdbcDaoSupport {
	
	public int save(Supplier supplier) {
		String sql = "insert into supplier(supplier_name,supplier_city,bill_id,amount,bill_date,status,input_date,input_user) values(?,?,?,?,str_to_date(?,'%d/%m/%Y'),1,sysdate(),?)";
		Object[] param = { supplier.getSupplierName(), supplier.getSupplierCity(), supplier.getBillId(), supplier.getAmount(), supplier.getBillDate(),getUser().getFullName()};
		return getJdbcTemplate().update(sql, param);
	}
	
	public List<Supplier> getMatchingSupplier(String supplierName) {
		String sql = "select distinct supplier_name as supplierName, supplier_city as supplierCity from supplier where status>0 and upper(supplier_name) like upper('" + supplierName + "%')";
		return getJdbcTemplate().query(sql, new BeanPropertyRowMapper<Supplier>(Supplier.class));
	}
	
	public List<Supplier> getSupplierDetails(String supplierName, String supplierCity) {
		String sql = "select supplier_id as supplierId, bill_id as billId, amount, paid, bill_date as billDate from supplier where supplier_name=? and supplier_city=? and status>0";
		return getJdbcTemplate().query(sql, new BeanPropertyRowMapper<Supplier>(Supplier.class));
	}

	public List<Supplier> getBillsBySupplier(Supplier supplierBean) {
		String sql = "select supplier_id as supplierId, bill_id as billId, amount, paid, bill_date as invDate from supplier where supplier_name=? and supplier_city=? and status>0";
		Object[] param = { supplierBean.getSupplierName(), supplierBean.getSupplierCity() };
		return getJdbcTemplate().query(sql, param, new BeanPropertyRowMapper<Supplier>(Supplier.class));
	}

	public List<SupplierPayment> getSupplierPaymentDetails(String supplierName, String supplierCity) {
		String sql = "select supplier_payment_id as supplierPaymentId, amount, payment_date as payDate, note from supplier_payment where supplier_name=? and supplier_city=?";
		Object[] param = { supplierName, supplierCity };
		return getJdbcTemplate().query(sql, param, new BeanPropertyRowMapper<SupplierPayment>(SupplierPayment.class));
	}

	public int savePayment(SupplierPayment supplierPayment) {
		String sql = "INSERT INTO supplier_payment(supplier_name, supplier_city, amount, payment_date, note, input_date, input_user) VALUES (?, ?, ?, str_to_date(?,'%d/%m/%Y'), ?, sysdate(), ?)";
		Object[] param = {supplierPayment.getSupplierName(), supplierPayment.getSupplierCity(), supplierPayment.getAmount(), supplierPayment.getPaymentDate(), supplierPayment.getNote(), getUser().getFullName()};
		return getJdbcTemplate().update(sql, param);
	}

}
