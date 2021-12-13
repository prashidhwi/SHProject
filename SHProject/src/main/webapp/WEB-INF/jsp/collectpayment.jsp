<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.sh.beans.Payment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Shrinathaji Handicrafts</title>
<link href="<%=context %>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=context %>/css/jquery-ui.min.css" rel="stylesheet" >
<link href="<%=context%>/css/custom.css" rel="stylesheet" >
<link href="<%=context%>/css/datatables.min.css" rel="stylesheet" >
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/common.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/datatables.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("input[type='text']").focus(function () {
			   $(this).select();
			});
		$("#payDate").datepicker({
			"setDate": new Date(),
			"dateFormat": "dd/mm/yy"
		});
		var cutomerAutoComplete = $("#customer").autocomplete({
			source: "<%=context%>/customer/getcustomers.do",
			autoFocus: true,
			select: function(event,ui){
//	 			$("input[id^='item']").val("test");
				$("#customerName").html(ui.item.label.replace(" | "," - "));
				$("#city").val(ui.item.label.split(" | ")[1]);
				
				var invoice = {
						invoiceNo: 0,
						customer: ui.item.label.split(" | ")[0],
						city: ui.item.label.split(" | ")[1],
						invDate: "",
						invoiceDate: null,
						grandTotal: 0.0,
						discount: 0,
						isPaid: false,
						receiptId: "",
						note: "",
						editFlag:""
				};
				ui.item.value=ui.item.label.split(" | ")[0];
				
				$.ajax({
					url:"<%=context%>/invoice/customerinvoices.do",
					method:'post',
					dataType: 'json',
					contentType: 'application/json',
			        data: JSON.stringify(invoice),
			        success: function(data) {
			        	$("#invoiceTable tbody tr").remove();
			        	var grandTotal = 0;
			        	$.each(data, function( index, value ) {
			        		var row = "<tr>"
			        		row += "<td>" + value.invoiceNo + "</td>";
			        		row += "<td>" + value.customer + "</td>"
			        		row += "<td>" + value.city + "</td>"
			        		row += "<td style='text-align: right;'>"+parseFloat(value.grandTotal).toFixed(2)+"</td>";
			        		row += "<td align='center'><input type='checkbox' id='isPaid' " + (value.paid?'checked':'') + " onchange='updatePaymentStatus("+ value.invoiceNo +",this.checked,event)' /></td>";
			        		row += "<td>" + value.invDate + "</td>";
			        		row += "<td>" + value.receiptId + "</td>"
			        		row += "<td>" + value.note + "</td>"
			        		row +="</tr>"
			        		grandTotal += parseFloat(value.grandTotal);
			        		$("#invoiceTable tbody").append(row);
			        	});
			        	
			        	var totalRow = "<tr>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td id='grandTotal' style='text-align: right;'><strong>"+parseFloat(grandTotal).toFixed(2)+"</strong></td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "</tr>";
			        	$("#invoiceTable tbody").append(totalRow);
			        	invoiceTable.draw();
		           	}
					
				});
				$("#amount").focus();
			}
		});
		cutomerAutoComplete.autocomplete('option','select').call();
	});
	function updatePaymentStatus(invoiceNo,isPaid,event){
		event.preventDefault();
		var invoice = {
				invoiceNo: 0,
				customer: "",
				city: "",
				invDate: "",
				invoiceDate: null,
				grandTotal: 0.0,
				discount: 0,
				isPaid: false,
				receiptId: "",
				note: "",
				editFlag:"",
		};
		invoice.invoiceNo = invoiceNo;
		invoice.isPaid = isPaid;
		
		$.ajax({
			url:"<%=context%>/invoice/paid.do",
			method:'post',
			dataType: 'json',
			contentType: 'application/json',
	        data: JSON.stringify(invoice),
	        success: function(data) {
	        	alert(data);
	            if(data=="nvoice is marked as "+(isPaid?'Paid':'Unpaid')){
					if(isPaid){
		            	$("#isPaid").addAttr("checked");
					} else {
						$("#isPaid").removeAttr("checked");
					}	            	
	            }
           	}
			
		});
		
	}
</script>
</head>
<body>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart">
			<div class="chartouter">
				<div class="col-xs-12">
					<div class="box">
						<div class="title">Pending Invoices of <span id="customerName"><c:out value="${command.customer}"></c:out> </span></div>
						<div class="table-responsive">
						<table class="table table-bordered" id="invoiceTable">
							<thead>
							<tr>
								<th>Invoice Number</th>
								<th>Customer Name</th>
								<th>City</th>
								<th style="text-align: right;">Total</th>
								<th>Paid/Unpaid</th>
								<th>Invoice Date</th>
								<th>Receipt Number</th>
								<th>Notes</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="invoice" items="${invoiceList}">
								<tr>
									<td>${invoice.invoiceNo}</td>
									<td>${invoice.customer}</td>
									<td>${invoice.city}</td>
									<td>${invoice.grandTotal}</td>
									<td align="center"><input type="checkbox" id="isPaid" ${invoice.paid?'checked':''} onchange="updatePaymentStatus(${invoice.invoiceNo },this.checked,event)" /></td>
									<td>${invoice.invDate}</td>
									<td>${invoice.receiptId}</td>
									<td>${invoice.note}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</div>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="box">
						<div class="title">Collect Payment</div>
						
				       <form:form id="paymentFrom" method="post" action="payment/save.do" role="form" onsubmit="return validateForm(this.id);">  
				       		<form:hidden path="paymentId"/>
				       		<div class="form-group">
				       		<label for="customer">Customer:</label>
				       		<form:input path="customer" class="form-control" validations="notNull:true" autofocus="autofocus"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="city">City:</label>
				       		<form:input path="city" class="form-control" validations="notNull:true"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="amount">Amount:</label>
				       		<form:input path="amount" class="form-control" validations="notNull:true,dataType:INT"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="payDate">Payment Date:</label>
				       		<form:input path="payDate" id="payDate" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="reference">Reference:</label>
				       		<form:input path="reference" class="form-control" />
				       		</div> 
				       		<div class="form-group">
				       			<input type="submit" value="Save" class="sub-btn" />
				       		</div>
				       </form:form> 
				       
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
</body>
</html>