package com.sh.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sh.beans.AutoComplete;
import com.sh.beans.Customer;
import com.sh.beans.Invoice;
import com.sh.beans.Supplier;
import com.sh.beans.SupplierPayment;
import com.sh.service.SupplierService;

@Controller
@RequestMapping("/supplier")
public class SupplierController {
	
	@Autowired
	private SupplierService supplierService;
	
	@RequestMapping("/form")
	public String showform(Model m) {
		m.addAttribute("command", new Supplier());
		return "supplierform";
	}
	
	@RequestMapping(value="/save", method = RequestMethod.POST )
	public ModelAndView save(@ModelAttribute("supplier") Supplier supplier){
		ModelAndView modelAndView = new ModelAndView();
		String message = supplierService.save(supplier);
		modelAndView.addObject("message", message);
		modelAndView.setViewName("dashboard");
		return modelAndView;
	}
	
	@RequestMapping(value = "/getsuppliers", method = RequestMethod.GET)
	public @ResponseBody String getCustomers(@RequestParam("term") String supplierName) {
		List<Supplier> list = supplierService.getMatchingSupplier(supplierName);
		List<AutoComplete> customers = new ArrayList<AutoComplete>();
		if(list != null){
			for (Supplier supplier : list) {
				AutoComplete autoComplete = new AutoComplete();
				autoComplete.setLabel(supplier.getSupplierName() + " | " + supplier.getSupplierCity());
				autoComplete.setValue(supplier.getSupplierName());
				customers.add(autoComplete);
			}
		}
		// m.addAttribute("list",list);
		return new Gson().toJson(customers);
	}
	
	@RequestMapping("/payment")
	public String showPaymentDetail(Model m) {
		m.addAttribute("command", new SupplierPayment());
		return "supplierpayment";
	}
	
	@RequestMapping(value="/savepayment", method = RequestMethod.POST )
	public ModelAndView savePayment(@ModelAttribute("supplierPayment") SupplierPayment supplierPayment){
		ModelAndView modelAndView = new ModelAndView();
		String message = supplierService.savePayment(supplierPayment);
		modelAndView.addObject("message", message);
		modelAndView.setViewName("dashboard");
		return modelAndView;
	}
	
	@RequestMapping(value = "/getbills", method = RequestMethod.POST, consumes= "application/json")
	public @ResponseBody String getBillsBySupplier(@RequestBody String supplier) {
		Supplier supplierBean = new Gson().fromJson(supplier, Supplier.class);
		List<Supplier> supplierList = supplierService.getBillsBySupplier(supplierBean);
		List<SupplierPayment> supplierPaymentList = supplierService.getSupplierPaymentList(supplierBean);
		Map<String, Object> supplierMap = new HashMap<String, Object>();
		supplierMap.put("supplierList", supplierList);
		supplierMap.put("supplierPaymentList", supplierPaymentList);
		
		return new Gson().toJson(supplierMap);
	}
}
