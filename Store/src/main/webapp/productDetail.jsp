<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Product Details</title>
		<link href="register.css" rel="stylesheet" />
		<link href="alertAPI.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<h2>${product.name }</h2>
			<img alt="" src="${pageContext.request.contextPath}${product.image}">
			<p>售價： ${product.price }</p>
			<p>庫存： ${product.number }</p>
			數量：
			<input type="button" value="-" onclick="amountMinus()">
			<span id="amount">1</span>
			<input type="button" value="+" onclick="amountAdd()">
			<input type="button" value="立即購買" onclick="buyImmediately()">
			<input type="button" value="加入購物車" onclick="cartAdd()">
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="alertAPI.js"></script>
		<script type="text/javascript">
			function amountAdd() {
				var amount = $("#amount").text();
				if (amount < ${product.number}) {
					amount ++;
					$("#amount").text(amount);
				} else {
					alertAPI("已超過庫存!", "alertFailure");
				}
			}
			
			function amountMinus() {
				var amount = $("#amount").text();
				if (amount > 1) {
					amount --;
					$("#amount").text(amount);
				} else {
					alertAPI("至少要1個!", "alertFailure");
				}
			}
			
			function buyImmediately() {
				cartAdd();
				location.href = "cartPage.do";
			}
			
			function cartAdd() {
				$.ajax({
					url: "cartAdd.do",
					data: "productId=${product.id}" +
						"&amount=" + $("#amount").text() +
						"&productPrice=${product.price}",
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
		</script>
	</body>
</html>