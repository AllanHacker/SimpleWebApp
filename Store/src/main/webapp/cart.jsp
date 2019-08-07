<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Cart</title>
		<link href="register.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>購物車</h2></div>
			
			<c:forEach items="${carts}" var="cart">
				<div id="product">
					<div class="wrap">
						<img src="${pageContext.request.contextPath}${cart.productImage}">
					</div>
					<div class="wrap">
						${cart.productName}</br></br>
						價格：${cart.productPrice}
					</div>
					<div class="wrap">
						<input type="button" value="-" onclick="">&nbsp;
						<span id="amount">1</span>&nbsp;
						<input type="button" value="+" onclick="">&nbsp;&nbsp;
						<button name="${cart.id}" onclick="cartDelete(this)">刪除</button>
					</div>
				</div>
			</c:forEach>
			
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			function cartDelete(tag) {
				$.ajax({
					url: "cartDelete.do",
					data: "id=" + $(tag).attr("name"),
					type: "get",
					dataType: "json",
					success: function(obj){
						alert(obj.message);
						location.href = "cartPage.do";
					}
				});
			}
		</script>
	</body>
</html>