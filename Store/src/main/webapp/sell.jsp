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
			<form id="registerInformation">
				<table>
					<tr>
						<td class="words">名稱：</td>
						<td>
							<input id="productName" name="productName" type="text" onblur="dataCheck(this)">
							<div id="productNameAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">分類：</td>
						<td>
							<input id="categoryId" name="categoryId" type="text" onblur="dataCheck(this)">
							<div id="categoryIdAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">價格：</td>
						<td>
							<input id="price" name="price" type="text" onblur="dataCheck(this)">
							<div id="priceAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">數量：</td>
						<td>
							<input id="number" name="number" type="text" onblur="dataCheck(this)">
							<div id="numberAlert"></div>
						</td>
					</tr>
  					<tr>
						<td class="words">圖片：</td>
						<td>
							<input id="image" name="image" type="text" onblur="dataCheck(this)">
							<div id="imageAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words"></td>
						<td>
							<input id="file" name="file" type="file" accept=".png">
							<!-- <input type="button" value="上傳" onclick="imageUpload()"> -->
							<div id="fileAlert"></div>
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
			function dataCheck(tag) {
				var name = $(tag).attr("name");
				$.ajax({
					url: name + "Check.do",
					data: $("#registerInformation").serialize(),
					type: "post",
					dataType: "json",
					success: function(obj){
						$("#" + name + "Alert").html(obj.message);
						if (obj.state == 1) {
							$("#" + name + "Alert").css("color", "green");
							$("#" + name).css("border-color", "initial");
							$("#" + name).css("border-width", "2px");
							$("#" + name).css("border-style", "inset");
						} else {
							$("#" + name + "Alert").css("color", "red");
							$("#" + name).css("border", "red 2px solid");
						}
					}
				});
			}
			
			function productPost() {
				//圖片上傳
				imageUpload();
				
				//傳送資料
				$.ajax({
					url: "productPost.do",
					data: $("#registerInformation").serialize(),
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
						//alert(obj.message);
					}
				});
			}
			
		</script>
	</body>
</html>