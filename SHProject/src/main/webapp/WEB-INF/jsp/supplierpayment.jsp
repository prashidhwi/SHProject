<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#paymentDate").datepicker({
			"setDate": new Date(),
			"dateFormat": "dd/mm/yy"
		});
		
		$("#supplierName").autocomplete({
			source: "<%=context%>/supplier/getsuppliers.do",
			autoFocus: true,
			select: function(event,ui){
//	 			$("input[id^='item']").val("test");
				$("#supplier").html(ui.item.label + " - " + ui.item.value);
				$("#supplierCity").val(ui.item.value);
				var supplier = {
						supplierId: 0,
						supplierName: ui.item.label,
						supplierCity: ui.item.value,
						billDate: "",
				};
				ui.item.value=ui.item.label;
				$("#supplierTable").find("tr:gt(0)").remove();
				$.ajax({
					url:"<%=context%>/supplier/getbills.do",
					method:'post',
					dataType: 'json',
					contentType: 'application/json',
			        data: JSON.stringify(supplier),
			        success: function(data) {
			        	var grandTotal = 0;
			        	$.each(data.supplierList, function( index, value ) {
			        		var row = "<tr>"
			        		row += "<td>" + value.billId + "</td>";
			        		row += "<td style='text-align: right;'>"+parseFloat(value.amount).toFixed(2)+"</td>";
			        		console.log("Payment Status: "+value.isPaid);
			        		row += "<td align='center'><input type='checkbox' id='status' " + (value.isPaid?'checked':'') + " onchange='updatePaymentStatus("+ value.billId +",this.checked,event)' /></td>";
			        		row += "<td>" + value.billDate + "</td>";
			        		row +="</tr>"
			        		grandTotal += parseFloat(value.amount);
			        		$("#supplierTable").append(row);
			        	});
			        	
			        	var totalRow = "<tr>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td id='grandTotal' style='text-align: right;'><strong>"+parseFloat(grandTotal).toFixed(2)+"</strong></td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "<td>&nbsp;</td>";
			        	totalRow += "</tr>";
			        	$("#supplierTable").append(totalRow);
			        	
			        	$.each(data.supplierPaymentList, function( index, value ) {
			        		var row = "<tr>"
			        		row += "<td>" + value.supplierPaymentId + "</td>";
			        		row += "<td style='text-align: right;'>"+parseFloat(value.amount).toFixed(2)+"</td>";
// 			        		row += "<td align='center'><input type='checkbox' id='status' " + (value.paid?'checked':'') + " onchange='updatePaymentStatus("+ value.billId +",this.checked,event)' /></td>";
			        		row += "<td>" + value.paymentDate + "</td>";
			        		row += "<td>" + value.note + "</td>";
			        		row +="</tr>"
// 			        		grandTotal += parseFloat(value.amount);
			        		$("#paymentTable").append(row);
			        	});
		           	}
					
				});
				$("#amount").focus();
			}
		});
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
						<div class="title">Pending Invoices of <span id="supplier"></span></div>
						<div class="table-responsive">
						<table class="table table-bordered" id="supplierTable">
							<tr>
								<th>Bill Number</th>
								<th style="text-align: right;">Amount</th>
								<th style="text-align: center;">Paid/Unpaid</th>
								<th>Bill Date</th>
							</tr>
						</table>
						</div>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="box">
						<div class="title">Supplier Payment</div>
						
				       <form:form id="supplierPaymentForm" method="post" action="savepayment.do" role="form" onsubmit="return validateForm(this.id);">  
				       		<form:hidden path="supplierPaymentId"/>
				       		<div class="form-group">
				       		<label for="supplierName">Supplier Name:</label>
				       		<form:input path="supplierName" class="form-control" validations="notNull:true" autofocus="autofocus"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="supplierCity">City:</label>
				       		<form:input path="supplierCity" class="form-control" validations="notNull:true"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="amount">Amount:</label>
				       		<form:input path="amount" class="form-control" validations="notNull:true,dataType:INT"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="paymentDate">Payment Date:</label>
				       		<form:input path="paymentDate" id="paymentDate" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="note">Note:</label>
				       		<form:textarea path="note" id="note" class="form-control" />
				       		</div>
				       		<div class="form-group">
				       			<input type="submit" value="Save" class="sub-btn" />
				       		</div>
				       </form:form> 
				       
					</div>
				</div>
				<div class="box"  style="width: 49%; margin-left: 10px;">
						<div class="title">Payment Details</div>
						<div class="table-responsive">
						<table class="table table-bordered" id="paymentTable">
							<thead>
							<tr>
								<th>Payment Id</th>
<!-- 								<th>Customer Name</th> -->
<!-- 								<th>City</th> -->
								<th style="text-align: right;">Amount Paid</th>
								<th>Paid Date</th>
								<th>Note</th>
							</tr>
							</thead>
							<tbody></tbody>
						</table>
						</div>
					</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>