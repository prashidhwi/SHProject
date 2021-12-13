<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.innerTable td, th {
	border: 1px solid gray;
    vertical-align: top;
    padding: 1px;
    font-size: small;
}

thead.report-header {
	display: table-header-group;
}

</style>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="col-xs-12">
		<div class="box" id="printDetails">
			<div class="table-responsive">
					<c:set var="count" value="${3}" />
					<c:forEach var="customerMap" items="${tourDetailsMap}">
						<c:choose>
						    <c:when test="${count % 35 ge 25}">
						    	<c:set var="count" value="${3}" />
						    	<table id="titleTable" style="page-break-before: always;">
						    </c:when>    
						    <c:otherwise>
								<table id="titleTable">
						    </c:otherwise>
						</c:choose>
						        <tr>
									<td colspan="2" style="text-align: center; border-top: 1px solid #000; border-left: 1px solid #000; border-right: 1px solid #000;"><u>${customerMap.key.replace("~"," - ") }</u></td>
								</tr>
						<tr>
							<td style="text-align: center; border-left: 1px solid #000;">Invoice
									Details</td>
							<td style="text-align: center; border-right: 1px solid #000;">Payment
									Details</td>
						</tr>
						<tr>
							<td align="center" valign="top" style="border-left: 1px solid #000;"><table class="innerTable">
									<thead>
										<tr>
											<th>No</th>
											<!-- 								<th>Customer Name</th> -->
											<!-- 								<th>City</th> -->
											<th style="text-align: right;">Amount</th>
											<!-- 												<th>Paid/Unpaid</th> -->
											<th>Date</th>
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
											<c:set var="count" value="${count+1}" />
											<tr>
												<td>${invoice.invoiceNo }</td>
												<td style="text-align: right;"><fmt:formatNumber
														type="number" minFractionDigits="1" maxFractionDigits="1"
														value="${invoice.grandTotal }" /></td>
												<td>${invoice.invDate }</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td style="text-align: right;">Total</td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" minFractionDigits="2" maxFractionDigits="2"
													value="${invoiceTotal}" /></td>
											<td>&nbsp;</td>
										</tr>
										<c:set var="count" value="${count+1}" />
									</tfoot>
								</table></td>
							<td align="center" valign="top" style="border-right: 1px solid #000;"><table  class="innerTable">
									<thead>
										<tr>
											<th>No</th>
											<!-- 								<th>Customer Name</th> -->
											<!-- 								<th>City</th> -->
											<th style="text-align: right;">Amount</th>
											<th>Date</th>
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
														type="number" minFractionDigits="1" maxFractionDigits="1"
														value="${payment.amount }" /></td>
												<td>${payment.payDate }</td>
												<td>${payment.reference }</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td style="text-align: right;">Total</td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" minFractionDigits="2" maxFractionDigits="2"
													value="${paymentTotal}" /></td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</tfoot>
								</table></td>
						</tr>
						<tr><td colspan="2" style="text-align: center; border-bottom: 1px solid #000; border-left: 1px solid #000; border-right: 1px solid #000;">Total Pending:&nbsp;<strong>${invoiceTotal-paymentTotal }</strong></td></tr>
						<tr><td colspan="2" style="text-align: center;">&nbsp;</td></tr>
						<c:set var="count" value="${count+2}" />
				</table>
					</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>