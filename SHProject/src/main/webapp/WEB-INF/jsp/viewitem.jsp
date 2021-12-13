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
		$("#itemTable").DataTable({
			"columnDefs" : [
				{
					"targets": 2,
					"className": "right-align"
				},
				{
					"targets": 3,
					"className": "right-align"
				},
				{
					"targets": 4,
					"className": "right-align"
				},
				{
					"targets": 7,
					"className": "center-align",
					"width" : "9%"
				},
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
		
		$('div.dataTables_filter input').focus();
		window.scrollTo(0, 0);
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
						<div class="title">Item List</div>
						<div class="table-responsive">
							<table class="table table-bordered" id="itemTable">
								<thead>
								<tr>
									<th>Id</th>
									<th>Name</th>
									<th>Quantity</th>
									<th>Purchase Price</th>
									<th>Price</th>
									<th>Input Date</th>
									<th>Update Date</th>
									<th>Add Stock</th>
									<th>Edit</th>
									<th>Delete</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="item" items="${list}">
									<tr>
										<td>${item.itemId}</td>
										<td>${item.itemName}</td>
										<td>${item.qty}</td>
										<td><fmt:formatNumber minFractionDigits="2" value="${item.purchasePrice}" /></td>
										<td><fmt:formatNumber minFractionDigits="2" value="${item.price}" /></td>
										<td data-sort="${item.inputDate}"><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${item.inputDate}" /></td>
										<td data-sort="${item.updateDate}"><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${item.updateDate}" /></td>
										<td><a href="<%=context %>/addstock.do?id=${item.itemId}"><img alt="Add Stock" src="<%=context%>/images/icn_plus.png" width="24px" /></a></td>
										<td><a href="<%=context %>/edititem.do?id=${item.itemId}"><img alt="Edit" src="<%=context%>/images/icn_edit.png" /></a></td>
										<td><a href="<%=context %>/deleteitem.do?id=${item.itemId}"><img alt="Delete" src="<%=context%>/images/icn_remove.png" width="24px" /></a></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<br />
							<a href="<%=context %>/itemform.do">Add New Item</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>