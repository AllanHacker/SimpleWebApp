<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Mall</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		
	</head>
	<body>
		<section class="d-flex flex-column justify-content-center align-items-center">
			<c:import url="header.jsp"></c:import>
			<div id="content" class="container text-center">
				<h2 id="title">My Mall</h2>
				<c:forEach items="${products}" var="product">
					<div id="product">
						<div class="wrap">
							<img src="/./img/${product.image}">
						</div>
						<div class="wrap">
							${product.name}</br></br>
							庫存：${product.number}</br>
							價格：${product.price}
						</div>
						<div class="wrap">
							<button name="${product.id}" onclick="productEditPage(this)">修改</button>&nbsp;&nbsp;
							<button name="${product.id}" onclick="productDelete(this)">刪除</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			function productEditPage(tag) {
				location.href = "productEditPage.do?id=" + tag.name;
			}
			
			function productDelete(tag) {
				if (confirm("確定要刪除?")) {
					$.ajax({
						url: "productDelete.do",
						data: "id=" + tag.name,
						type: "get",
						dataType: "json",
						success: function(obj){
							location.href = "mallPage.do";
						}
					});
				}
			}
			
		</script>
	</body>
</html>