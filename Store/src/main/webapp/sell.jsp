<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sell Product</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>商品拍賣</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
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
								<input id="file" name="file" type="file" accept=".png" onchange="dataCheck(this)">
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
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			function dataCheck(tag) {
				var name = $(tag).attr("name");
				var formData = new FormData($("#registerInformation")[0]);
				$.ajax({
					url: name + "Check.do",
					data: formData,
					type: "post",
					dataType: "json",
					contentType: false,
					processData: false,
					success: function(obj){
						$("#" + name + "Alert").html(obj.message);
						if (obj.state == 1) {
							$("#" + name + "Alert").css("color", "green");
							$("#" + name).css("border-color", "initial");
							$("#" + name).css("border-width", "2px");
							$("#" + name).css("border-style", "inset");
							if (name == "file") {
								$("#file").css("border", "white 0px none");
							}
						} else {
							$("#" + name + "Alert").css("color", "red");
							$("#" + name).css("border", "red 2px solid");
						}
					}
				});
			}
			
			function productPost() {
				var formData = new FormData($("#registerInformation")[0]);
				$.ajax({
					url: "productPost.do",
					data: formData,
					type: "post",
					dataType: "json",
					contentType: false,
					processData: false,
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							$('#registerInformation')[0].reset();
							$("#productNameAlert").html("");
							$("#categoryIdAlert").html("");
							$("#priceAlert").html("");
							$("#numberAlert").html("");
							$("#imageAlert").html("");
							$("#fileAlert").html("");
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
		</script>
	</body>
</html>