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
<link href="<%=context%>/css/custom.css" rel="stylesheet" >
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#billDate").datepicker({
			"setDate": new Date(),
			"dateFormat": "dd/mm/yy"
		});
		
		$("#supplierName").autocomplete({
			source: "<%=context%>/supplier/getsuppliers.do",
			autoFocus: true,
			select: function(event,ui){
//	 			$("input[id^='item']").val("test");
				$("#supplierName").html(ui.item.label + " - " + ui.item.value);
				$("#supplierCity").val(ui.item.value);
				
				$("#billId").focus();
			}
		});
	});
</script>
</head>
<body>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart">
			<div class="chartouter">
				<div class="col-xs-12 col-sm-6">
					<div class="box">
						<div class="title">Supplier Bill Entry</div>
						
				       <form:form id="supplierForm" method="post" action="save.do" role="form" onsubmit="return validateForm(this.id);">  
				       		<form:hidden path="supplierId"/>
				       		<div class="form-group">
				       		<label for="supplierName">Supplier Name:</label>
				       		<form:input path="supplierName" class="form-control" validations="notNull:true" autofocus="autofocus"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="supplierCity">City:</label>
				       		<form:input path="supplierCity" class="form-control" validations="notNull:true"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="billId">Bill Number:</label>
				       		<form:input path="billId" class="form-control" validations="notNull:true"/>
				       		</div>
				       		<div class="form-group">
				       		<label for="amount">Amount:</label>
				       		<form:input path="amount" class="form-control" validations="notNull:true,dataType:INT"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="billDate">Bill Date:</label>
				       		<form:input path="billDate" id="billDate" class="form-control" validations="notNull:true"/>
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