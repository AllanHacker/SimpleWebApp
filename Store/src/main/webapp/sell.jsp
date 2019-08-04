<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sell Product</title>
		<link href="register.css" rel="stylesheet" />
		
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<h2>商品拍賣</h2>
			<form id="productInformation">
				<table>
					<tr>
						<td class="words">名稱：</td>
						<td>
							<input id="productName" name="productName" type="text" onblur="dataCheck(this)">
							<div id=""></div>
						</td>
					</tr>
					<tr>
						<td class="words">分類：</td>
						<td>
							<input id="categoryId" name="categoryId" type="text" onblur="dataCheck(this)">
							<div id=""></div>
						</td>
					</tr>
					<tr>
						<td class="words">價格：</td>
						<td>
							<input id="price" name="price" type="text" onblur="dataCheck(this)">
							<div id=""></div>
						</td>
					</tr>
					<tr>
						<td class="words">數量：</td>
						<td>
							<input id="number" name="number" type="text" onblur="dataCheck(this)">
							<div id=""></div>
						</td>
					</tr>
  					<tr>
						<td class="words">圖片：</td>
						<td>
							<input id="image" name="image" type="text" onblur="dataCheck(this)">
							<div id=""></div>
							<input id="file" type="file">
							<input type="button" value="上傳" onclick="imageUpload()">
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input id="submitButton" type="button" value="確定" onclick="productPost()">
						</td>
					</tr>
				</table>
			</form>
		
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			
			function productPost() {
				$.ajax({
					url: "productPost.do",
					data: $("#productInformation").serialize(),
					type: "post",
					dataType: "json",
					success: function(obj){
						alert(obj.message);
						
					}
				});
			}
			
			function imageUpload() {
				var formData = new FormData();
				var image = $("#file")[0].files[0];
				formData.append("image", image);
				formData.append("name", $("#image").val());
				$.ajax({
					url: "imageUpload.do",
					type: "post",
					data: formData,
					dataType: "json",
					processData: false,
					contentType: false,
					success: function(obj){
						alert(obj.message);
					}
				});
			}
		</script>
	</body>
</html>