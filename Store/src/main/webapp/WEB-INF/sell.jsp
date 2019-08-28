<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sell Product</title>
		<link href="common.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>商品拍賣</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<div id="category">
					<ul>
						<li v-for="category in categories" 
							v-bind:id="category.id"
							v-on:mouseover="categoryList2($event.target)">{{category.name}}</li>
					</ul>
					<ul>
						<li v-for="category in categories2" 
							v-bind:id="category.id"
							v-on:mouseover="categoryList3($event.target)">{{category.name}}</li>
					</ul>
					<ul>
						<li v-for="category in categories3" 
							v-bind:id="category.id"
							v-on:click="productSelect($event.target)">{{category.name}}</li>
					</ul>
				</div>
				<form id="registerInformation">
					<table>
						<tr>
							<td class="words">分類：</td>
							<td>
								<input id="cat" type="text" readonly="readonly">
								<input id="categoryId" name="categoryId" type="hidden">
								<div id="categoryIdAlert"></div>
							</td>
						</tr>
						<tr>
							<td class="words">名稱：</td>
							<td>
								<input id="productName" name="productName" type="text" onblur="dataCheck(this)">
								<div id="productNameAlert"></div>
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
								<input id="file" name="file" type="file" accept=".png" onchange="dataCheck(this)">
								<div id="fileAlert"></div>
								<div id="imagePreview"></div>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input id="submitButton" type="button" value="確定" onclick="productAdd()">
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
				categoryList1(0);
			});
			
			function categoryList1(id) {
				$.ajax({
					url: "categoryList.do",
					data: "parentId=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var category = obj.data[i];
							categoryVue.categories.push({
								id: category.id,
								name: category.name,
								parentId: category.parentId
							});
						}
					}
				});
			}
			
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
			
			function productAdd() {
				var formData = new FormData($("#registerInformation")[0]);
				$.ajax({
					url: "productAdd.do",
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
							$("#fileAlert").html("");
							$("#imagePreview").empty();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			$("#file").change(function(){
				$("#imagePreview").empty();
				var file = this.files[0];
				var url = window.URL.createObjectURL(file);
				var img = $("<img>").attr("src", url);
				$("#imagePreview").append(img);
			});
			
			var categoryVue = new Vue({
				el: "#category",
				data: {
					categories: [],
					categories2: [],
					categories3: []
				},
				methods: {
					categoryList2: function (t) {
						$.ajax({
							url: "categoryList.do",
							data: "parentId=" + t.id,
							type: "get",
							dataType: "json",
							success: function(obj){
								categoryVue.categories2 = [];
								categoryVue.categories3 = [];
								for (var i = 0; i < obj.data.length; i++) {
									var category = obj.data[i];
									categoryVue.categories2.push({
										id: category.id,
										name: category.name,
										parentId: category.parentId
									});
								}
							}
						});
					},
					categoryList3: function (t) {
						$.ajax({
							url: "categoryList.do",
							data: "parentId=" + t.id,
							type: "get",
							dataType: "json",
							success: function(obj){
								categoryVue.categories3 = [];
								for (var i = 0; i < obj.data.length; i++) {
									var category = obj.data[i];
									categoryVue.categories3.push({
										id: category.id,
										name: category.name,
										parentId: category.parentId
									});
								}
							}
						});
					},
					productSelect: function (t) {
						$("#cat").val($(t).text());
						$("#categoryId").val(t.id);
					}
				}
			})
		</script>
	</body>
</html>