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
<link href="<%=context%>/css/datatables.min.css" rel="stylesheet" >
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/datatables.min.js"></script>
<style type="text/css">
	.right-align{ text-align:right;}
	.center-align{ text-align:center;}
</style>
<script type="text/javascript">
jQuery.extend( jQuery.fn.dataTableExt.oSort, {
	"date-uk-pre": function ( a ) {
	    var ukDatea = a.split('/');
	    return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
	},

	"date-uk-asc": function ( a, b ) {
	    return ((a < b) ? -1 : ((a > b) ? 1 : 0));
	},

	"date-uk-desc": function ( a, b ) {
	    return ((a < b) ? 1 : ((a > b) ? -1 : 0));
	}
	} );
function verifyPayment(paymentId){
	var payment = {
			paymentId: paymentId,
			isVerified: $("#verified"+paymentId).prop("checked")
	};
	$.ajax({
		url:"<%=context%>/customer/payment/verify.do",
		method:'post',
		dataType: 'json',
		contentType: 'application/json',
        data: JSON.stringify(payment),
        success: function(data) {
        	alert(data);
            if(data!="Payment Verified."){
            	$("#verified"+paymentId).attr("checked",false);
            }
       	}
		
	});
}

function updatePaymentStatus(invoiceNo,isPaid,event){
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
       	}
		
	});
}
	$(document).ready(function(){
		var invoiceTable = $("#invoiceTable").DataTable({
			"columnDefs": [
				{
					"targets":0,
					"width":"15%"
				},
				{
					"targets":1,
					"className": "right-align"
				},
				{
					"targets":2,
					"className": "center-align",
					"width":"20%"
				},
				{
					"targets":3,
					"type":"date-uk"
				}
			],
			"responsive": true,
			"paging":   false,
			"info":     false,
			"filter": false,
			"order": [[3,"asc"]]
		});
		var paymentTable = $("#paymentTable").DataTable({
			"columnDefs": [
				{
					"targets":0,
					"width":"10%"
				},
				{
					"targets":1,
					"className": "right-align",
					"width" : "20%"
				},
				{
					"targets":2,
					"type":"date-uk"
				},
				{
					"targets":3,
					"className": "center-align",
					"width":"5%"
				},
				{
					"targets":4,
					"width":"40%"
				},
				{
					"targets":5,
					"orderable":false
				}
			],
			"responsive": true,
			"paging":   false,
			"info":     false,
			"filter": false,
			"order": [[2,"asc"]]
		});		
		$("#search, #pendingPayment").click(function(){
			document.getElementById("invoiceTable").deleteTFoot();
			document.getElementById("paymentTable").deleteTFoot();
			invoiceTable.clear().draw();
			paymentTable.clear().draw();
			var customer = {
				customerName: $("#customer").val(),
				city: $("#city").val()
			};
			var url = "<%=context%>/customer/khata/details.do";
			var element = this;
			if($(this).attr("id")=="pendingPayment"){
				url = "<%=context%>/customer/pendingPayment.do";
			}
			$.ajax({
				url:url,
				method:'post',
				dataType: 'json',
				contentType: 'application/json',
		        data: JSON.stringify(customer),
		        success: function(data) {
		        	console.log(data);
		        	var grandTotal = 0;
		        	var tempGrandTotal = 0;
		        	$.each(data.invoiceList, function( index, value ) {
		        		var row = "<tr>"
		        		row += "<td>" + value.invoiceNo + "</td>";
// 		        		row += "<td>" + value.customer + "</td>"
// 		        		row += "<td>" + value.city + "</td>"
		        		row += "<td style='text-align: right;'>"+parseFloat(value.grandTotal).toFixed(2)+"</td>";
		        		row += "<td align='center' data-sort='" + value.invoiceDate + "'><input type='checkbox' id='isPaid' " + (value.isPaid?'checked':'') + " onchange='updatePaymentStatus("+ value.invoiceNo +",this.checked,event)' disabled/></td>";
		        		row += "<td data-sort='"+value.invoiceDate+"'>" + value.invDate + "</td>";
// 		        		row += "<td>" + value.receiptId + "</td>"
// 		        		row += "<td>" + value.note + "</td>"
		        		row +="</tr>"
// 		        		if(!value.isPaid){
							grandTotal += parseFloat(value.grandTotal);
		        			tempGrandTotal += value.isPaid?0:parseFloat(value.grandTotal);
// 		        		}
// 		        		$("#invoiceTable tbody").append(row);
		        		invoiceTable.row.add([
		        			value.invoiceNo,
		        			parseFloat(value.grandTotal).toFixed(2),
		        			"<input type='checkbox' id='isPaid' " + (value.isPaid?'checked':'') + " onchange='updatePaymentStatus("+ value.invoiceNo +",this.checked,event)' " + (value.isPaid?'disabled':'') + " />",
		        			value.invDate
		        		]).draw();
		        	});
		        	
//        				$.each(data.invoiceList, function( index, value ) {
//        					$("#invoiceTable tbody").find("tr").each(function(){
//        						console.log($(this).find("td:eq(0)").html());
//        						console.log($(this).find("td:eq(3)").html());
//        						if(parseInt($(this).find("td:eq(0)").html())==value.invoiceNo){
//        							$(this).find("td:eq(3)").attr('data-sort',value.invoiceDate);
//        						}
//        					});
//        				});
       				
//        				invoiceTable.order([3,"asc"]).draw();
		        	
		        	var paymentTotal=0;
		        	var tempPaymentTotal=0;
		        	$.each(data.paymentList, function( index, value ) {
		        		var row = "<tr>"
		        		row += "<td>" + value.paymentId + "</td>";
// 		        		row += "<td>" + value.customer + "</td>"
// 		        		row += "<td>" + value.city + "</td>"
		        		row += "<td>"+parseFloat(value.amount).toFixed(2)+"</td>";
		        		row += "<td data-sort='" + value.paymentDate + "'>" + value.payDate + "</td>";
		        		row += "<td>" + value.reference + "</td>"
		        		row += "<td><img alt='Delete' src='<%=context%>/images/icn_remove.png' width='24px' /></td>"
		        		row +="</tr>"
// 		        		$("#paymentTable  tbody").append(row);
		        		paymentTotal += parseFloat(value.amount);
		        		tempPaymentTotal += value.isVerified?0:parseFloat(value.amount);
		        		
		        		paymentTable.row.add([
		        			value.paymentId,
		        			parseFloat(value.amount).toFixed(2),
		        			value.payDate,
		        			"<input type='checkbox' id='verified"+value.paymentId+"' "+(value.isVerified?'checked':'')+" onclick='verifyPayment("+value.paymentId+")' />",
		        			value.reference,
		        			(!value.isVerified?'<a href="#" onclick="deletePayment('+value.paymentId+')"><img alt="Delete" src="<%=context%>/images/icn_remove.png" width="24px" /></a>':'&nbsp;')
		        		]).draw( false );
		        		
		        	});
		        	
		        	
		        	
		        	var totalRow = "<tfoot><tr>";
		        	totalRow += "<td style='text-align: right; font-size:14pt'><strong>Total</strong></td>";
// 		        	totalRow += "<td>&nbsp;</td>";
		        	totalRow += "<td colspan='1' id='grandTotal' style='text-align: right; font-size:14pt'><strong>"+parseFloat(grandTotal).toFixed(2)+"</strong></td>";
		        	totalRow += "<td>&nbsp;</td>";
		        	totalRow += "<td>&nbsp;</td>";
		        	totalRow += "</tr></tfoot>";
		        	$("#invoiceTable").append(totalRow);
		        	
		        	var paymentTotalRow = "<tfoot><tr>";
		        	paymentTotalRow += "<td style='text-align: right; font-size:14pt'><strong>Total</strong></td>";
// 		        	paymentTotalRow += "<td>&nbsp;</td>";
		        	paymentTotalRow += "<td colspan='1' id='grandTotal' style='text-align: right; font-size:14pt'><strong>"+parseFloat(paymentTotal).toFixed(2)+"</strong></td>";
		        	paymentTotalRow += "<td>&nbsp;</td>";
		        	paymentTotalRow += "<td>&nbsp;</td>";
		        	paymentTotalRow += "<td>&nbsp;</td>";
		        	paymentTotalRow += "</tr></tfoot>";
		        	$("#paymentTable").append(paymentTotalRow);
		        	
		        	$("#totalPendingAmount").html("Total Pending Payment: " + (parseFloat(tempGrandTotal)-parseFloat(tempPaymentTotal)).toFixed(2) + "<span style='float: right;'><input type='button' id='print' value='Print' class='sml-btn' onclick='printAccount();' /></span>");
		        	$("#totalPendingDetails").show();
		        	if($(element).attr("id")=="pendingPayment"){
		        		$("#print").show();
		        	} else {
		        		$("#print").hide();
		        	}
	           	}
				
			});
		});	
		
		
		
		$("#paymentEntry").click(function(){
			if($("#customer").val()==""){
				alert("Please enter Customer.");
				return;
			}
			location=encodeURI('<%=context%>/customer/collectpayment.do?customer=' + $("#customer").val() + '&city='+$("#city").val());
		});
		
		<%-- $("#payDate").datepicker({
			"setDate": new Date(),
			"dateFormat": "dd/mm/yy"
		}); --%>
		
		$("#customer").autocomplete({
			source: "<%=context%>/customer/getcustomers.do",
			autoFocus: true,
			select: function(event,ui){
//	 			$("input[id^='item']").val("test");
// 				$("#customerName").html(ui.item.label + " - " + ui.item.value);
				$("#customerDetail").html(ui.item.label.replace(" | "," - "));
				$("#city").val(ui.item.label.split(" | ")[1]);
				ui.item.value=ui.item.label.split(" | ")[0];
			}
		});
		
		if($("#customer").val()!=""){
			$("#search").trigger("click");
		}
	});
	function printAccount(){
		$.ajax({
			url:"<%=context%>/customer/printaccount.do?customer=" + encodeURIComponent($('#customer').val())+"&city="+$('#city').val(),
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
	}
	function deletePayment(paymentId){
		if(confirm("Payment will be Deleted. Are you sure?")){
			location=encodeURI('<%=context%>/customer/payment/delete.do?paymentId=' + paymentId);
		}
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
						<div class="title">Search by Customer</div>
						<form:form method="post" action="payment/save.do" role="form">  
						<div class="table-responsive">
							<table width="100%">
								<tr>
									<td style="padding:5px"><div class="form-group">
							       		<label for="customer">Customer:</label>
							       		<form:input path="customer" class="form-control" autofocus="autofocus"/>
						       		</div></td>
									<td style="padding:5px"><div class="form-group">
							       		<label for="city">City:</label>
							       		<form:input path="city" class="form-control" />
						       		</div></td>
								</tr>
							</table>
						</div>
			       		<div class="form-group">
				       		<input type="button" id="search" value="Search" class="sub-btn" />
				       		<input type="button" id="pendingPayment" value="Pending Payment" class="sub-btn" />
				       		<input type="button" id="paymentEntry" value="Payment Entry" class="sub-btn" />
			       		</div>
			       		</form:form>
					</div>
				</div>
<!-- 				<div class="col-xs-12 col-sm-6"> -->
				<div class="col-xs-12">
						<div class="box" id="accountDetails">
							<div class="title" id="customerDetail"></div>
							<div id="totalPendingDetails" class="box" style="width: 99%; display: none;">
								<div id="totalPendingAmount" style="text-align: center; font-size: 14pt; font-weight: bold;"></div>
								
							</div>
							<div class="box" style="width: 35%">
								<div class="title">Invoice Details</div>
								<div class="table-responsive">
									<table class="table table-bordered" id="invoiceTable">
										<thead>
											<tr>
												<th>Invoice No</th>
												<!-- 								<th>Customer Name</th> -->
												<!-- 								<th>City</th> -->
												<th style="text-align: right;">Total</th>
												<th>Paid/Unpaid</th>
												<th>Invoice Date</th>
												<!-- 								<th>Receipt Number</th> -->
												<!-- 								<th>Notes</th> -->
											</tr>
										</thead>
										<tbody></tbody>
									</table>
								</div>
							</div>
							<!-- 				</div> -->
							<!-- 				<div class="col-xs-12 col-sm-6"> -->
							<div class="box" style="width: 64%; margin-left: 10px;">
								<div class="title">Payment Details</div>
								<div class="table-responsive">
									<table class="table table-bordered" id="paymentTable">
										<thead>
											<tr>
												<th>Id</th>
												<!-- 								<th>Customer Name</th> -->
												<!-- 								<th>City</th> -->
												<th style="text-align: right;">Amount Paid</th>
												<th>Paid Date</th>
												<th>Verified</th>
												<th>Reference</th>
												<th><img alt='Delete' src='<%=context%>/images/icn_remove.png' width='24px' /></th>
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
	</div>
</div>
</body>
</html>