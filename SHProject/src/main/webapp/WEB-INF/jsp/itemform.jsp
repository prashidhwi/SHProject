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
<!------ Include the above in your HEAD tag ---------->
<style type="text/css">
	.highlight{
		background-color: gray;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#size").autocomplete({
		source: "<%=context%>/getsize.do",
		select: function(event,ui){
			$("input[id^='item']").val("test");
		}
	});
	
	$("#color").autocomplete({
		source: "<%=context%>/getcolor.do",
		select: function(event,ui){
			$("input[id^='item']").val("test");
		}
	});
	
	 $("#quantity").keypress(function (e) {
	     //if the letter is not digit then display error and don't type anything
	     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	        //display error message
// 	        $("#errmsg").html("Digits Only").show().fadeOut("slow");
	               return false;
	    }
	   });
	 
	 message='${message}';
		if(message!=''){
			$('#messageText').html(message);
			$('#msg').show();
			$('#msg').fadeOut(10000);
		}
	 $("#itemName").focus();
});
</script>
</head>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart">
			<div class="chartouter">
				<div class="col-xs-12 col-sm-6">
					<div class="box">
						<div class="title">Add New Item</div>
						<div id="msg" class="alert alert-danger" style="display: none;">
						    <a href="#" class="close" data-hide="alert">&times;</a>
						    <p id = "messageText"></p> 
					  	</div>
				       <form:form id="itemForm" method="post" action="save.do" role="form" onsubmit="return validateForm('itemForm');">  
				       		<form:hidden path="itemId"/>
				       		<form:hidden path="isAddStock"/>
				       		<div class="form-group">
				       		<label for="itemName">Item Name:</label>
				       		<form:input path="itemName" id="itemName" class="form-control" validations="notNull:true" disabled="${addStock}"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="quantity">Quantity:</label>
				       		<form:input path="qty" id="quantity" class="form-control" validations="notNull:true,dataType:INT" autofocus="${addStock?'autofocus':'' }" onfocus="this.select();"/>
				       		</div> 
				       		<div class="form-group">
				       		<label for="purchasePrice">Purchase Price:</label>
				       		<form:input path="purchasePrice" id="purchasePrice" class="form-control" validations="notNull:true,dataType:INT" disabled="${addStock}" />
				       		</div> 
				       		<div class="form-group">
				       		<label for="price">Selling Price:</label>
				       		<form:input path="price" id="price" class="form-control" validations="dataType:INT" disabled="${addStock}" />
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

		
