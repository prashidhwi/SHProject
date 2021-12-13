
<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="shortcut icon" href="<%=context %>/images/favicon.ico">
<link type="text/css" rel="stylesheet"
	href="<%=context%>/css/bootstrap.min.css" />
<link href="<%=context%>/css/custom.css" rel="stylesheet">
<script type="text/javascript" src="<%=context%>/js/common.js"></script>
<script src="<%=context%>/js/jquery.scrollTo.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$(function(){
		    $("[data-hide]").on("click", function(){
		        $(this).closest("." + $(this).attr("data-hide")).hide();
		        $('.alert').stop(true,true);
		    });
		});
		
		var expanded=${sessionScope.expanded};
		
		$( "#pin" ).click(function() {
			$("#btn-toggle").toggleClass("stop-sliding");
			var expand=0;
			if ($("#btn-toggle").hasClass("stop-sliding")) {
				if ($('#multiple').hasClass('visible')) {
					expand=1;
					
				}else{
					expand=0;
				}
			}
				$.ajax({
					url: '<%=context%>/pinMenu.do?expanded='+expand,
					success: function(){
						expanded=${sessionScope.expanded};
					}
				});
			
		});
// 		$("#btn-toggle").trigger.click();
		if(expanded==1){
			$("#btn-toggle").attr("class","toggle stop-sliding");
			expandMenu();
		}
	});
</script>
<!-- Header Start -->
<header class="headerpart">
<a href="#" class="toggle" id="btn-toggle">
	<img src="<%=context%>/images/toggle_menu.png" alt="">
</a>
<!--<div class="admin">
	<span class="profilepic">
		<img src="<%=context%>/images/profile_pic.png" alt="profile">
	</span>
	<a href="#">Casper</a>
	<br>
	<label>Welcome back<span>Casper</span></label>
</div> -->

<span class="imghdr">
	<img src="<%=context%>/images/header_img.png" alt="">
</span>
<span style="float: right;margin: 50px 100px 0 0;">
	<img class="profileImage" src="/SHProject/images/profile_pic.png" alt="">
	<a href="#">${sessionScope.user.fullName}</a>
</span>

<!--<a href="" class="logo">
	<img src="<%=context%>/images/logo.png" alt="">
</a> -->
</header>
      <!-- Header End -->