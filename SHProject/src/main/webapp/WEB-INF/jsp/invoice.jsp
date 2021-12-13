<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="<%=context %>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=context %>/css/jquery-ui.min.css" rel="stylesheet" >
<%-- 	<link href="<%=context %>/css/accordion.css" rel="stylesheet"> --%>
<script src="<%=context%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="<%=context%>/js/jquery.dataTables.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style type="text/css">
	.highlight{
		background-color: gray;
	}
	.invoiceItems:hover{
		background-color: gray;
	}
	#printableInvoice{
		display: none;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('#invoiceDate').datepicker({
// 		"minDate":new Date(),
		"setDate": new Date(),
		"dateFormat": "dd/mm/yy"
	});
	if($("#invoiceDate").val()==null || $("#invoiceDate").val()==""){
		n =  new Date();
		y = n.getFullYear();
		m = n.getMonth() + 1;
		d = n.getDate();
		$("#invoiceDate").val(String('00' + d).slice(-2) + "/" + String('00' + m).slice(-2) + "/" + y);
	}
	$("#itemName").autocomplete({
		source: "<%=context%>/getitems.do",
		autoFocus: true,
		select: function(event,ui){
// 			$("input[id^='item']").val("test");
			$("#amount").val(ui.item.value);
			ui.item.value=ui.item.label;
			$("#details").focus();
		}
	});
	
	$("#customerName").autocomplete({
		source: "<%=context%>/customer/getcustomers.do",
		autoFocus: true,
		select: function(event,ui){
// 			$("input[id^='item']").val("test");
			$("#customerCity").val(ui.item.label.split(" | ")[1]);
			ui.item.value=ui.item.label.split(" | ")[0];
			$("#itemName").focus();
		}
	});

	// Execute a function when the user releases a key on the keyboard
	$("input").keyup(function(event) {
	  // Number 13 is the "Enter" key on the keyboard
// 	  console.log("keyup");
	  if($('#qty').val() != "" && $('#amount').val() != ""){
		  var total = $('#qty').val() * $('#amount').val();
		  $('#itemTotal').html(total.toFixed(2));
	  }
	  if (event.keyCode === 13) {
	    // Cancel the default action, if needed
	    event.preventDefault();
	    // Trigger the button element with a click
	    document.getElementById("add").click();
	  }
	});
	
	
	
	$("#add").click(function(){
		if($('#itemName').val() != "" && $('#qty').val() !="" && parseInt($('#qty').val())>0 && $('#amount').val() != ""){
			
			var itemCount = $('#invoiceTable tr').length -2;
			var isNewItem = true;
			for(var i=1;i<=itemCount;i++){
				if($("#itemName").val()==$("#itemName"+i).html()){
// 						&& $("#details").val()==$("#details"+i).html()){
					var finalTotal = parseFloat($("#finalTotal").html()) - parseFloat($('#itemTotal'+i).html()) + parseFloat($('#itemTotal').html());
				  	$("#finalTotal").html(finalTotal.toFixed(2));
				  	
					$("#itemName"+i).html($("#itemName").val());
					$("#details"+i).html($("#details").val());
					$("#qty"+i).html($("#qty").val());
					$("#amount"+i).html($("#amount").val());
					$("#itemTotal"+i).html($("#itemTotal").html());
					$("#invoiceItem"+i).attr("style","background-color:yellow;")
					setTimeout(function(){
						$("#invoiceItem"+i).attr("style","background-color:white;");	
					},200)
					isNewItem = false;
					break;
				}
			}
			
			if(isNewItem){
				var rowCount = $('#invoiceTable tr').length-1;
				var row = "<tr class='invoiceItems' id='invoiceItem"+rowCount+"'>";
				row += "<td id='"+rowCount+"'>" + rowCount + "</td>";
				row +="<td id='itemName"+rowCount+"'>"+ $('#itemName').val() +"</td>";
				row +="<td id='details"+rowCount+"'>"+ $('#details').val() +"</td>";
				row +="<td id='qty"+rowCount+"'>"+ $('#qty').val() + "</td>";
				row +="<td id='amount"+rowCount+"'>"+ $('#amount').val() + "</td>";
				row +="<td style='text-align: right;' id='itemTotal"+rowCount+"'>"+ $('#itemTotal').html() + "</td>";
// 				row +="<td id='verify"+rowCount+"'><input type='checkbox' /></td>";
				row +="<td id='remove'"+rowCount+"><img alt='Delete' src='<%=context %>/images/icn_remove.png' width='20px' id='removeItem"+ rowCount +"'></td>";
				row +="</tr>";
				
				var finalTotal = parseFloat($("#finalTotal").html()) + parseFloat($('#itemTotal').html());
			  	$("#finalTotal").html(finalTotal.toFixed(2));
				
				$('#totalRow').before(row);
			}
			
			$('#itemName').val("");
			$('#details').val("");
			$('#qty').val("");
			$('#amount').val("");
			$('#itemTotal').html("");
			
		}
		$('#itemName').focus();
		
		$('#invoiceItem'+ rowCount).click(function(){
			invoiceRowClick(rowCount);
		});
		
		$('#removeItem'+ rowCount).click(function(){
			removeRowClick($(this).attr("id").replace("removeItem",""));
		});
	});
	
	function invoiceRowClick(itemNumber){
		$("#invoiceItem"+itemNumber).attr("style","background-color:#CCC;");
		$("#itemName").val($("#itemName"+itemNumber).html().trim());
		$("#details").val($("#details"+itemNumber).html().trim());
		$("#qty").val($("#qty"+itemNumber).html().trim());
		$("#amount").val($("#amount"+itemNumber).html().trim());
		$("#amount").keyup();
		$('#itemName').focus();
	}
	
	$( "tr[id^='invoiceItem']" ).click(function(){
		var itemNumber = $('#'+$($(this).first()).attr("id")+' td:first-child').attr('id');
		$("#invoiceItem"+itemNumber).attr("style","background-color:#CCC;");
		$("#itemName").val($("#itemName"+itemNumber).html().trim());
		$("#details").val($("#details"+itemNumber).html().trim());
		$("#qty").val($("#qty"+itemNumber).html().trim());
		$("#amount").val($("#amount"+itemNumber).html().trim());
		$("#amount").keyup();
		$('#itemName').focus();
	});
	
	function removeRowClick(rowNumber){
		var finalTotal = parseFloat($("#finalTotal").html()) - parseFloat($('#itemTotal'+rowNumber).html());
	  	$("#finalTotal").html(finalTotal.toFixed(2));
		$("#invoiceItem"+rowNumber).remove();
	  	var count = 1;
	  	$("tr[id^='invoiceItem']").each(function(){
	  		$(this).attr("id","invoiceItem"+count);
			$(this).find("td:eq(0)").html(count);
			$(this).find("td:eq(0)").attr("id",count);
			$(this).find("td:eq(1)").attr("id","itemName"+count);
			$(this).find("td:eq(2)").attr("id","details"+count);
			$(this).find("td:eq(3)").attr("id","qty"+count);
			$(this).find("td:eq(4)").attr("id","amount"+count);
			$(this).find("td:eq(5)").attr("id","itemTotal"+count);
			$(this).find("td:eq(6)").attr("id","remove"+count);
			$($(this).find("td:eq(6)")).find("img:eq(0)").attr("id","removeItem"+count);
			count++;
		});
	}	
	
	$( "img[id^='removeItem']" ).click(function(){
		alert("direct event");
		var rowNumber = parseInt($(this).attr("id").replace("removeItem",""));
		var finalTotal = parseFloat($("#finalTotal").html()) - parseFloat($('#itemTotal'+rowNumber).html());
	  	$("#finalTotal").html(finalTotal.toFixed(2));
		$("#invoiceItem"+rowNumber).remove();
	  	var count = 1;
	  	$("tr[id^='invoiceItem']").each(function(){
			$(this).find("td:eq(0)").html(count);
			$(this).find("td:eq(0)").attr("id",count);
			$(this).find("td:eq(1)").attr("id","itemName"+count);
			$(this).find("td:eq(2)").attr("id","details"+count);
			$(this).find("td:eq(3)").attr("id","qty"+count);
			$(this).find("td:eq(4)").attr("id","amount"+count);
			$(this).find("td:eq(5)").attr("id","itemTotal"+count);
			$(this).find("td:eq(6)").attr("id","remove"+count);
			$($(this).find("td:eq(6)")).find("img:eq(0)").attr("id","removeItem"+count);
			count++;
		});
	});
	
	$("#saveInvocie").click(function(){
		saveInvoice(false);
	});
	$("#saveAndCloseInvocie").click(function(){
		saveInvoice(true);
	});
	
	function saveInvoice(isCancel){
		if($('#invoiceTable tr').length-2==0){
			alert("Please add one item in the Invoice");
			return;
		
		}
		
		var invoice = {
				invoiceNo: 0,
				customer: "",
				city: "",
				invDate: "",
				invoiceDate: new Date(),
				grandTotal: 0.0,
				discount: 0,
				isPaid: false,
				receiptId: "",
				note: "",
				editFlag:"",
				invoiceDetails	: new Array(invoiceDetails)
		};
// 		var invoice = new Object();
// 		console.log(JSON.stringify(invoice));
		var invoiceDetailList	= new Array();
		for(var i=1;i<=$('#invoiceTable tr').length-2;i++){
			var invoiceDetails = {
					invoiceNo: 0,
					itemNo: 0,
					itemName: "",
					details: "",
					qty: 0,
					amount: 0.0,
					total: 0.0
			};
// 			var invoicedtl = new Object(invoiceDetails);
			if($("#itemName"+i).html()!=null && $("#itemName"+i).html()!=''){
				invoiceDetails.invoiceNo = $("#invoiceNo").html();
				invoiceDetails.itemNo = i;
				invoiceDetails.itemName = $("#itemName"+i).html();
				invoiceDetails.details = $("#details"+i).html();
				invoiceDetails.qty = $("#qty"+i).html()
				invoiceDetails.amount = $("#amount"+i).html();
				invoiceDetails.total = $("#itemTotal"+i).html();
				invoiceDetailList.push(invoiceDetails);
			}
		}
		invoice.invoiceNo = $("#invoiceNo").html();
		invoice.customer = $("#customerName").val();
		invoice.city = $("#customerCity").val();
		invoice.invDate = $("#invoiceDate").val();
		invoice.invoiceDate = null;
		invoice.grandTotal = $("#finalTotal").html();
		invoice.isPaid = $('#paid').is(":checked");
		invoice.receiptId = $("#receiptId").val();
		invoice.note = $("#note").val();
		invoice.invoiceDetails = invoiceDetailList;
		invoice.editFlag = $("#editFlag").val();
		console.log(JSON.stringify(invoice));
		
		$.ajax({
			url:"<%=context%>/invoice/save.do",
			method:'post',
			dataType: 'json',
			contentType: 'application/json',
	        data: JSON.stringify(invoice),
	        success: function(data) {
	            if(data!="Invoice Saved Successfully"){
	          		alert(data);
	            } else {
					if(isCancel){
						location="<%=context%>/invoice/view.do";	            	
					} else {
						location="<%=context%>/invoice/edit.do?invoiceNo="+$('#invoiceNo').html();
					}

// 	            	if($("#editFlag").val()!=null){
<%-- 	          			location="<%=context%>/invoice/view.do"; --%>
// 	          		} else {
// 		            	location.reload();
// 	          		}
	            }
           	}
			
		});
		
		
	}
	
	$("#printInvoice").click(function(){
<%-- 		location = '<%=context %>/invoice/print.do?invoiceNo='+ $('#invoiceNo').html(); --%>
		$.ajax({
			url:"<%=context%>/invoice/print.do?invoiceNo=" + $('#invoiceNo').html(),
			method:'get',
			dataType : "html",
	        success: function(data) {
	        	console.log(data)
				var printableHtml = data;
				 var newWin=window.open('','Print-Window');
		
				  newWin.document.open();
		
				  newWin.document.write('<html><body onload="window.print()">'+printableHtml+'</body></html>');
		
				  newWin.document.close();
	        }
		});
	});
	
	$("#customerName").focus();
	window.scrollTo(0, 0);
});
</script>
</head>
<body>
	<div class="page-wrapper">
		<jsp:include page="/WEB-INF/jsp/header.jsp" />

		<!-- Page Conetnt Start -->
		<div class="content-wrapper">
			<jsp:include page="/WEB-INF/jsp/menu.jsp" />

			<div class="rightpart">
				<div class="chartouter">
					<div class="col-xs-12">
						<div class="box">
							<div class="title">Credit Invoice</div>
							<c:if test="${message!=null && message ne ''}">
								<div id="msg" class="alert alert-success">
									<a href="#" class="close" data-hide="alert">&times;</a> <strong>${message}</strong>
								</div>
							</c:if>
							<input type="hidden" id="editFlag" value="${editFlag }">
									<div class="table-responsive">
										<table border="0" cellpadding="2px">
											<tbody>
												<tr>
													<td colspan="3">
														<table border="00" style="width: 100%;">
															<tr>
																<td width="30%">Customer Name:</td>
																<td><input type="text" name="customerName"
																	id="customerName" value="${invoice.customer }"
																	${not empty invoice.customer?'disabled':'' } />
															</tr>
															<tr>
																<td width="30%">City</td>
																<td><input type="text" name="customerCity"
																	id="customerCity" value="${invoice.city }"
																	${not empty invoice.city?'disabled':'' } />
															</tr>
														</table>
													</td>
													<td colspan="3" style="text-align: right">
														<table border="00" style="width: 100%;">
															<tr>
																<td width="30%">Date:</td>
																<td><input type="text" id="invoiceDate"
																	value="${invoice.invDate }"
																	${not empty invoice.invDate?'disabled':'' } /></td>
															</tr>
															<tr>
																<td width="30%">Invoice Number:</td>
																<td id="invoiceNo">${not empty invoice.invoiceNo?invoice.invoiceNo:invoiceNumber }</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr><td colspan="6">&nbsp;</td></tr>
												<tr style="margin-top: 20px;">
													<td width="0%">&nbsp;</td>
													<td width="30%">Item Name</td>
													<td width="15%">Details</td>
													<td width="15%">Qty</td>
													<td width="15%">Price/Unit</td>
													<td width="25%" style="text-align: right;">Total</td>
													<td width="0%">&nbsp;</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td><input type="text" id="itemName" name="itemName"
														style="width: 100%;" ${invoice.paid?'disabled':''}/></td>
													<td><input type="text" id="details" name="details"
														style="width: 90%;" ${invoice.paid?'disabled':''}/></td>
													<td><input type="text" id="qty" name="qty"
														style="width: 40px;"${invoice.paid?'disabled':''} /></td>
													<td><input type="text" id="amount" name="amount"
														style="width: 60px;" ${invoice.paid?'disabled':''}/></td>
													<td><label id="itemTotal"></label></td>
													<td><button id="add" accesskey="Enter"
															style="float: right;" class="sml-btn" ${invoice.paid?'disabled':''}>Add</button></td>
												</tr>
											</tbody>
										</table>
										</div>
										<div class="table-responsive">
											<table border="1" id="invoiceTable" style="width: 100%;"
												class="table table-bordered">
												<tr id="titleRow">
													<th width="5%">No</th>
													<th width="30%">Item Name</th>
													<th width="15%">Details</th>
													<th width="15%">Qty</th>
													<th width="15%">Price/Unit</th>
													<th width="19%" style="text-align: right;">Total</th>
													<th width="1%">&nbsp;</th>
												</tr>
												<c:if test="${not empty invoice.invoiceDetails }">
													<c:forEach var="invoiceDetails"
														items="${invoice.invoiceDetails }">
														<tr class='invoiceItems'
															id='invoiceItem${invoiceDetails.itemNo }'>
															<td id="${invoiceDetails.itemNo }">${invoiceDetails.itemNo }</td>
															<td id="itemName${invoiceDetails.itemNo }">${invoiceDetails.itemName }</td>
															<td id="details${invoiceDetails.itemNo }">${invoiceDetails.details }</td>
															<td id="qty${invoiceDetails.itemNo }">${invoiceDetails.qty }</td>
															<td id="amount${invoiceDetails.itemNo }">${invoiceDetails.amount }</td>
															<td style='text-align: right;'
																id='itemTotal${invoiceDetails.itemNo }'>${invoiceDetails.total }</td>
															<td id="remove${invoiceDetails.itemNo }"><c:if test="${invoice.paid ne true }"> <img alt="Delete" src="<%=context %>/images/icn_remove.png" width="20px" id="removeItem${invoiceDetails.itemNo }"></c:if></td>
														</tr>
													</c:forEach>
												</c:if>
												<tr id="totalRow">
													<td width="80%" colspan="5" style="text-align: right;"><strong>Grand
															Total</strong></td>
													<td width="19%" style="text-align: right;" id="finalTotal">${not empty invoice.grandTotal?invoice.grandTotal:'0.00' }</td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</div>
										<div class="table-responsive">
										<table style="width: 100%;">
											<tr>
												<td style="vertical-align: top;"><strong
													style="vertical-align: top;">Receipt Number: </strong><input
													type="text" id="receiptId" value="${invoice.receiptId }" /></td>
												<td align="right">
													<div class="form-group">
														<div class="rem">
													 		<input type="checkbox" id="paid" ${invoice.paid?'checked':''} />
													 		<label for="paid"><span></span> Paid</label>
												 		</div>
											 		</div>
										 		</td>
											</tr>
											<tr>
												<td colspan="2" style="vertical-align: top;"><strong
													style="vertical-align: top;">Note: </strong>
												<textarea id="note" cols="100">${invoice.note}</textarea></td>
											</tr>
											<tr>
												<td align="right" colspan="2" style="padding-top: 5;"><input type="button"
													value="Save" id="saveInvocie" class="sub-btn" ${invoice.paid?'disabled':''}/>&nbsp;<input type="button"
													value="Save & Close" id="saveAndCloseInvocie" class="sub-btn" ${invoice.paid?'disabled':''}/>&nbsp;<input type="button"
													value="Print" id="printInvoice" class="sub-btn"/></td>
											</tr>
										</table>
										</div>
										<div class="table-responsive" id="printableInvoice">
											<table border="0" id="printInvoiceTable" style="width: 100%;">
												<thead class="report-header">
													<tr>
														<td colspan="5" align="center">।।શ્રી શ્રીનાથજીબાવા સત્ય છે।।
														</td>
													</tr>
													<tr>
														<td colspan="5" align="center"><strong>ESTIMATE AND ORDER FORM</strong>
														</td>
													</tr>
													<tr>
														<td colspan="5" align="center">&nbsp;</td>
													</tr>
													<tr>
														<td colspan="3" width="60%">To:<br>${invoice.customer },&nbsp;${invoice.city }</td>
														<td colspan="2">Date:&nbsp;${invoice.invDate }<br>No. :&nbsp;${invoice.invoiceNo }</td>
													</tr>
													<!-- <tr>
														<td colspan="3">&nbsp;</td>
														<td colspan="2">&nbsp;</td>
													</tr> -->
													<tr>
														<td colspan="5" align="center">&nbsp;</td>
													</tr>
												</thead>
												<tr>
													<td colspan="5">
														<table border="1" style="width: 100%;">
															<tr id="titleRow">
																<th width="5%">No</th>
																<th width="45%">Item Name</th>
																<th width="15%">Qty</th>
																<th width="15%">Price/Unit</th>
																<th width="19%" style="text-align: right;">Total</th>
																
															</tr>
														</table>
													</td>
												</tr>
												<tr><td colspan="5" align="center">&nbsp;</td></tr>
<!-- 												<tr> -->
<%-- 													<td colspan="5"><strong>Receipt Number:</strong> ${invoice.receiptId }</td> --%>
<!-- 												</tr> -->
												<tr>
													<td colspan="5"><strong>Note:</strong> ${invoice.note }</td>
												</tr>
											</table>
										</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 	<div id="finalTotal" style="display: none;">0</div> -->
</body>
</html>