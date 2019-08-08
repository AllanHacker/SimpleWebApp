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
			
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
				cartList();
				
			});
			
			function cartList() {
				$.ajax({
					url: "cartList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#content").append(obj.message);
						} else {
							var total = 0;
							for (var i = 0; i < obj.data.length; i++) {
								var cart = obj.data[i];
								$("#content").append("<div id='" + i + "' class='cart'></div>");
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append("<img src='${pageContext.request.contextPath}" + cart.productImage + "'>");
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append(cart.productName + "</br>價格： " + cart.productPrice);
								$("#"+i+"").append("<div class='wrap'></div>");
								$("#"+i+" div:last").append("<input type='button' value='-' onclick=''>&nbsp;");
								$("#"+i+" div:last").append("<span id='amount'>" + cart.amount + "</span>&nbsp;");
								$("#"+i+" div:last").append("<input type='button' value='+' onclick=''>&nbsp;&nbsp;");
								$("#"+i+" div:last").append("<button name='" + cart.id + "' onclick='cartDelete(this)'>刪除</button>");
								total += cart.total;
							}
							$("#content").append("一共<span id='numCount'>" + obj.data.length + "</span>樣商品，");
							$("#content").append("總金額為：<span id='priceCount'>" + total + "</span>元&nbsp;&nbsp;");
							$("#content").append("<a href='#'>結帳</a>");
						}
					}
				});
			}
			
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