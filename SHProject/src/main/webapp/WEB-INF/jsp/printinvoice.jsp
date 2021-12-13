<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="<%=context%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=context%>/css/jquery-ui.min.css" rel="stylesheet">
<%-- 	<link href="<%=context %>/css/accordion.css" rel="stylesheet"> --%>
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery.dataTables.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style type="text/css">
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
// $(document).ready(function(){
// 	window.print();
// 	window.top.close();
// });
</script>
</head>
<body >

	<div class="table-responsive" id="printableInvoice">
		<table border="0" id="printInvoiceTable" style="width: 100%;">
			<thead class="report-header">
			<tr>
				<td colspan="5" align="center">।।શ્રી શ્રીનાથજીબાવા સત્ય છે।।
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center"><strong>ESTIMATE AND ORDER FORM</strong>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" width="60%">To:<br>${invoice.customer },&nbsp;${invoice.city }</td>
				<td colspan="2">Date:&nbsp;${invoice.invDate }<br>No. :&nbsp;${invoice.invoiceNo }</td>
			</tr>
			<!-- <tr>
				<td colspan="3">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr> -->
			<tr>
				<td colspan="5" align="center">&nbsp;</td>
			</tr>
			</thead>
			<tr>
				<td colspan="5">
					<table border="1" style="width: 100%;">
						<thead class="report-header">
						<tr id="titleRow">
							<th width="5%">No</th>
							<th width="45%">Item Name</th>
							<th width="15%" style="text-align: right;">Qty</th>
							<th width="15%" style="text-align: right;">Price/Unit</th>
							<th width="20%" style="text-align: right;">Total</th>
						</tr>
						</thead>
						<c:if test="${not empty invoice.invoiceDetails }">
							<c:forEach var="invoiceDetails"
								items="${invoice.invoiceDetails }">
								<tr class='invoiceItems'
									id='invoiceItem${invoiceDetails.itemNo }'>
									<td id="${invoiceDetails.itemNo }">${invoiceDetails.itemNo }</td>
									<td id="itemName${invoiceDetails.itemNo }">${invoiceDetails.itemName }&nbsp;${invoiceDetails.details}</td>
									<td id="qty${invoiceDetails.itemNo }" style="text-align: right;">${invoiceDetails.qty }</td>
									<td id="amount${invoiceDetails.itemNo }" style="text-align: right;"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${invoiceDetails.amount }" /></td>
									<td style='text-align: right;'
										id='itemTotal${invoiceDetails.itemNo }'><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${invoiceDetails.total }" /></td>
								</tr>
							</c:forEach>
						</c:if>
						<tr id="totalRow">
							<td width="80%" colspan="4" style="text-align: right;"><strong>Grand
									Total</strong></td>
							<td width="20%" style="text-align: right;" id="finalTotal"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${invoice.grandTotal }" /></td>
						</tr>
<!-- 						<tr id="totalRow"> -->
<!-- 							<td width="80%" colspan="4" style="text-align: right;"><strong>Paid</strong></td> -->
<%-- 							<td width="20%" style="text-align: right;" id="paid">${invoice.paid?'Paid':'Unpaid' }</td> --%>
<!-- 						</tr> -->
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">&nbsp;</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td colspan="5"><strong>Receipt Number:</strong> -->
<%-- 					${invoice.receiptId }</td> --%>
<!-- 			</tr> -->
			<tr>
				<td colspan="5"><strong>Note:</strong> <pre style="border: none; background-color: white; max-width: 510px; white-space: pre-wrap;">${invoice.note }</pre></td>
			</tr>
		</table>
	</div>
</body>
</html>