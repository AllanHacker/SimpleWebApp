<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sell Product</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body>
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<main role="main">
			<section class="jumbotron text-center">
				<div class="container">
					<div id="content">
						<h2 class="jumbotron-heading">Selling</h2>
						<div class="card text-center" id="category">
						<div class="card-header">
							<ul class="nav nav-tabs card-header-tabs">
								<dd class="nav-item" v-for="category in categories" >
									<span class="nav-link" v-bind:id="category.id" 
									v-on:mouseover="categoryList2($event.target)">{{category.name}}</span>
								</dd>
							</ul>
						</div>
						<div class="card-body">
							<div class="container">
								<div class="row">
									<div class="col-3">
										<ul>
											<dd class="nav-item" v-for="category in categories2" v-bind:id="category.id"
												v-on:mouseover="categoryList3($event.target)">{{category.name}}</dd>
										</ul>
									</div>
									<div class="col-9">
										<ul class="nav">
											<dd class="nav-link" v-for="category in categories3" v-bind:id="category.id"
												v-on:click="productSelect($event.target)">{{category.name}}</dd>
										</ul>
									</div>
								</div>
							</div>
						</div>
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
			</section>
		</main>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
						$(".nav-item span").attr("class", "nav-link");
						$(t).attr("class", "nav-link active");
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