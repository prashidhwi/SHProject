package com.sh.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.sh.beans.Invoice;
import com.sh.beans.InvoiceDetails;

@Repository("invoiceDao")
public class InvoiceDao extends BaseJdbcDaoSupport {

	public Integer getMaxInvoiceNumber() {
		String sql = "select max(invoice_no) from invoice";

		return getJdbcTemplate().queryForObject(sql, Integer.class);
	}

	public int[] insertInvoiceDetails(List<InvoiceDetails> invoiceDetails) {
		String sql = "insert into invoice_details (invoice_no,item_no,item_name,details,qty,amount,total) values (?,?,?,?,?,?,?)";
		List<Object[]> params = new ArrayList<Object[]>();
		for (InvoiceDetails invoiceDetail : invoiceDetails) {
			Object[] param = { invoiceDetail.getInvoiceNo(), invoiceDetail.getItemNo(), invoiceDetail.getItemName(),
					invoiceDetail.getDetails(), invoiceDetail.getQty(), invoiceDetail.getAmount(),
					invoiceDetail.getTotal() };
			params.add(param);
		}
		return getJdbcTemplate().batchUpdate(sql, params);
	}

	public int insertInvoiceHeader(Invoice invoice) {
		String sql = "insert into invoice (invoice_no,customer,city,invoice_date,grand_total,discount,paid,status,receipt_id,	notes) values (?,?,?,str_to_date(?,'%d/%m/%Y'),?,?,?,1,?,?)";
		Object[] param = { invoice.getInvoiceNo(), invoice.getCustomer(), invoice.getCity(), invoice.getInvDate(),
				invoice.getGrandTotal(), invoice.getDiscount(), invoice.isPaid(), invoice.getReceiptId(),
				invoice.getNote() };
		return getJdbcTemplate().update(sql, param);
	}

	public List<Invoice> getAllInvoices() {
		String sql = "select invoice_no as invoiceNo,customer,city,invoice_date as invoiceDate,grand_total as grandTotal,paid as paid,receipt_id as receiptId,notes as note from invoice where status>0 order by invoice_date,invoice_no desc";
		return getJdbcTemplate().query(sql, new BeanPropertyRowMapper<Invoice>(Invoice.class));
	}

	public Invoice getInvoiceByInvoiceNo(int invoiceNo) {
		String sql = "select invoice_no as invoiceNo,customer,city,invoice_date as invoiceDate,grand_total as grandTotal,paid as paid,receipt_id as receiptId,notes as note from invoice where invoice_no=? and status>0";
		return getJdbcTemplate().queryForObject(sql, new Object[] { invoiceNo },
				new BeanPropertyRowMapper<Invoice>(Invoice.class));
	}

	public List<InvoiceDetails> getInvoiceDetailsByInvoiceNo(int invoiceNo) {
		String sql = "select invoice_no as invoiceNo,item_no as itemNo,item_name as itemName,details,qty,amount,total from invoice_details where invoice_no=? and status>0 order by item_no";
		return getJdbcTemplate().query(sql, new Object[] { invoiceNo },
				new BeanPropertyRowMapper<InvoiceDetails>(InvoiceDetails.class));
	}

	public void deleteInvoiceDetails(int invoiceNo) {
		getJdbcTemplate().update("delete from invoice_details where invoice_no=?", invoiceNo);
	}

	public void deleteInvoice(int invoiceNo) {
		getJdbcTemplate().update("update invoice_details set status=0 where invoice_no=?", invoiceNo);
		getJdbcTemplate().update("update invoice set status=0 where invoice_no=?", invoiceNo);
	}

	public int updateInvoiceHeader(Invoice invoice) {
		String sql = "update invoice set grand_total=?, paid = ?, receipt_id=?, notes=? where invoice_no=?";
		Object[] params = { invoice.getGrandTotal(), invoice.isPaid(), invoice.getReceiptId(), invoice.getNote(),
				invoice.getInvoiceNo() };

		return getJdbcTemplate().update(sql, params);
	}

	public int updateInvoicePaymentStatus(int invoiceNo, boolean isPaid) {
		return getJdbcTemplate().update("update invoice set paid=? where invoice_no=?",
				new Object[] { isPaid, invoiceNo });
	}

	public List<Invoice> getUnPaidInvoicesByCustomer(String customer, String city) {
		String sql = "select invoice_no as invoiceNo,customer,city,date_format(invoice_date,'%d/%m/%Y') as invDate,grand_total as grandTotal,paid as paid,receipt_id as receiptId,notes as note from invoice where status>0 and customer=? and city=? and paid=0";
		return getJdbcTemplate().query(sql, new Object[] { customer, city },
				new BeanPropertyRowMapper<Invoice>(Invoice.class));
	}

	public List<Invoice> getInvoicesByCustomer(String customerName, String city) {
		String sql = "select invoice_no as invoiceNo,customer,city,date_format(invoice_date,'%d/%m/%Y') as invDate,invoice_date as invoiceDate,grand_total as grandTotal,paid as paid,receipt_id as receiptId,notes as note from invoice where status>0 and customer=? and city=?";
		return getJdbcTemplate().query(sql, new Object[] { customerName, city },
				new BeanPropertyRowMapper<Invoice>(Invoice.class));
	}

	public List<Invoice> getInvoicesByCity(String city) {
		String sql = "select invoice_no as invoiceNo,customer,city,date_format(invoice_date,'%d/%m/%Y') as invDate,"
				+ "grand_total as grandTotal,paid as paid,receipt_id as receiptId,notes as note "
				+ "from invoice where status>0 and city=? and paid=0 order by customer,city,invoice_date";
		return getJdbcTemplate().query(sql, new Object[] { city }, new BeanPropertyRowMapper<Invoice>(Invoice.class));
	}

	public Invoice getNetInvoice(List<Integer> invoiceNoList) {
		try {
			String inParams = String.join(",", invoiceNoList.stream().map(id -> id + "").collect(Collectors.toList()));
			String sql = "select invoice_date as invoiceDate from invoice "
					+ "where invoice_no in ( select invoice_no "
					+ "from invoice_details where invoice_no in (?) and upper(item_no)=upper('Net') ) "
					+ "and paid=0 and status>0 order by invoice_date desc  limit 1";
			return getJdbcTemplate().queryForObject(sql, new Object[] { inParams },
					new BeanPropertyRowMapper<Invoice>(Invoice.class));
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
