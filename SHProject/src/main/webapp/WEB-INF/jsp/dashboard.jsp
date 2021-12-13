<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String context = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Shrinathaji Handicrafts</title>
<link rel="shortcut icon" href="<%=context %>/images/favicon.ico">
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<!-- <script type="text/javascript" -->
<%-- 	src="<%=context%>/js/app.js"></script> --%>
</head>
<body>
<div class="page-wrapper">
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="content-wrapper">
		<jsp:include page="/WEB-INF/jsp/menu.jsp" />
		<div class="rightpart">
			<div class="chartouter">
				<div class="col-xs-12" style="width: 99%">
				<c:if test="${message!=null && message ne ''}">
								<div id="msg" class="alert alert-success">
									<a href="#" class="close" data-hide="alert">&times;</a> <strong>${message}</strong>
								</div>
							</c:if>
<!-- 					<div class="box" style="text-align: center;"> -->
						<img alt="Shrinathji Handicrafta" src="<%=context %>/images/logo.png" height="300px">
<!-- 					</div> -->
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>