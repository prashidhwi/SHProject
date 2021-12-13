<%@page import="com.sh.beans.Invoice"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link href="<%=context%>/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=context%>/css/jquery-ui.min.css" rel="stylesheet" >
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
$(document).ready(function(){
	var invoiceTable = $("#invoiceTable").DataTable({
		
		'columnDefs' : [
			{
				"targets": 3,
				"className": "right-align"
			},
			{
				"targets": 4,
				"className": "center-align"
			},
			{
				"targets": 5,
				"type": "date"
			},
			{
				"targets": 9,
				"className": "center-align"
			},
			{
				"targets": 10,
				"className": "center-align"
			}
		],
		"order": [[ 5, "desc" ]]
	});
	
// 	invoiceTable.column(5).data().each(function(value, index){
// 		var dateArray = value.split("/");
// 		value = new Date(dateArray[2],dateArray[1],dateArray[0]);
		
// 		$("#invoiceTable tr").each(function(){
// 			$(this).find('td').each(function(index){
// 				if(index==5){
// // // 					console.log(value);
// 					$(this).html(value);
// 					console.log($(this).html());
// 				}
// 			});
// 		});
// 	});

	$('div.dataTables_filter input').focus();
	window.scrollTo(0, 0);
	
});
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
	            if(data!="Invoice is marked as "+(isPaid?'Paid':'Unpaid')){
	            	location.reload();
	            }
           	}
			
		});
	}

function viewNotes(id){
	if($('#'+id).html()!=""){
		alert($('#'+id).html());
	} else {
		alert("No Notes");
	}
}

function printInvoice(invoiceNo){
	$.ajax({
		url:"<%=context%>/invoice/print.do?invoiceNo=" + invoiceNo,
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

function deleteInvoice(invoiceNo){
	
	if(confirm("Invoice will be Deleted. Are you sure?")){
		window.location='<%=context%>/invoice/delete.do?invoiceNo=' + invoiceNo;
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
						<div class="title">Credit Invoice</div>
						<div class="table-responsive">
						<table class="table table-bordered" id="invoiceTable">
							<thead>
							<tr>
								<th>Invoice Number</th>
								<th>Customer Name</th>
								<th>City</th>
								<th align="right">Total</th>
								<th align="center">Paid/Unpaid</th>
								<th>Invoice Date</th>
								<th>Receipt Number</th>
								<th>Check Notes</th>
								<th>Print</th>
								<th>Edit</th>
								<th>Delete</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="invoice" items="${invoiceList}">
								<tr>
									<td>${invoice.invoiceNo}</td>
									<td>${invoice.customer}</td>
									<td>${invoice.city}</td>
									<td align="right"><fmt:formatNumber minFractionDigits="2" value="${invoice.grandTotal}"/></td>
									<td align="center"><input type="checkbox" id="isPaid" ${invoice.paid?'checked':''} onchange="updatePaymentStatus(${invoice.invoiceNo },this.checked,event)" /></td>
									<td data-sort="${invoice.invoiceDate}"><fmt:formatDate value="${invoice.invoiceDate}" pattern="dd/MM/yyyy"/></td>
									<td>${invoice.receiptId}</td>
									<td><button id="notes" onclick="viewNotes('notes${invoice.invoiceNo}')" class="sml-btn">Notes</button><div id="notes${invoice.invoiceNo}" style="display: none;">${invoice.note}</div> </td>
									<td><input type="button" value="Print" id="printInvoice" class="sml-btn" onclick="printInvoice(${invoice.invoiceNo})"/></td>
									<td><a href="edit.do?invoiceNo=${invoice.invoiceNo}"><img alt="Edit" src="<%=context%>/images/icn_edit.png" /></a></td>
									<td><a href="#" onclick="deleteInvoice('${invoice.invoiceNo}')"><img alt="Delete" src="<%=context%>/images/icn_remove.png" width="24px" /></a></td>
								</tr>
							</c:forEach>
							</tbody>
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
