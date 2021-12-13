<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Shrinathaji Handicrafts</title>
<link href="<%=context%>/css/custom.css" rel="stylesheet">
<link href="<%=context%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=context%>/css/jquery-ui.min.css" rel="stylesheet">
<script src="<%=context%>/js/bootstrap.min.js"></script>
<link href="<%=context%>/css/datatables.min.css" rel="stylesheet">
<script type="text/javascript" src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=context%>/js/datatables.min.js"></script>
<style type="text/css">
.right-align {
	text-align: right;
}

.center-align {
	text-align: center;
}

@page {
  size: A5;
}
.highlight {
	background-color: gray;
}

.invoiceItems:hover {
	background-color: gray;
}
#printInvoiceTable td,th {
	padding-left: 3px;
	padding-right: 3px;
}

thead.report-header {
	display: table-header-group;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
// 		var invoiceTable = $("#invoiceTable").DataTable({
// 			"columnDefs": [
// 				{
// 					"targets":1,
// 					"className": "right-align"
// 				},
// 				{
// 					"targets":2,
// 					"className": "center-align"
// 				},
// 				{
// 					"targets":3,
// 					"type":"date"
// 				}
// 			],
// 			"responsive": true,
// 			"paging":   false,
// 			"info":     false,
// 			"filter": false,
// 			"order": [[3,"asc"]]
// 		});
// 		var paymentTable = $("#paymentTable").DataTable({
// 			"columnDefs": [
// 				{
// 					"targets":1,
// 					"className": "right-align"
// 				},
// 				{
// 					"targets":2,
// 					"type":"date"
// 				}
// 			],
// 			"responsive": true,
// 			"paging":   false,
// 			"info":     false,
// 			"filter": false,
// 			"order": [[2,"asc"]]
// 		});		
// 		$("#search").click(function(){
// 			invoiceTable.clear().draw();
// 			paymentTable.clear().draw();
// 			var customer = {
// // 				customerName: $("#customer").val(),
// 				city: $("#city").val()
// 			};
// 			$.ajax({
<%-- 				url:"<%=context%>/customer/khata/details.do", --%>
// 				method:'post',
// 				dataType: 'json',
// 				contentType: 'application/json',
// 		        data: JSON.stringify(customer),
// 		        success: function(data) {
// 		        	console.log(data);
// 		        	var grandTotal = 0;
// 		        	$.each(data.invoiceList, function( index, value ) {
// 		        		var row = "<tr>"
// 		        		row += "<td>" + value.invoiceNo + "</td>";
// // 		        		row += "<td>" + value.customer + "</td>"
// // 		        		row += "<td>" + value.city + "</td>"
// 		        		row += "<td style='text-align: right;'>"+parseFloat(value.grandTotal).toFixed(2)+"</td>";
// 		        		row += "<td align='center'><input type='checkbox' id='isPaid' " + (value.isPaid?'checked':'') + " onchange='updatePaymentStatus("+ value.invoiceNo +",this.checked,event)' /></td>";
// 		        		row += "<td>" + value.invDate + "</td>";
// // 		        		row += "<td>" + value.receiptId + "</td>"
// // 		        		row += "<td>" + value.note + "</td>"
// 		        		row +="</tr>"
// // 		        		if(!value.isPaid){
// 		        			grandTotal += parseFloat(value.grandTotal);
// // 		        		}
// // 		        		$("#invoiceTable tbody").append(row);
// 		        		invoiceTable.row.add([
// 		        			value.invoiceNo,
// 		        			parseFloat(value.grandTotal).toFixed(2),
// 		        			"<input type='checkbox' id='isPaid' " + (value.isPaid?'checked':'') + " onchange='updatePaymentStatus("+ value.invoiceNo +",this.checked,event)' disabled />",
// 		        			value.invDate
// 		        		]).draw( false );
// 		        	});
		        	
// 		        	var paymentTotal=0;
// 		        	$.each(data.paymentList, function( index, value ) {
// 		        		var row = "<tr>"
// 		        		row += "<td>" + value.paymentId + "</td>";
// // 		        		row += "<td>" + value.customer + "</td>"
// // 		        		row += "<td>" + value.city + "</td>"
// 		        		row += "<td>"+parseFloat(value.amount).toFixed(2)+"</td>";
// 		        		row += "<td>" + value.payDate + "</td>";
// 		        		row += "<td>" + value.reference + "</td>"
// 		        		row +="</tr>"
// // 		        		$("#paymentTable  tbody").append(row);
// 		        		paymentTotal += parseFloat(value.amount);
		        		
// 		        		paymentTable.row.add([
// 		        			value.paymentId,
// 		        			parseFloat(value.amount).toFixed(2),
// 		        			value.payDate,
// 		        			value.reference
// 		        		]).draw( false );
		        		
// 		        	});
		        	
// 		        	var totalRow = "<tfoot><tr>";
// 		        	totalRow += "<td style='text-align: right; font-size:14pt'><strong>Total</strong></td>";
// // 		        	totalRow += "<td>&nbsp;</td>";
// // 		        	totalRow += "<td>&nbsp;</td>";
// 		        	totalRow += "<td colspan='1' id='grandTotal' style='text-align: right; font-size:14pt'><strong>"+parseFloat(grandTotal).toFixed(2)+"</strong></td>";
// 		        	totalRow += "<td>&nbsp;</td>";
// 		        	totalRow += "<td>&nbsp;</td>";
// // 		        	totalRow += "<td>&nbsp;</td>";
// // 		        	totalRow += "<td>&nbsp;</td>";
// 		        	totalRow += "</tr></tfoot>";
// 		        	$("#invoiceTable").append(totalRow);
		        	
// 		        	var paymentTotalRow = "<tfoot><tr>";
// 		        	paymentTotalRow += "<td style='text-align: right; font-size:14pt'><strong>Total</strong></td>";
// // 		        	paymentTotalRow += "<td>&nbsp;</td>";
// // 		        	paymentTotalRow += "<td>&nbsp;</td>";
// 		        	paymentTotalRow += "<td colspan='1' id='grandTotal' style='text-align: right; font-size:14pt'><strong>"+parseFloat(paymentTotal).toFixed(2)+"</strong></td>";
// 		        	paymentTotalRow += "<td>&nbsp;</td>";
// 		        	paymentTotalRow += "<td>&nbsp;</td>";
// // 		        	paymentTotalRow += "<td>&nbsp;</td>";
// // 		        	paymentTotalRow += "<td>&nbsp;</td>";
// 		        	paymentTotalRow += "</tr></tfoot>";
// 		        	$("#paymentTable").append(paymentTotalRow);
		        	
// 		        	$("#totalPendingAmount").html("Total Pending Payment: " + (parseFloat(grandTotal)-parseFloat(paymentTotal)).toFixed(2));
// 		        	$("#totalPendingDetails").show();
// 	           	}
				
// 			});
// 		});	
		
		$("#paymentEntry").click(function(){
			if($("#customer").val()==""){
				alert("Please enter Customer.");
				return;
			}
			location='<%=context%>/customer/collectpayment.do?customer=' + $("#customer").val() + '&city='+$("#city").val();
		});
		
		<%-- $("#payDate").datepicker({
			"setDate": new Date(),
			"dateFormat": "dd/mm/yy"
		}); --%>
		
		$("#city").autocomplete({
			source: "<%=context%>/customer/getcity.do",
			autoFocus: true,
			select: function(event,ui){
//	 			$("input[id^='item']").val("test");
// 				$("#customerName").html(ui.item.label + " - " + ui.item.value);
// 				$("#customerDetail").html(ui.item.label + " - " + ui.item.value)
				$("#city").val(ui.item.value);
				ui.item.value=ui.item.label;
			}
		});
		
		$("#printButton").click(function(){
				$.ajax({
					url:"<%=context%>/customer/printtour.do?city="+$('#city').val(),
					method:'get',
					dataType : "html",
			        success: function(data) {
			        	console.log(data)
						var printableHtml = data;
						 var newWin=window.open('','Print-Window');
				
						  newWin.document.open();
				
						  newWin.document.write('<html><body onload="window.print()">'+printableHtml+'</body></html>');
				
						  newWin.document.close();
			        }
				});
			
		});
		
	});
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
							<div class="title">Search by City</div>
							<form:form method="post" action="tourdetails.do" role="form">
								<div class="table-responsive">
									<table width="100%">
										<tr>
											<!-- 									<td style="padding:5px"><div class="form-group"> -->
											<!-- 							       		<label for="customer">Customer:</label> -->
											<%-- 							       		<form:input path="customer" class="form-control" /> --%>
											<!-- 						       		</div></td> -->
											<td style="padding: 5px"><div class="form-group">
													<label for="city">City:</label>
													<form:input path="city" class="form-control" />
												</div></td>
										</tr>
									</table>
								</div>
								<div class="form-group">
									<input type="submit" id="search" value="Search" class="sub-btn" />
									<input type="button" value="Print" id="printButton"
										class="sub-btn" />
									<!-- 				       		<input type="button" id="paymentEntry" value="Payment Entry" class="sub-btn" /> -->
								</div>
							</form:form>
						</div>
					</div>
					<!-- 				<div class="col-xs-12 col-sm-6"> -->
					<div class="col-xs-12">
						<div class="box" id="printDetails">
							<div class="table-responsive" >
								<table class="table table-bordered" id="titleTable">
									<c:forEach var="customerMap" items="${tourDetailsMap}">
										<tr>
											<td colspan="2" style="text-align: center;" ><span class="title"><strong>${customerMap.key.replace("~"," - ") }</strong></span></td>
										</tr>
										<tr>
											<td style="text-align: center;"><strong>Invoice Details</strong></td>
											<td style="text-align: center;"><strong>Payment Details</strong></td>
										</tr>
										<tr>
											<td width="50%" align="center"><table
													class="table table-bordered" id="invoiceTable">
													<thead>
														<tr>
															<th>No</th>
															<!-- 								<th>Customer Name</th> -->
															<!-- 								<th>City</th> -->
															<th style="text-align: right;">Amount</th>
															<!-- 												<th>Paid/Unpaid</th> -->
															<th>Invoice Date</th>
															<!-- 								<th>Receipt Number</th> -->
															<!-- 																				<th>Notes</th> -->
														</tr>
													</thead>
													<c:set var="invoiceTotal" value="${0}" />
													<tbody>
														<c:forEach var="invoice"
															items="${customerMap.value.invoiceList}">
															<c:set var="invoiceTotal"
																value="${invoiceTotal + invoice.grandTotal}" />
															<tr>
																<td>${invoice.invoiceNo }</td>
																<td style="text-align: right;"><fmt:formatNumber
																		type="number" minFractionDigits="2"
																		maxFractionDigits="2" value="${invoice.grandTotal }" /></td>
																<td>${invoice.invDate }</td>
															</tr>
														</c:forEach>
													</tbody>
													<tfoot>
														<tr>
															<td style="text-align: right;">Total</td>
															<td style="text-align: right;"><fmt:formatNumber
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" value="${invoiceTotal}" /></td>
															<td>&nbsp;</td>
														</tr>
													</tfoot>
												</table></td>
											<td><table class="table table-bordered"
													id="paymentTable">
													<thead>
														<tr>
															<th>No</th>
															<!-- 								<th>Customer Name</th> -->
															<!-- 								<th>City</th> -->
															<th style="text-align: right;">Amount</th>
															<th>Paid Date</th>
															<th>Reference</th>
														</tr>
													</thead>
													<c:set var="paymentTotal" value="${0}" />
													<tbody>
														<c:forEach var="payment"
															items="${customerMap.value.paymentList }">
															<c:set var="paymentTotal"
																value="${paymentTotal + payment.amount}" />
															<tr>
																<td>${payment.paymentId }</td>
																<td style="text-align: right;"><fmt:formatNumber
																		type="number" minFractionDigits="2"
																		maxFractionDigits="2" value="${payment.amount }" /></td>
																<td>${payment.payDate }</td>
																<td>${payment.reference }</td>
															</tr>
														</c:forEach>
													</tbody>
													<tfoot>
														<tr>
															<td style="text-align: right;">Total</td>
															<td style="text-align: right;"><fmt:formatNumber
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" value="${paymentTotal}" /></td>
															<td>&nbsp;</td>
															<td>&nbsp;</td>
														</tr>
													</tfoot>
												</table></td>
										</tr>
										<tr>
											<td colspan="2" style="text-align: center;">Total Pending:&nbsp;<strong>${invoiceTotal-paymentTotal }</strong></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>