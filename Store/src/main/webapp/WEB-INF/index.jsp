<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Index</title>
		<link href="common.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>首頁</h2></div>
			
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
						v-on:click="productList($event.target)">{{category.name}}</li>
				</ul>
			</div>
			
			<div id="productList">
				<div v-for="product in products">
					<a :href="'productDetailPage.do?id=' + product.id">
						<img :src="'/./img/' + product.image"></img>
					</a></br>
					<span>{{product.name}}</span></br>
					<b>{{product.price}}</b>
				</div>
			</div>
			
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
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
						$.ajax({
							url: "categoryListShow.do",
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
							url: "categoryListShow.do",
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
							url: "productListShow.do",
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
					url: "categoryListShow.do",
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