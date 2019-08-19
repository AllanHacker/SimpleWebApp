<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Order Detail</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>訂單內容</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<div id="mask"></div>
				<div id="popupRecipientList"></div>
				<p>金額：&nbsp;&nbsp;</p>
				<span id="totalCount"></span></br>
				<p>收件人</p>
				<div id="recipientSection"></div>
				<p>商品</p>
				<div id="cart"></div>
				<button onclick="orderAdd()">下訂單</button>
				<button onclick="cancel()">取消</button>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			var recipientTemplate = '' +
			'<div class="wrap">' +
			'	<p>姓名：%RECIPIENT_NAME%</p>' +
			'	<p>電話：%RECIPIENT_PHONE%</p>' +
			'	<p>地址：%RECIPIENT_ADDRESS%</p>' +
			'	<input id="recipientId" type="hidden" value="%RECIPIENT_ID%"/>' +
			'</div>';
		
			var productTemplate = '' +
			'<div id="%CART_ID%" class="cart">' +
			'	<div class="wrap">' +
			'		<img src="http://localhost:8080/img/%PRODUCT_IMAGE%">' +
			'	</div>' +
			'	<div class="wrap">' +
			'		<div class="wrap2">' + 
			'			<p>名稱：%PRODUCT_NAME%</p>' +
			'			<p>售價：%PRODUCT_PRICE%</p>' +
			'			<p>數量：%PRODUCT_AMOUNT%</p>' +
			'		</div>' + 
			'	</div>' +
			'	<div class="wrap">' +
			'		<p>總額：%PRODUCT_TOTAL%</p>' +
			'	</div>' +
			'</div>';
			
			var popupRecipientTemplate = '' +
			'<div class="wrap">' +
			'	<div class="left">' +
			'		<p>姓名：%RECIPIENT_NAME%</p>' +
			'		<p>電話：%RECIPIENT_PHONE%</p>' +
			'		<p>地址：%RECIPIENT_ADDRESS%</p>' +
			'	</div>' +
			'	<div class="right">' +
			'		<button value="%INDEX%" onclick="recipientChange(this)">選擇</button>' +
			'	</div>' +
			'</div>';
			
			var productId = [];
			var productNumber = [];
			
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
							$("#recipientSection").append('<button onclick="popup()">更改</button>');
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
						$("#popupRecipientList").append('<button onclick="popupClose()">取消</button>');
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
							//清空購物車
							//location.href = "orderPage.do";
						} else {
							alertAPI(obj.message, "alertFailure");
						}
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