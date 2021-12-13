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
<script type="text/javascript">
	$(document).ready(function(){
		$("#userTable").DataTable();
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
						<div class="title">User List</div>
						<div class="table-responsive">
							<table class="table table-bordered" id="userTable">
								<thead>
								<tr>
									<th>Id</th>
									<th>Username</th>
									<th>Full Name</th>
									<th>&nbsp;</th>
									<th>&nbsp;</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="user" items="${userList}">
									<tr>
										<td>${user.userId}</td>
										<td>${user.username}</td>
										<td>${user.fullName}</td>
										<td><a href="<%=context %>/user/edit.do?userId=${user.userId}">Edit</a></td>
										<td><a href="<%=context %>/user/delete.do?userId=${user.userId}">Delete</a></td>
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