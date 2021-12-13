<%
	String context = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="<%=context%>/css/accordion.css" rel="stylesheet">
<script src="<%=context%>/js/jquery.accordion.js"></script>
<script src="<%=context%>/js/raphael-2.1.4.min.js"></script>
    <script src="<%=context%>/js/justgage.js"></script>
<script>
<!-- accordian -->
	$(document).ready(function() {

		$('#multiple [data-accordion]').accordion({
			singleOpen : true
		});

		var hide_menu_wdth = $('#multiple').outerWidth();
		var wndw_wdth = $(window).width();
		var hide_menu = $('#multiple');
		$(".rightpart").height($(window).height() - $('.headerpart').height());
		$(".outermenu").height($(window).height() - $('.headerpart').height());
		
		console.log($(window).height() + " - " + $(document).height());

		$(".rightpart").css({
			"width" : wndw_wdth - hide_menu_wdth + "px"
		});
		$("#btn-toggle").click(function() {
			if (hide_menu.hasClass('visible')) {
				$(".rightpart").animate({
					"width" : wndw_wdth - 75 + "px"
				}, "slow");
				hide_menu.animate({
					"width" : "75px"
				}, "slow").removeClass('visible');
			} else {
				$(".rightpart").animate({
					"width" : wndw_wdth - 300 + "px"
				}, "slow");
				hide_menu.animate({
					"width" : "300px"
				}, "slow").addClass('visible');
			}
			$(".content-wrapper").toggleClass("ps-active");
		});
	});

	$(window).resize(function() {
		var hide_menu_wdth = $('#multiple').outerWidth();
		var wndw_wdth = $(window).width();
		var hide_menu = $('#multiple');
		$(".rightpart").height($(window).height() - $('.headerpart').height());
		$(".outermenu").height($(window).height() - $('.headerpart').height());

		$(".rightpart").css({
			"width" : wndw_wdth - hide_menu_wdth + "px"
		});

	});
</script>
<div id="multiple" data-accordion-group class="leftpart">
			<div class="outermenu">
				<section data-accordion>
					<a href="#" data-control><span><img src="<%=context%>/images/icn_user.png" alt=""></span>Users</a>
					<div data-content>
				 <article><a href="<%=context %>/user/form.do"><span><img src="<%=context%>/images/icn_mange_user.png" alt=""></span>Create User</a></article>
					  <article><a href="<%=context %>/user/view.do"><span><img src="<%=context%>/images/icn_list_user.png" alt=""></span>View User</a></article>
					</div>
				</section>
				<section data-accordion>
					<a href="#" data-control><span><img src="<%=context%>/images/icn_previllages.png" alt=""></span>Invoice</a>
					<div data-content>
					 <article><a href="<%=context %>/invoice/invoice.do"><span><img src="<%=context%>/images/icn_credit_invoice.png" alt=""></span>Credit Invoice</a></article>
					  <article><a href="<%=context %>/invoice/view.do"><span><img src="<%=context%>/images/icn_list_invoice.png" alt=""></span>View Invoices</a></article>
					</div>
				</section>
				<section data-accordion>
					<a href="#" data-control><span><img src="<%=context%>/images/icn_reports.png" alt=""></span>Khata Book</a>
					<div data-content>
					 <article><a href="<%=context %>/customer/collectpayment.do"><span><img src="<%=context%>/images/icn_payment.png" alt=""></span>Customer Payment</a></article>
					 <article><a href="<%=context %>/customer/khatabook.do"><span><img src="<%=context%>/images/icn_balance.png" alt=""></span>Khata Book</a></article>
					 <article><a href="<%=context %>/supplier/form.do"><span><img src="<%=context%>/images/icn_supplier.png" alt=""></span>Supplier Bill Entry</a></article>
					 <article><a href="<%=context %>/supplier/payment.do"><span><img src="<%=context%>/images/icn_payment.png" alt=""></span>Supplier Payment</a></article>
					</div>
				</section>
				<section data-accordion>
					<a href="#" data-control><span><img src="<%=context%>/images/icn_item.png" alt=""></span>Items</a>
					<div data-content>
				 <article><a href="<%=context %>/itemform.do"><span><img src="<%=context%>/images/icn_add_item.png" alt=""></span>Add Items</a></article>
					  <article><a href="<%=context %>/viewitem.do"><span><img src="<%=context%>/images/icn_list_invoice.png" alt=""></span>View Items</a></article>
					</div>
				</section>
				<section data-accordion>
					<a href="#" data-control><span><img src="<%=context%>/images/icn_customer.png" alt=""></span>Customer</a>
					<div data-content>
					  <article><a href="<%=context %>/customer/form.do"><span><img src="<%=context%>/images/icn_add_cust.png" alt=""></span>Add Customer</a></article>
					  <article><a href="<%=context %>/customer/view.do"><span><img src="<%=context%>/images/icn_list_cust.png" alt=""></span>View Customer</a></article>
					</div>
				</section>
				<section data-accordion>
					<a href="<%=context %>/customer/tour.do" data-control><span><img src="<%=context%>/images/icn_tour.png" alt="Tour"></span>Tour</a>
					<%-- <a href="#" data-control><span><img src="<%=context%>/images/icn_tour.png" alt="Tour"></span>Tour</a> --%>
				</section>
				<section data-accordion>
					<a href="<%=context %>/logout.do" data-control><span><img src="<%=context%>/images/icn_logout.png" alt=""></span>Log out</a>
				</section>
			</div>
		
    	  	
	    </div>