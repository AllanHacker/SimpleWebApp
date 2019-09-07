<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Order Detail</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
	</head>
	<body>
		<div id="mask"></div>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Order Detail</h2></header>
		<main class="bg-light pb-5 d-flex justify-content-center align-items-center">
			<div class="container">
				<h4 class="my-4 font-weight-bold">收件人</h4>
				<div id="recipientSection"></div>
				<h4 class="my-4 font-weight-bold">商品</h4>
				<div id="cart"></div>
				<h4 class="my-4 font-weight-bold">總金額</h4>
				<p>&dollar;&nbsp;<span id="totalCount"></span>&nbsp;元</p>
				<div class="container text-center my-4">
					<button class="btn btn-outline-secondary btn-sm" onclick="orderAdd()">下訂單</button>
					<button class="btn btn-outline-secondary btn-sm" onclick="cancel()">取消</button>
				</div>
			</div>
			<div id="popupRecipientList" class="popupStyle p-4 w-50"></div>
		</main>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			var recipientTemplate = '' +
			'<div class="row border border-secondary mb-1">' +
			'	<div class="col p-3">' +
			'		<p>姓名：%RECIPIENT_NAME%</p>' +
			'		<p>電話：%RECIPIENT_PHONE%</p>' +
			'		<p>地址：%RECIPIENT_ADDRESS%</p>' +
			'		<input id="recipientId" type="hidden" value="%RECIPIENT_ID%"/>' +
			'	</div>' +
			'	<div class="col-3 align-self-center">' +
			'		<button class="btn btn-outline-secondary btn-sm" onclick="popup()">更改</button>' +
			'	</div>' +
			'</div>';
		
			var productTemplate = '' +
			'<div id="%CART_ID%" class="row border border-secondary mb-1">' +
			'	<div class="col">' +
			'		<img src="/./img/%PRODUCT_IMAGE%" class="img-fluid">' +
			'	</div>' +
			'	<div class="col align-self-center">' +
			'		<p>名稱：%PRODUCT_NAME%</p>' +
			'		<p>售價：%PRODUCT_PRICE%</p>' +
			'		<p>數量：%PRODUCT_AMOUNT%</p>' +
			'	</div>' +
			'	<div class="col align-self-center">' +
			'		<p>總額：%PRODUCT_TOTAL%</p>' +
			'	</div>' +
			'</div>';
			
			var popupRecipientTemplate = '' +
			'<div class="row border border-secondary mb-1">' +
			'	<div class="col p-3">' +
			'		<p>姓名：%RECIPIENT_NAME%</p>' +
			'		<p>電話：%RECIPIENT_PHONE%</p>' +
			'		<p>地址：%RECIPIENT_ADDRESS%</p>' +
			'	</div>' +
			'	<div class="col-3 align-self-center">' +
			'		<button class="btn btn-outline-secondary btn-sm" value="%INDEX%" onclick="recipientChange(this)">選擇</button>' +
			'	</div>' +
			'</div>';
			
			var productId = [];
			var productNumber = [];
			var cartId = [];
			
			$(function(){
				recipientList(0);
				cartList();
			});	
		
			function recipientList(index) {
				$("#recipientSection").empty();
				$.ajax({
					url: "recipientList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#recipientSection").append("<div>" + obj.message + "</div>");
						} else {
							$("#recipientSection").append('');
							var html = recipientTemplate;
							var recipient = obj.data[index];
							var address = recipient.postalCode + recipient.city + recipient.district + recipient.road + recipient.other;
							html = html.replace("%RECIPIENT_NAME%", recipient.recipientName);
							html = html.replace("%RECIPIENT_PHONE%", recipient.recipientPhone);
							html = html.replace("%RECIPIENT_ADDRESS%", address);
							html = html.replace("%RECIPIENT_ID%", recipient.id);
							$("#recipientSection").append(html);
						}
					}
				});
			}
			
			function cartList() {
				$.ajax({
					url: "cartList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						var html = "";
						var totalCount = 0;
						for (var i = 0; i < obj.data.length; i++) {
							var cart = obj.data[i];
							html += productTemplate;
							html = html.replace("%CART_ID%", cart.id);
							html = html.replace("%PRODUCT_IMAGE%", cart.productImage);
							html = html.replace("%PRODUCT_NAME%", cart.productName);
							html = html.replace("%PRODUCT_PRICE%", cart.productPrice);
							html = html.replace("%PRODUCT_AMOUNT%", cart.amount);
							html = html.replace("%PRODUCT_TOTAL%", cart.total);
							totalCount += cart.total;
							productId.push(cart.productId);
							productNumber.push(cart.amount);
							cartId.push(cart.id);
						}
						$("#cart").append(html);
						$("#totalCount").append(totalCount);
					}
				});
			}
			
			function popupRecipientList() {
				$("#popupRecipientList").empty();
				$.ajax({
					url: "recipientList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						var html = "";
						for (var i = 0; i < obj.data.length; i++) {
							html += popupRecipientTemplate;
							var recipient = obj.data[i];
							var address = recipient.postalCode + recipient.city + recipient.district + recipient.road + recipient.other;
							html = html.replace("%RECIPIENT_NAME%", recipient.recipientName);
							html = html.replace("%RECIPIENT_PHONE%", recipient.recipientPhone);
							html = html.replace("%RECIPIENT_ADDRESS%", address);
							html = html.replace("%INDEX%", i);
						}
						$("#popupRecipientList").append(html);
						$("#popupRecipientList").append('<div class="container text-center my-3">'+
								'<button class="btn btn-outline-secondary btn-sm" onclick="popupClose()">取消</button></div>');
					}
				});
			}
			
			function orderAdd() {
				$.ajax({
					url: "orderAdd.do",
					data: "total=" + $("#totalCount").text() +
						  "&recipientId=" + $("#recipientId").val() +
						  "&productId=" + productId +
						  "&productNumber=" + productNumber,
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							for (var i = 0; i < cartId.length; i++) {
								cartDelete(cartId[i]);
							}
							location.href = "orderPage.do";
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function cartDelete(id) {
				$.ajax({
					url: "cartDelete.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						
					}
				});
			}
			
			function recipientChange(tag) {
				var index = $(tag).val();
				recipientList(index);
				popupClose();
			}
			
			function popup() {
				$("#mask").show();
				$("#popupRecipientList").show();
				popupRecipientList();
			}
			
			function popupClose() {
				$("#mask").hide();
				$("#popupRecipientList").hide();
			}
			
			function cancel() {
				history.back();
			}
		</script>
	</body>
</html>