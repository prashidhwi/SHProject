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
<link href="<%=context%>/css/custom.css" rel="stylesheet">
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
<div class="table-responsive">
	<table class="table table-bordered" cellpadding="1">
		<tr>
			<td colspan="2" align="center">${customer }- ${city }</td>
		</tr>
		<tr>
			<td align="center">Invoice Details</td>
			<td align="center">Payment Details</td>
		</tr>
		<tr>
			<td valign="top">
				<div class="table-responsive">
					<table class="table table-bordered" id="invoiceTable">
						<thead>
							<tr>
								<th>Invoice No</th>
								<th style="text-align: right;">Total</th>
								<th>Invoice Date</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="invoiceTotal" value="${0}" />
							<c:forEach var="invoice" items="${invoiceList}">
								<tr>
									<td>${invoice.invoiceNo }</td>
									<td style="text-align: right;">${invoice.grandTotal }</td>
									<td>${invoice.invDate }</td>
								</tr>
								<c:set var="invoiceTotal"
									value="${invoiceTotal + invoice.grandTotal}" />
							</c:forEach>
							<tr>
								<td><strong>Total</strong></td>
								<td style="text-align: right;">${invoiceTotal }</td>
								<td>&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</div>
			</td>
			<td valign="top">
				<div class="table-responsive">
					<table class="table table-bordered" id="paymentTable">
						<thead>
							<tr>
								<th>Pay Id</th>
								<th style="text-align: right;">Amount Paid</th>
								<th>Paid Date</th>
								<th>Reference</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="paymentTotal" value="${0}" />
							<c:forEach var="payment" items="${paymentList}">
								<tr>
									<td>${payment.paymentId }</td>
									<td style="text-align: right;">${payment.amount }</td>
									<td>${payment.payDate }</td>
									<td>${payment.reference }</td>
								</tr>
								<c:set var="paymentTotal"
									value="${paymentTotal + payment.amount}" />
							</c:forEach>
							<tr>
								<td><strong>Total</strong></td>
								<td style="text-align: right;">${paymentTotal }</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
		<tr><td colspan="2" style="text-align: center;"><strong>Total Pending:&nbsp;${invoiceTotal-paymentTotal }</strong></td> </tr>
	</table>
	</div>
	<%-- <div class="chartouter">
<!-- 				<div class="col-xs-12 col-sm-6"> -->
				<div class="col-xs-12">
						<div class="box" id="accountDetails">
							<div class="title" id="customerDetail">${customer } - ${city }</div>
							<div id="totalPendingDetails" class="box" style="width: 99%; display: none;">
								<div id="totalPendingAmount" style="text-align: center; font-size: 14pt; font-weight: bold;"></div>
								
							</div>
							<div class="box" style="width: 45%">
								<div class="title">Invoice Details</div>
								<div class="table-responsive">
									<table class="table table-bordered" id="invoiceTable">
										<thead>
											<tr>
												<th>Invoice No</th>
												<th style="text-align: right;">Total</th>
												<th>Invoice Date</th>
											</tr>
										</thead>
										<tbody>
										<c:set var="invoiceTotal" value="${0}"/>
										<c:forEach var="invoice" items="${invoiceList}">
											<tr>
												<td>${invoice.invoiceNo }</td>
												<td>${invoice.grandTotal }</td>
												<td>${invoice.invDate }</td>
											</tr>
											<c:set var="invoiceTotal" value="${invoiceTotal + invoice.grandTotal}" />
										</c:forEach>
										<tr>
											<td><strong>Total</strong></td>
											<td>${invoiceTotal }</td>
											<td>&nbsp;</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="box" style="width: 54%; margin-left: 10px;">
								<div class="title">Payment Details</div>
								<div class="table-responsive">
									<table class="table table-bordered" id="paymentTable">
										<thead>
											<tr>
												<th>Payment Id</th>
												<th style="text-align: right;">Amount Paid</th>
												<th>Paid Date</th>
												<th>Reference</th>
											</tr>
										</thead>
										<tbody>
										<c:set var="paymentTotal" value="${0}"/>
										<c:forEach var="payment" items="${paymentList}">
											<tr>
												<td>${payment.paymentId }</td>
												<td>${payment.amount }</td>
												<td>${payment.payDate }</td>
												<td>${payment.reference }</td>
											</tr>
											<c:set var="paymentTotal" value="${paymentTotal + payment.amount}" />
										</c:forEach>
										<tr>
											<td><strong>Total</strong></td>
											<td>${paymentTotal }</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							
						</div>
					</div>
			</div> --%>
</body>
</html>