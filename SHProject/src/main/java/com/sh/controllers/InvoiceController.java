/**
 * 
 */
package com.sh.controllers;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sh.beans.Invoice;
import com.sh.beans.InvoiceDataTable;
import com.sh.service.InvoiceService;

/**
 * @author pratik.maniyar
 *
 */
@Controller  
@RequestMapping("/invoice")
public class InvoiceController {
	
	@Autowired
    ServletContext context;
	
	@Autowired
	InvoiceService invoiceService;
	
	@RequestMapping(value = "/invoice", method = RequestMethod.GET)
	public String viewInvoice(Model m) {
		// List<Customer> list=customerDao.getCustomer();
		// m.addAttribute("list",list);
		Integer maxInvoiceNumber = invoiceService.getMaxInvoiceNumber();
		if(maxInvoiceNumber!=null){
			maxInvoiceNumber++;
		} else {
			maxInvoiceNumber = 1;
		}
		m.addAttribute("invoiceNumber",maxInvoiceNumber);
		return "invoice";
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST, consumes= "application/json")
	public @ResponseBody String save(@RequestBody String invoice) {
		Invoice invoiceBean = new Gson().fromJson(invoice, Invoice.class);
		String message = invoiceService.save(invoiceBean);
		
		return new Gson().toJson(message);
	}
	
	@RequestMapping(value = { "/list" }, method = { RequestMethod.POST })
	@ResponseBody
	public InvoiceDataTable listInvoices(@RequestParam("draw") int draw, @RequestParam("start") int start,
			@RequestParam("length") int length, @RequestParam("search[value]") String searchValue,
			@RequestParam("order[0][column]") int orderColumn, @RequestParam("order[0][dir]") String orderDir) {
		String[] columnNames = { "invoice_no", "Customer", "city", "grand_total", "paid", "invoice_date", "receipt_id",
				"notes" };
		String orderBy = columnNames[orderColumn];

		List<Invoice> data = this.invoiceService.getPaginatedData(start, length, searchValue, orderBy, orderDir);

		int recordsTotal = this.invoiceService.getTotalRecordsCount();
		int recordsFiltered = searchValue.isEmpty() ? recordsTotal
				: this.invoiceService.getFilteredRecordsCount(searchValue);

		return new InvoiceDataTable(draw, recordsTotal, recordsFiltered, data);
	}
	
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String viewInvoices(Model model){
//		model.addAttribute("invoiceList", invoiceService.getAllInvoices());
		return "viewinvoice_server";
	}
	
	@RequestMapping(value="/edit", method = RequestMethod.GET)  
    public String edit(@RequestParam(value="invoiceNo") int invoiceNo, Model model){  
		model.addAttribute("invoice", invoiceService.getInvoice(invoiceNo));
		model.addAttribute("editFlag", true);
		return "invoice";
	}
	
	 @RequestMapping(value="/delete",method = RequestMethod.GET)  
    public String delete(@RequestParam(value="invoiceNo") int invoiceNo, Model model){  
        invoiceService.deleteInvoice(invoiceNo);  
        return "redirect:/invoice/view.do";  
    }   
	
	@RequestMapping(value="/paid", method = RequestMethod.POST)
	public @ResponseBody String updatePayment(@RequestBody String invoice){
		Invoice invoiceBean = new Gson().fromJson(invoice, Invoice.class);
		String message = invoiceService.updateInvoicePaymentStatus(invoiceBean.getInvoiceNo(), invoiceBean.isPaid());
		return new Gson().toJson(message);
	}
	
	@RequestMapping(value = "/customerinvoices", method = RequestMethod.POST, consumes= "application/json")
	public @ResponseBody String getInvoicesByCustomer(@RequestBody String invoice) {
		Invoice invoiceBean = new Gson().fromJson(invoice, Invoice.class);
		List<Invoice> invoiceList = invoiceService.getUnPaidInvoicesByCustomer(invoiceBean);
		System.out.println(new Gson().toJson(invoiceList));
		return new Gson().toJson(invoiceList);
	}
	
	@RequestMapping(value="/print", method = RequestMethod.GET)  
    public String print(@RequestParam(value="invoiceNo") int invoiceNo, Model model){
		Invoice invoice = invoiceService.getInvoice(invoiceNo);
		if (null != invoice) {
			model.addAttribute("invoice", invoice);
			model.addAttribute("editFlag", true);
		}
		return "printinvoice";
	}

}
