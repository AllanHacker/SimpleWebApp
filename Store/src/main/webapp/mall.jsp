<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Mall</title>
		<link href="register.css" rel="stylesheet" />
		
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<h2>個人賣場</h2>
			<c:forEach items="${products}" var="product">
				<div id="product">
					<div class="wrap">
						<img src="${pageContext.request.contextPath}${product.image}">
					</div>
					<div class="wrap">
						${product.name}</br></br>
						庫存：${product.number}</br>
						價格：${product.price}
					</div>
					<div class="wrap">
						<button onclick="">修改</button>&nbsp;&nbsp;
						<button onclick="">刪除</button>
					</div>
				</div>
			</c:forEach>
		
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			
		</script>
	</body>
</html>