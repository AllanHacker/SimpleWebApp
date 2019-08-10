<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Cart</title>
		<link href="register.css" rel="stylesheet" />
		<link href="alertAPI.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>購物車</h2></div>
			
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="alertAPI.js"></script>
		<script type="text/javascript">
			$(function(){
				cartList();
				
			});
			
			function cartList() {
				$("#cart").empty();
				$.ajax({
					url: "cartList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#content").append("<div id='cart'></div>");
							$("#cart").append(obj.message);
						} else {
							var amountCount = 0;
							var totalCount = 0;
							for (var i = 0; i < obj.data.length; i++) {
								var cart = obj.data[i];
								$("#content").append("<div id='cart'></div>");
								$("#cart").append("<div id='" + i + "' class='cart'></div>");
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append("<img src='${pageContext.request.contextPath}" + cart.productImage + "'>");
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append("<div class='wrap2'></div>");
								$("#"+i+" .wrap2:last").append("<p>" + cart.productName + "</p>");
								$("#"+i+" .wrap2:last").append("<p>" + cart.productPrice + "</p>");
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append("<input type='button' value='-' onclick='amountMinus(this)'>&nbsp;");
								$("#"+i+" div:last").append("<span>" + cart.amount + "</span>&nbsp;");
								$("#"+i+" div:last").append("<input type='button' value='+' onclick='amountAdd(this)'>&nbsp;&nbsp;");
								$("#"+i+" div:last").append("<button name='" + cart.id + "' onclick='cartDelete(this)'>刪除</button>");
								$("#"+i+" div:last").append("<input type='hidden' value='" + cart.productId + "'/>");
								$("#"+i+" div:last").append("<input type='hidden' value='" + cart.productNumber + "'/>");
								amountCount += cart.amount;
								totalCount += cart.total;
							}
							$("#cart").append("一共<span id='amountCount'>" + amountCount + "</span>樣商品，");
							$("#cart").append("總金額為：<span id='totalCount'>" + totalCount + "</span>元&nbsp;&nbsp;");
							$("#cart").append("<a href='#'>結帳</a>");
						}
					}
				});
			}
			
			function amountAdd(tag) {
				var amount = parseInt($(tag).prev().text());
				//庫存數量存在隱藏標籤的value屬性
				var num = parseInt($(tag).siblings(":last").val());
				if (amount < num) {
					amount ++;
					$(tag).prev().text(amount);
					
					var productId = $(tag).siblings(":last").prev().val();
					var productPrice = $(tag).parent().prev().children().children(":last").text();
					$.ajax({
						url: "cartUpdate.do",
						data: "productId=" + productId +
							"&amount=1" +
							"&productPrice=" + productPrice,
						type: "post",
						dataType: "json",
						success: function(obj){
							var total = parseInt($("#totalCount").text());
							total += parseInt(productPrice);
							$("#totalCount").text(total);
							
							var total = parseInt($("#amountCount").text());
							total ++;
							$("#amountCount").text(total);
						}
					});
				} else {
					alertAPI("已超過庫存!", "alertFailure");
				}
			}
			
			function amountMinus(tag) {
			
				var amount = parseInt($(tag).next().text());
				if (amount > 1) {
					amount --;
					$(tag).next().text(amount);
					
					var productId = $(tag).siblings(":last").prev().val();
					var productPrice = -$(tag).parent().prev().children().children(":last").text();
					$.ajax({
						url: "cartUpdate.do",
						data: "productId=" + productId +
							"&amount=-1" +
							"&productPrice=" + productPrice,
						type: "post",
						dataType: "json",
						success: function(obj){
							var total = parseInt($("#totalCount").text());
							total += parseInt(productPrice);
							$("#totalCount").text(total);
							
							var total = parseInt($("#amountCount").text());
							total --;
							$("#amountCount").text(total);
						}
					});
				}
			}
			
			function cartDelete(tag) {
				$.ajax({
					url: "cartDelete.do",
					data: "id=" + $(tag).attr("name"),
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							cartList();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
		</script>
	</body>
</html>