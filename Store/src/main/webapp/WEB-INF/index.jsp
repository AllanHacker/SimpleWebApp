<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
	<head>
		<title>index</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet"
			href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
			integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
			crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
		<link href="common.css" rel="stylesheet">
		<link href="index.css" rel="stylesheet">
		<link rel="shortcut icon" href="favicon.ico" />
	</head>
	<body>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Category</h2></header>
		<main class="bg-light pb-5">
			<div class="container">
				<div class="card text-center" id="category">
					<div class="card-header">
						<ul class="nav nav-tabs card-header-tabs">
							<dd class="nav-item" v-for="category in categories" >
								<span class="nav-link" v-bind:id="category.id" v-on:mouseover="categoryList2(category.id)">{{category.name}}</span>
							</dd>
						</ul>
					</div>
					<div class="card-body">
						<div class="container">
							<div class="row">
								<div class="col-3">
									<ul>
										<dd class="nav-item" v-for="category in categories2" v-bind:id="category.id" v-on:mouseover="categoryList3(category.id)">{{category.name}}</dd>
									</ul>
								</div>
								<div class="col-9">
									<ul class="nav">
										<dd class="nav-link" v-for="category in categories3" v-bind:id="category.id" v-on:click="productList(category.id)" v-on:mouseover="styleChange($event.target)">{{category.name}}</dd>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="album py-5 bg-light">
				<div class="container">
					<div class="row" id="productList">
						<div class="col-md-4" v-for="product in products">
							<div class="card mb-4 shadow-sm">
								<img :src="'/./img/' + product.image" class="bd-placeholder-img card-img-top img-fluid" style="height:280px"></img>
								<div class="card-body">
									<h5 class="card-text">{{product.name}}</h5>
									<p class="card-text">&dollar;&nbsp;{{product.price}}</p>
									<div class="d-flex justify-content-between align-items-center">
										<div class="btn-group" role="group" aria-label="Basic example">
											<a :href="'productDetailPage.do?id=' + product.id" class="btn btn-sm btn-outline-secondary">
												<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
													width="20" height="20" viewBox="0 0 488.85 488.85" style="enable-background:new 0 0 488.85 488.85;" xml:space="preserve">
													<g>
														<path d="M244.425,98.725c-93.4,0-178.1,51.1-240.6,134.1c-5.1,6.8-5.1,16.3,0,23.1c62.5,83.1,147.2,134.2,240.6,134.2
															s178.1-51.1,240.6-134.1c5.1-6.8,5.1-16.3,0-23.1C422.525,149.825,337.825,98.725,244.425,98.725z M251.125,347.025
															c-62,3.9-113.2-47.2-109.3-109.3c3.2-51.2,44.7-92.7,95.9-95.9c62-3.9,113.2,47.2,109.3,109.3
															C343.725,302.225,302.225,343.725,251.125,347.025z M248.025,299.625c-33.4,2.1-61-25.4-58.8-58.8c1.7-27.6,24.1-49.9,51.7-51.7
															c33.4-2.1,61,25.4,58.8,58.8C297.925,275.625,275.525,297.925,248.025,299.625z"/>
													</g>
												</svg>
											</a>
											<button v-on:click="cartAdd(product.id, product.price)" class="btn btn-sm btn-outline-secondary">
												<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="20" height="20" viewBox="0 0 510 510" 
													style="enable-background:new 0 0 510 510;" xml:space="preserve" role="img" focusable="false">
													<g id="shopping-cart">
														<path d="M153,408c-28.05,0-51,22.95-51,51s22.95,51,51,51s51-22.95,51-51S181.05,408,153,408z M0,0v51h51l91.8,193.8L107.1,306
															c-2.55,7.65-5.1,17.85-5.1,25.5c0,28.05,22.95,51,51,51h306v-51H163.2c-2.55,0-5.1-2.55-5.1-5.1v-2.551l22.95-43.35h188.7
															c20.4,0,35.7-10.2,43.35-25.5L504.9,89.25c5.1-5.1,5.1-7.65,5.1-12.75c0-15.3-10.2-25.5-25.5-25.5H107.1L84.15,0H0z M408,408
															c-28.05,0-51,22.95-51,51s22.95,51,51,51s51-22.95,51-51S436.05,408,408,408z"/>
													</g>
												</svg>
											</button>
										</div>
										<small class="text-muted">庫存：{{product.number}}</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			var productListVue = new Vue({
				el: "#productList",
				data: {
					products: []
				},
				methods: {
					cartAdd: function (id, price) {
						$.ajax({
							url: "cartAdd.do",
							data: "productId=" + id +
								"&amount=1" +
								"&productPrice=" + price,
							type: "post",
							dataType: "json",
							success: function(obj){
								if (obj.state == 1) {
									alertAPI(obj.message);
								} else {
									alertAPI(obj.message, "alert-danger");
								}
							},
							error: function(obj){
								alertAPI("請先登入", "alert-danger");
							}
						});
					}
				}
			})
			
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
					productList: function (id) {
						$.ajax({
							url: "productList.do",
							data: "categoryId=" + id,
							type: "get",
							dataType: "json",
							success: function(obj){
								if (obj.state == 0) {
									alertAPI(obj.message, "alert-danger");
								} else {
									productListVue.products = [];
									for (var i = 0; i < obj.data.length; i++) {
										var product = obj.data[i];
										productListVue.products.push({
											id: product.id,
											name: product.name,
											categoryId: product.categoryId,
											price: product.price,
											number: product.number,
											image: product.image,
											state: product.state,
											userId: product.userId
										});
									}
								}
							}
						});
					},
					styleChange: function (t) {
						$(".col-9 ul dd").attr("style", "background-color: none;");
						$(t).attr("style", "background-color: rgba(0, 0, 0, 0.2); cursor: pointer;");
					}
				}
			})
			
			$(function(){
				//男裝、上衣、襯衫
				categoryList1(0);
				categoryVue.categoryList2(67);
				categoryVue.categoryList3(73);
				categoryVue.productList(143);
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
			
		</script>
	</body>
</html>
