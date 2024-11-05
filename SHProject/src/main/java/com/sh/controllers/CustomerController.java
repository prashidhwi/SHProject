package com.sh.controllers;

import com.google.gson.Gson;
import com.sh.beans.AutoComplete;
import com.sh.beans.Customer;
import com.sh.beans.Invoice;
import com.sh.beans.Payment;
import com.sh.dao.CustomerDao;
import com.sh.dao.InvoiceDao;
import com.sh.service.CustomerService;
import com.sh.service.InvoiceService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({ "/customer" })
public class CustomerController {
	@Autowired
	CustomerDao customerDao;

	@Autowired
	InvoiceDao invoiceDao;

	@Autowired
	InvoiceService invoiceService;

	@Autowired
	CustomerService customerService;

	@Autowired
	ServletContext context;

	/*
	 * It displays a form to input data, here "command" is a reserved request
	 * attribute which is used to display object data into form
	 */
	@RequestMapping("/form")
	public String showform(Model m) {
		m.addAttribute("command", new Customer());
		return "customerform";
	}

	/*
	 * It saves object into database. The @ModelAttribute puts request data into
	 * model object. You need to mention RequestMethod.POST method because default
	 * request is GET
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute("customer") Customer customer) {
		customerService.save(customer);
		return "redirect:/customer/view.do";// will redirect to viewcustomer
											// request mapping
	}

	/* It provides list of customerloyees in model object */
	@RequestMapping("/view")
	public String viewCustomer(Model m) {
		List<Customer> list = customerDao.getCustomer();
		m.addAttribute("list", list);
		return "viewcustomer";
	}

