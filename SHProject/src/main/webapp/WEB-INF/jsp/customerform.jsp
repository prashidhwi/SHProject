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
						<div class="title">Add New Customer</div>
						<form:form id="customerForm" method="post" action="save.do" onsubmit="return validateForm('customerForm');">
				       		<form:hidden path="customerId"/>
				       		<div class="form-group">
				       		<label for="customerName">Customer Name:</label>
				       		<form:input path="customerName" id="customerName" class="form-control" validations="notNull:true" autofocus="autofocus" />
				       		</div>
				       		<div class="form-group">
				       		<label for="organizationName">Organization Name:</label>
				       		<form:input path="organizationName" id="organizationName" class="form-control" />
				       		</div>
				       		<div class="form-group">
				       		<label for="address">Address:</label>
				       		<form:textarea path="address" wrap="physical" class="form-control"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="city">City:</label>
				       		<form:input path="city" id="city" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="contact">Contact Details:</label>
				       		<form:input path="contact" id="contact" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="whatsappNo">Whatsapp Number:</label>
				       		<form:input path="whatsappNo" id="whatsappNo" class="form-control" />
				       		</div>
				       		<div class="form-group">
				       		<label for="gstNo">GST Number:</label>
				       		<form:input path="gstNo" id="gstNo" class="form-control" />
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