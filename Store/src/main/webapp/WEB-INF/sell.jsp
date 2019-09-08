<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Sell Product</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body>
		
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Selling</h2></header>
		<main class="bg-light pb-5">
			<div class="container text-center">
				<div class="card text-center" id="category">
					<div class="card-header">
						<ul class="nav nav-tabs card-header-tabs">
							<dd class="nav-item" v-for="category in categories" >
								<span class="nav-link" v-bind:id="category.id" 
								v-on:mouseover="categoryList2(category.id)">{{category.name}}</span>
							</dd>
						</ul>
					</div>
					<div class="card-body">
						<div class="container">
							<div class="row">
								<div class="col-3">
									<ul>
										<dd class="nav-item" v-for="category in categories2" v-bind:id="category.id"
											v-on:mouseover="categoryList3(category.id)">{{category.name}}</dd>
									</ul>
								</div>
								<div class="col-9">
									<ul class="nav">
										<dd class="nav-link" v-for="category in categories3" v-bind:id="category.id"
											v-on:click="productSelect(category.id)" v-on:mouseover="styleChange($event.target)">{{category.name}}</dd>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<form id="registerInformation" class="mt-4">
					<div class="form-row mb-3">
						<div class="col-3 text-right">
							<label for="categoryId">分類：</label>
						</div>
						<div class="col-6">
							<input class="form-control-plaintext" id="cat" type="text"
							placeholder="請由上表選擇" readonly required>
							<input id="categoryId" name="categoryId" type="hidden">
							<div id="categoryIdAlert"></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row mb-3">
						<div class="col-3 text-right">
							<label for="productName">名稱：</label>
						</div>
						<div class="col-6">
							<input class="form-control" id="productName" name="productName" type="text"
							onblur="dataCheck(this)" required>
							<div id="productNameAlert"></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row mb-3">
						<div class="col-3 text-right">
							<label for="price">價格：</label>
						</div>
						<div class="col-6">
							<input class="form-control" id="price" name="price" type="text"
							onblur="dataCheck(this)" required>
							<div id="priceAlert"></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row mb-3">
						<div class="col-3 text-right">
							<label for="number">數量：</label>
						</div>
						<div class="col-6">
							<input class="form-control" id="number" name="number" type="text"
							onblur="dataCheck(this)" required>
							<div id="numberAlert"></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row mb-5">
						<div class="col-3 text-right">
							<label for="file">圖片：</label>
						</div>
						<div class="col-6">
							<input class="form-control-file" id="file" name="file" type="file"
							accept=".png" onchange="dataCheck(this)" required>
							<div id="fileAlert"></div>
							<div id="imagePreview"></div>
						</div>
						<div class="col-3"></div>
					</div>
				</form>
				<div class="row">
					<div class="col"></div>
					<div class="col">
						<button class="btn btn-secondary btn-block" onclick="productAdd()">刊登商品</button>
					</div>
					<div class="col"></div>
				</div>
			</div>
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
							$("#" + name + "Alert").attr("class", "valid-feedback");
							$("#" + name).attr("class", "form-control is-valid");
						} else {
							$("#" + name + "Alert").attr("class", "invalid-feedback");
							$("#" + name).attr("class", "form-control is-invalid");
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
							
							$("#categoryId").attr("class", "form-control-plaintext");
							$("#productName").attr("class", "form-control");
							$("#price").attr("class", "form-control");
							$("#number").attr("class", "form-control");
							$("#file").attr("class", "form-control-file");
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
				var img = $("<img class='img-fluid'>").attr("src", url);
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
					categoryList2: function (id) {
						$(".nav-item span").attr("class", "nav-link");
						$("#" + id).attr("class", "nav-link active");
						$.ajax({
							url: "categoryList.do",
							data: "parentId=" + id,
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
					categoryList3: function (id) {
						$(".col-3 ul dd").attr("style", "background-color: none;");
						$("#" + id).attr("style", "background-color: rgba(0, 0, 0, 0.2);");
						$.ajax({
							url: "categoryList.do",
							data: "parentId=" + id,
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
					productSelect: function (id) {
						$("#cat").val($("#" + id).text());
						$("#categoryId").val(id);
						dataCheck($("#categoryId"));
					},
					styleChange: function (t) {
						$(".col-9 ul dd").attr("style", "background-color: none;");
						$(t).attr("style", "background-color: rgba(0, 0, 0, 0.2); cursor: pointer;");
					}
				}
			})
		</script>
	</body>
</html>