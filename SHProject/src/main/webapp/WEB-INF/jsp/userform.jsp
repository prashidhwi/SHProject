<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<%=context%>/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=context%>/css/jquery-ui.min.css" rel="stylesheet" >
<link href="<%=context%>/css/custom.css" rel="stylesheet" >
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/common.js"></script>
</head>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart">
			<div class="chartouter">
				<div class="col-xs-12 col-sm-6">
					<div class="box">
						<div class="title">Add New User</div>
						<form:form id="userForm" method="post" action="save.do" onsubmit="retrun validateForm(this.id);">
				       		<form:hidden path="userId"/>
				       		<div class="form-group">
				       		<label for="fullName">Full Name:</label>
				       		<form:input path="fullName" id="fullName" class="form-control" validations="notNull:true" />
				       		</div>
				       		<div class="form-group">
				       		<label for="username">User Name:</label>
				       		<form:input path="username" id="username" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="password">Password:</label>
				       		<form:password path="password" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="confirmPassword">Confirm Password:</label>
				       		<form:password path="confirmPassword" id="confirmPassword" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<input type="submit" value="Save" class="sub-btn" />
				       		</div>
				       </form:form>  
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>