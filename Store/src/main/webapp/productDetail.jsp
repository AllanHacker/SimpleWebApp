<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Product Details</title>
		<link href="register.css" rel="stylesheet" />
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
			<input type="button" value="-" onclick="minusAmount()">
			<span id="amount">1</span>
			<input type="button" value="+" onclick="addAmount()">
			<input type="button" value="立即購買" onclick="cartPageShow()">
			<input type="button" value="加入購物車" onclick="cartAdd()">
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			function addAmount() {
				var amount = $("#amount").text();
				if (amount < ${product.number}) {
					amount ++;
					$("#amount").text(amount);
				} else {
					alert("已超過庫存!");
				}
			}
			
			function minusAmount() {
				var amount = $("#amount").text();
				if (amount > 1) {
					amount --;
					$("#amount").text(amount);
				} else {
					alert("至少要1個!");
				}
			}
			
			function cartPageShow() {
				location.href = "cartPage.do";
			}
			
			function cartAdd() {
				$.ajax({
					url: "cartAdd.do",
					data: "productId=${product.id}&" +
						"productName=${product.name}&" +
						"productCategoryId=${product.categoryId}&" +
						"productPrice=${product.price}&" +
						"productNumber=${product.number}&" +
						"productImage=${product.image}",
					type: "post",
					dataType: "json",
					success: function(obj){
						alert(obj.message);
					}
				});
			}
		</script>
	</body>
</html>