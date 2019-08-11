<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Edit Product</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>商品修改</h2></div>
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
								<input id="file" name="file" type="file" accept=".png">
								<div id="fileAlert"></div>
							</td>
						</tr>
						<tr>
							<td class="words"></td>
							<td>
								<input id="state1" type="radio" name="state" value="1"><span>上架</span><br>
								<input id="state0" type="radio" name="state" value="0"><span>下架</span><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input type=hidden name=id value="${product.id }">
								<input id="submitButton" type="button" value="確定" onclick="productEdit()">
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
			$(function(){
				$("#productName").val("${product.name}");
				$("#categoryId").val("${product.categoryId}");
				$("#price").val("${product.price}");
				$("#number").val("${product.number}");
				$("#state${product.state}").attr("checked", "true");
			
			});
			
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
						} else {
							$("#" + name + "Alert").css("color", "red");
							$("#" + name).css("border", "red 2px solid");
						}
					}
				});
			}
			
			function productEdit() {
				var formData = new FormData($("#registerInformation")[0]);
				$.ajax({
					url: "productEdit.do",
					data: formData,
					type: "post",
					dataType: "json",
					contentType: false,
					processData: false,
					success: function(obj){
						if (obj.state == 0) {
							alertAPI(obj.message, "alertFailure");
						} else {
							alertAPI(obj.message);
						}
					}
				});
			}
			
		</script>
	</body>
</html>