	/*
	 * It displays object data into form for the given id. The @PathVariable puts
	 * URL data into variable.
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(@RequestParam(value = "customerId") int id, Model model) {
		Customer customer = customerDao.getCustomerById(id);
		model.addAttribute("command", customer);
		return "customerform";
	}

	/*
	 * It deletes record for the given id in URL and redirects to /viewcustomer
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam(value = "customerId") int id, Model model) {
		customerDao.delete(id);
		return "redirect:/customer/view.do";
	}

	@RequestMapping(value = "/getcustomers", method = RequestMethod.GET)
	public @ResponseBody String getCustomers(@RequestParam("term") String customerName) {
		List<Customer> list = customerDao.getMatchingCustomer(customerName);
		List<AutoComplete> customers = new ArrayList<AutoComplete>();
		for (Customer customer : list) {
			AutoComplete autoComplete = new AutoComplete();
			autoComplete.setLabel(customer.getCustomerName() + " | " + customer.getCity());
			autoComplete.setValue(customer.getCustomerName());
			customers.add(autoComplete);
		}
		return (new Gson()).toJson(customers);
	}

	@RequestMapping(value = "/getcity", method = RequestMethod.GET)
	public @ResponseBody String getCity(@RequestParam("term") String city) {
		List<Customer> list = customerDao.getMatchingCity(city);
		list = list.stream().filter(distinctByKey(Customer::getCity)).collect(Collectors.toList());
		List<AutoComplete> customers = new ArrayList<AutoComplete>();
		for (Customer customer : list) {
			AutoComplete autoComplete = new AutoComplete();
			autoComplete.setLabel(customer.getCity());
			autoComplete.setValue(customer.getCity());
			customers.add(autoComplete);
		}
		return (new Gson()).toJson(customers);
	}

	@RequestMapping(value = "/collectpayment", method = RequestMethod.GET)
	public String gotoCollectPayment(Model model, @RequestParam(value = "customer", required = false) String customer,
			@RequestParam(value = "city", required = false) String city) {
		Payment payment = new Payment();
		payment.setCustomer(customer);
		payment.setCity(city);
		Invoice invoiceBean = new Invoice();
		invoiceBean.setCustomer(customer);
		invoiceBean.setCity(city);
		List<Invoice> invoiceList = invoiceService.getUnPaidInvoicesByCustomer(invoiceBean);
		model.addAttribute("command", payment);
		model.addAttribute("invoiceList", invoiceList);
		return "collectpayment";
	}

	@RequestMapping(value = "/payment/save", method = RequestMethod.POST)
	public String savePayment(@ModelAttribute("payment") Payment payment) {
		this.customerDao.saveCustomerPayment(payment);
		return "redirect:/customer/khatabook.do?customer=" + payment.getCustomer() + "&city=" + payment.getCity();
	}

	@RequestMapping(value = { "/khatabook" }, method = { RequestMethod.GET })
	public String getKhataBook(Model model, @RequestParam(value = "customer", required = false) String customer,
			@RequestParam(value = "city", required = false) String city) {
		Payment payment = new Payment();
		payment.setCustomer(customer);
		payment.setCity(city);
		model.addAttribute("command", payment);
		return "khatabook";
	}

	@RequestMapping(value = { "/tour" }, method = { RequestMethod.GET })
	public String getTour(Model model) {
		model.addAttribute("command", new Customer());
		return "tour";
	}

	@RequestMapping(value = "/khata/details", method = RequestMethod.POST)
	public @ResponseBody String getCustomerInvoiceAndPayment(@RequestBody String customer) {
		Customer customerBean = new Gson().fromJson(customer, Customer.class);
		List<Invoice> invoiceList = invoiceService.getAllInvoicesByCustomer(customerBean.getCustomerName(),
				customerBean.getCity());
		List<Payment> paymentList = customerService.getCustomerPaymentDetails(customerBean.getCustomerName(),
				customerBean.getCity());

		Map<String, Object> kharabookMap = new HashMap<String, Object>();
		kharabookMap.put("invoiceList", invoiceList);
		kharabookMap.put("paymentList", paymentList);

		return new Gson().toJson(kharabookMap);
	}

	@RequestMapping(value = "/pendingPayment", method = RequestMethod.POST)
	public @ResponseBody String getPendingPayment(@RequestBody String customer) {
		Customer customerBean = new Gson().fromJson(customer, Customer.class);
		Invoice invoice = new Invoice();
		invoice.setCustomer(customerBean.getCustomerName());
		invoice.setCity(customerBean.getCity());
		List<Invoice> invoiceList = invoiceService.getUnPaidInvoicesByCustomer(invoice);
		List<Payment> paymentList = customerService.getUnVerifiedPaymentDetails(customerBean.getCustomerName(),
				customerBean.getCity());

		Map<String, Object> kharabookMap = new HashMap<String, Object>();
		kharabookMap.put("invoiceList", invoiceList);
		kharabookMap.put("paymentList", paymentList);

		return new Gson().toJson(kharabookMap);
	}

	@RequestMapping(value = "/printaccount", method = RequestMethod.GET)
	public String printAccount(Model model, @RequestParam(value = "customer", required = false) String customer,
			@RequestParam(value = "city", required = false) String city) {
		Invoice invoice = new Invoice();
		invoice.setCustomer(customer);
		invoice.setCity(city);
		List<Invoice> invoiceList = invoiceService.getUnPaidInvoicesByCustomer(invoice);
		List<Payment> paymentList = customerService.getUnVerifiedPaymentDetails(customer, city);

		model.addAttribute("invoiceList", invoiceList);
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("customer", customer);
		model.addAttribute("city", city);
		return "printaccount";
	}

	@RequestMapping(value = "/tourdetails", method = RequestMethod.POST)
	public String getTourInvoiceAndPayment(Model model, @ModelAttribute("customer") Customer customerBean) {
		Map<String, Object> tourDetailsMap = getTourDetails(customerBean);
		model.addAttribute("tourDetailsMap", tourDetailsMap);
		model.addAttribute("command", customerBean);
		return "tour";
	}

	@RequestMapping(value = "/printtour", method = RequestMethod.GET)
	public String printTour(Model model, @RequestParam(value = "city", required = false) String city) {
		Customer customerBean = new Customer();
		customerBean.setCity(city);
		Map<String, Object> tourDetailsMap = getTourDetails(customerBean);
		model.addAttribute("tourDetailsMap", tourDetailsMap);
		model.addAttribute("command", customerBean);
		return "printtour";
	}

	private Map<String, Object> getTourDetails(Customer customerBean) {
//		Customer customerBean = new Gson().fromJson(customer, Customer.class);
		List<Customer> customerList = customerService.getCustomerByCity(customerBean.getCity());
		List<Invoice> invoiceList = invoiceService.getAllInvoicesByCity(customerBean.getCity());
		List<Payment> paymentList = customerService.getPaymentDetailsByCity(customerBean.getCity());

		Map<String, Object> tourDetailsMap = new HashMap<String, Object>();
		for (Customer customer : customerList) {
			List<Invoice> filteredInvoiceList = invoiceList.stream()
					.filter(invoice -> invoice.getCustomer().equals(customer.getCustomerName())
							&& invoice.getCity().equals(customer.getCity()))
					.collect(Collectors.toList());
			List<Payment> filteredPaymentList = paymentList.stream()
					.filter(payment -> payment.getCustomer().equals(customer.getCustomerName())
							&& payment.getCity().equals(customer.getCity()))
					.collect(Collectors.toList());
			Map<String, Object> customerMap = new HashMap<String, Object>();
			customerMap.put("invoiceList", filteredInvoiceList);
			customerMap.put("paymentList", filteredPaymentList);
			tourDetailsMap.put(customer.getCustomerName() + "~" + customer.getCity(), customerMap);
		}

		return tourDetailsMap;
	}

	public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
		Set<Object> seen = ConcurrentHashMap.newKeySet();
		return t -> seen.add(keyExtractor.apply(t));
	}

	@RequestMapping(value = "/payment/verify", method = RequestMethod.POST)
	public @ResponseBody String updatePayment(@RequestBody String paymentJson) {
		Payment payment = new Gson().fromJson(paymentJson, Payment.class);
		String message = customerService.verifyPayment(payment.getPaymentId(), payment.isVerified());
		return new Gson().toJson(message);
	}

	@RequestMapping(value = { "/payment/delete" }, method = { RequestMethod.GET })
	public String deletePayment(@RequestParam("paymentId") int paymentId, Model model) {
		Payment payment = customerService.getPaymentByPaymentId(paymentId);
		if (this.customerService.deletePayment(paymentId) > 0) {
			return "redirect:/customer/khatabook.do?customer=" + payment.getCustomer() + "&city=" + payment.getCity();
		}
		return "redirect:/customer/khatabook.do";
	}
}
