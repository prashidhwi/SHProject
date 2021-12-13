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
		$("#customerTable").DataTable({
			"columnDefs" : [
				{
					"targets": 8,
					"className": "center-align"
				},
				{
					"targets": 9,
					"className": "center-align"
				}
			]
		});
	});
</script>
</head>
<body>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart" style="width: 98%">
			<div class="chartouter">
				<div class="col-xs-12">
					<div class="box">
						<div class="title">Customer List</div>
						<div class="table-responsive">
							<table class="table table-bordered" id="customerTable">
								<thead>
								<tr>
									<th>Id</th>
									<th>Customer Name</th>
									<th>Organization Name</th>
									<th>Address</th>
									<th>City</th>
									<th>Contact Details</th>
									<th>Whatsapp Number</th>
									<th>GST Number</th>
									<th>Edit</th>
									<th>Delete</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="customer" items="${list}">
									<tr>
										<td>${customer.customerId}</td>
										<td>${customer.customerName}</td>
										<td>${customer.organizationName}</td>
										<td><pre>${customer.address}</pre></td>
										<td>${customer.city}</td>
										<td>${customer.contact}</td>
										<td>${customer.whatsappNo}</td>
										<td>${customer.gstNo}</td>
										<td><a href="<%=context %>/customer/edit.do?customerId=${customer.customerId}"><img alt="Edit" src="<%=context%>/images/icn_edit.png" /></a></td>
										<td><a href="<%=context %>/customer/delete.do?customerId=${customer.customerId}"><img alt="Delete" src="<%=context%>/images/icn_remove.png" width="24px" /></a></td>
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