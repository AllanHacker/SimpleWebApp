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
		<link href="index.css" rel="stylesheet">
	</head>
	<body>
		<header>
			<c:import url="header.jsp"></c:import>
		</header>
	
		<main role="main">
			<section class="jumbotron text-center">
				<div class="container">
					<h2 class="jumbotron-heading">Category</h2>
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
												v-on:click="productList($event.target)">{{category.name}}</dd>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			<div class="album py-5 bg-light">
				<div class="container">
					<div class="row" id="productList">
						<div class="col-md-4" v-for="product in products">
							<div class="card mb-4 shadow-sm">
								<div class="bd-placeholder-img card-img-top" width="100%" height="225">
									<img :src="'/./img/' + product.image" class="img-fluid" alt="Responsive image"></img>
								</div>
								<div class="card-body">
									<h5 class="card-text">{{product.name}}</h5>
									<p class="card-text">&dollar;&nbsp;{{product.price}}</p>
									<div class="d-flex justify-content-between align-items-center">
										<a :href="'productDetailPage.do?id=' + product.id" class="btn btn-sm btn-outline-secondary">View</a>
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
					productList: function (t) {
						$.ajax({
							url: "productList.do",
							data: "categoryId=" + t.id,
							type: "get",
							dataType: "json",
							success: function(obj){
								if (obj.state == 0) {
									alertAPI(obj.message, "alertFailure");
								}
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
						});
					}
				}
			})
			
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
			
		</script>
	</body>
</html>
