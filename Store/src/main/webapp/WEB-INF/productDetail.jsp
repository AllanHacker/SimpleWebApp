<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Product Details</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
	</head>
	<body>
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<h2>${product.name }</h2>
			<img id="productDetailImage" src="/./img/${product.image}">
			<p>售價： ${product.price }</p>
			<p>庫存： ${product.number }</p>
			數量：
			<input type="button" value="-" onclick="amountMinus()">
			<span id="amount">1</span>
			<input type="button" value="+" onclick="amountAdd()">
			<input type="button" value="立即購買" onclick="buyImmediately()">
			<input type="button" value="加入購物車" onclick="cartAdd()">
		</div>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
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
					},
					error: function(obj){
						alertAPI("請先登入", "alertFailure");
					}
				});
			}
		</script>
	</body>
</html>