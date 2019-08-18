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
				<p>金額：</p>
				<span id="totalCount">&nbsp;&nbsp;</span></br>
				<p>收件人</p>
				<div id="recipientSection"></div>
				<p>商品</p>
				<div id="cart"></div>
				<button id="">下訂單</button>
				<button id="">取消</button>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			var recipientTemplate = '' +
			'<button id="">更改</button>' +
			'<div class="wrap">' +
			'	<p>姓名：%RECIPIENT_NAME%</p>' +
			'	<p>電話：%RECIPIENT_PRICE%</p>' +
			'	<p>地址：%RECIPIENT_ADDRESS%</p>' +
			'</div>';
		
			var productTemplate = '' +
			'<div id="%PRODUCT_ID%" class="cart">' +
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
			
			$(function(){
				recipientList();
				cartList();
			});	
		
			function recipientList() {
				$.ajax({
					url: "recipientList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#recipientSection").append("<div>" + obj.message + "</div>");
						} else {
							var html = recipientTemplate;
							var recipient = obj.data[0];
							var address = recipient.postalCode + recipient.city + recipient.district + recipient.road + recipient.other;
							html = html.replace("%RECIPIENT_ADDRESS%", address);
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
							html = html.replace("%PRODUCT_ID%", cart.id);
							html = html.replace("%PRODUCT_IMAGE%", cart.productImage);
							html = html.replace("%PRODUCT_NAME%", cart.productName);
							html = html.replace("%PRODUCT_PRICE%", cart.productPrice);
							html = html.replace("%PRODUCT_AMOUNT%", cart.amount);
							html = html.replace("%PRODUCT_TOTAL%", cart.total);
							totalCount += cart.total;
						}
						$("#cart").append(html);
						$("#totalCount").append(totalCount);
					}
				});
			}
		</script>
	</body>
</html>