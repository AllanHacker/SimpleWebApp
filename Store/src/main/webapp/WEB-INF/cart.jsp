<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Cart</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Cart</h2></header>
		<main class="bg-light pb-5">
			<div class="container text-center">
				<div id='cart'>
					<cart v-for="cart in carts" 
						v-bind:key="cart.id"
						v-bind:cart="cart"
						v-on:cart-delete="cartDelete(cart)"
						v-on:amount-minus="amountMinus(cart)"
						v-on:amount-add="amountAdd(cart)">
					</cart>
					<p class="mt-5">
						一共<span>{{amountCount}}</span>樣商品，
						總金額為：<span>{{totalCount}}</span>元&nbsp;&nbsp;
						<a class="text-decoration-none" href='orderDetailPage.do'>結帳</a>
					</p>
				</div>
			</div>
		</main>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			Vue.component('cart', {
				props: ['cart'],
				template: `
					<div class='row border border-secondary mb-1'>
						<div class='col'>
							<img :src="'/./img/' + cart.productImage" class="img-fluid">
						</div>
						<div class='col align-self-center'>
							<h5>{{cart.productName}}</h5>
							<p class="font-weight-lighter">{{cart.productPrice}}</p>
						</div>
						<div class='col align-self-center'>
							<button class="btn btn-outline-secondary btn-sm" v-on:click="$emit('amount-minus')">-</button>&nbsp;
							<span>{{cart.amount}}</span>&nbsp;
							<button class="btn btn-outline-secondary btn-sm" v-on:click="$emit('amount-add')">+</button>&nbsp;
							<button class="btn btn-outline-secondary btn-sm" v-on:click="$emit('cart-delete')">刪除</button>
						</div>
					</div>
				`
			});
			
			var cartVue = new Vue({
				el: "#cart",
				data: {
					carts: [],
					amountCount: '',
					totalCount: ''
				},
				methods: {
					amountMinus: function (cart) {
						if (cart.amount > 1) {
							$.ajax({
								url: "cartChange.do",
								data: "productId=" + cart.productId +
									"&amount=-1" +
									"&productPrice=" + cart.productPrice,
								type: "post",
								dataType: "json",
								success: function(obj){
									cartList();
								}
							});
						}
					},
					amountAdd: function (cart) {
						if (cart.amount < cart.productNumber) {
							$.ajax({
								url: "cartChange.do",
								data: "productId=" + cart.productId +
									"&amount=1" +
									"&productPrice=" + cart.productPrice,
								type: "post",
								dataType: "json",
								success: function(obj){
									cartList();
								}
							});
						} else {
							alertAPI("已超過庫存!", "alert-danger");
						}
					},
					cartDelete: function (cart){
						$.ajax({
							url: "cartDelete.do",
							data: "id=" + cart.id,
							type: "get",
							dataType: "json",
							success: function(obj){
								if (obj.state == 1) {
									cartList();
								} else {
									alertAPI(obj.message, "alert-danger");
								}
							}
						});
					}
				}
			})
			
			$(function(){
				$("a:contains('Cart')").attr("style", "color:white");
				cartList();
			});
			
			function cartList() {
				$.ajax({
					url: "cartList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("main").attr("style", "height: 70vh;");
							$("#cart").empty();
							$("#cart").append(obj.message);
						} else {
							cartVue.carts = [];
							var amountCount = 0;
							var totalCount = 0;
							for (var i = 0; i < obj.data.length; i++) {
								var cart = obj.data[i];
								cartVue.carts.push({
									productImage: cart.productImage,
									productName: cart.productName,
									productPrice: cart.productPrice,
									amount: cart.amount,
									total: cart.total,
									id: cart.id,
									productId: cart.productId,
									productNumber: cart.productNumber
								});
								amountCount += cart.amount;
								totalCount += cart.total;
							}
							cartVue.amountCount = amountCount;
							cartVue.totalCount = totalCount;
						}
					}
				});
			}
			
		</script>
	</body>
</html>