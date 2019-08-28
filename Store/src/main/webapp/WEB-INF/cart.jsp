<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Cart</title>
		<link href="common.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>購物車</h2></div>
			<div id='cart'>
				<cart v-for="cart in carts" 
					v-bind:key="cart.id"
					v-bind:cart="cart"
					v-on:cart-delete="cartDelete(cart)"
					v-on:amount-minus="amountMinus(cart)"
					v-on:amount-add="amountAdd(cart)">
				</cart>
				一共<span>{{amountCount}}</span>樣商品，
				總金額為：<span>{{totalCount}}</span>元&nbsp;&nbsp;
				<a href='orderDetailPage.do'>結帳</a>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			Vue.component('cart', {
				props: ['cart'],
				template: `
					<div class='cart'>
						<div class='wrap'>
							<img :src="'/./img/' + cart.productImage">
						</div>
						<div class='wrap'>
							<div class='wrap2'>
								<p>{{cart.productName}}</p>
								<p>{{cart.productPrice}}</p>
							</div>
						</div>
						<div class='wrap'>
							<button v-on:click="$emit('amount-minus')">-</button>&nbsp;
							<span>{{cart.amount}}</span>&nbsp;
							<button v-on:click="$emit('amount-add')">+</button>&nbsp;
							<button v-on:click="$emit('cart-delete')">刪除</button>
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
							alertAPI("已超過庫存!", "alertFailure");
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
									alertAPI(obj.message, "alertFailure");
								}
							}
						});
					}
				}
			})
			
			$(function(){
				cartList();
			});
			
			function cartList() {
				$.ajax({
					url: "cartList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
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