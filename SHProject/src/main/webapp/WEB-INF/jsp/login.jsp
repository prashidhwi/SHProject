<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Shrinathji Handicrafts</title>
<link rel="shortcut icon" href="<%=context %>/images/favicon.ico">
<!-- Stylesheet -->
<link href="<%=context %>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=context %>/css/style.min.css" rel="stylesheet">
<link href="<%=context %>/css/custom.css" rel="stylesheet">
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<meta charset="UTF-8">
<script type="text/javascript">
	var message='${SPRING_SECURITY_LAST_EXCEPTION.message}';
	$(document).ready(function(){
		if(message!=''){
			$('#messageText').html(message+'&nbsp;&nbsp;&nbsp;&nbsp;');
			$('#msg').fadeOut(10000);
		}else{
			message='${message}';
			if(message!=''){
				$('#messageText').html(message);
				$('#msg').show();
				$('#msg').fadeOut(10000);
			}
		}
	});
</script>
</head>

<body class="log-page">

	<div class="wrapper1">
	<c:if test="${(SPRING_SECURITY_LAST_EXCEPTION.message!=null && SPRING_SECURITY_LAST_EXCEPTION.message ne '') || message!=null && message ne ''}">
		<div id="msg" class="alert alert-danger">
		    <a href="#" class="close" data-hide="alert">&times;</a>
		    <strong><span id="messageText"></span></strong> 
	  	</div>
  	</c:if>
  	<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
		<form id="loginForm" name="loginForm" method="post" class="login"
		action="j_spring_security_check" data-toggle="validator" role="form">
		<p class="title text-center"><img src="<%=context%>/images/logo.png"></p>
				<input name="j_username" id="username" class="form-control"
					maxlength="100" required placeholder="Username" autofocus/>
	    		<input type="password"
					name="j_password" id="password" class="form-control"
					maxlength="50" required placeholder="Password" />
    
	    <a href="<%=context%>/forgotPassword.jsp">Forgot Password?</a>
	    <button>
	    
	      <span class="state">Log in</span>
	    </button>
	</form>


	</div>

</body>
</html>
