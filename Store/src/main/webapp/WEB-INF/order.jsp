<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Order</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	</head>
	<body>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Order</h2></header>
		<main class="bg-light pb-5 d-flex justify-content-center align-items-center">
			<div class="container text-center">
				<div id="orderListSection">
					<div class="row justify-content-center mb-1" v-for="order in orders">
						<div class="col-2">{{order.createdTime}}</div>
						<div class="col-2">{{order.state}}</div>
						<div class="col-2">
							<button class="btn btn-outline-secondary btn-sm" onclick="popup(this)" v-bind:value="order.orderId">訂單內容</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="orderDetail" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-xl" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">訂單內容</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="container">
								<small>下單時間：{{createdTime}}</small></br>
								<small>狀態：{{state}}</small></br>
								<small>金額：{{total}}</small></br>
								<small>收件人姓名：{{recipientName}}</small></br>
								<small>收件人電話：{{recipientPhone}}</small></br>
								<small>收件人地址：{{recipientAddress}}</small>
							</div>
							<div id="orderProduct" class="container text-center mt-3">
								<div v-for="product in products" class="row border border-secondary mb-1">
									<div class="col">
										<img :src="product.image" class="img-fluid">
									</div>
									<div class="col align-self-center">
										<small>商品名稱：{{product.name}}</small></br>
										<small>商品價格：{{product.price}}</small>
									</div>
									<div class="col align-self-center">
										<small>購買數量：{{product.number}}</small>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-outline-secondary btn-sm" onclick="orderCancel(this)" v-bind:value="orderId" id="cancelButton">取消訂單</button>
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
			var orderDetail = new Vue({
				el: "#orderDetail",
				data: {
					createdTime: '',
					state: '',
					total: '',
					recipientName: '',
					recipientPhone: '',
					recipientAddress: '',
					products: [],
					orderId: ''
				}
			})
			
			var orderListSection = new Vue({
				el: "#orderListSection",
				data: {
					orders:[]
				}
			})
			
			$(function(){
				orderList();
			});
			
			function orderList() {
				$("#orderListSection").empty();
				$.ajax({
					url: "orderList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							for (var i = 0; i < obj.data.length; i++) {
								var order = obj.data[i];
								orderListSection.orders.push({ createdTime: order.createdTime,
																state: stateMeaning(order.state),
																orderId: order.id });
							}
						} else {
							$("main").attr("style", "height: 70vh;");
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			function popup(tag) {
				$('.modal').modal('show');
				$("#cancelButton").attr("disabled", false);
				$.ajax({
					url: "orderLoad.do",
					data: "id=" + $(tag).val(),
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							var date = new Date(obj.data.createdTime);
							Y = date.getFullYear() + '年';
							M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '月';
							D = date.getDate() + '日 ';
							h = date.getHours() + ':';
							m = date.getMinutes() + ':';
							s = date.getSeconds(); 
							orderDetail.createdTime = Y+M+D+h+m+s;
							orderDetail.state = stateMeaning(obj.data.state);
							orderDetail.total = obj.data.total;
							orderDetail.orderId = obj.data.id;
							if (obj.data.state > 1) {
								$("#cancelButton").attr("disabled", true);
							}
							orderDetail.recipientName = obj.data.recipientName;
							orderDetail.recipientPhone = obj.data.recipientPhone;
							orderDetail.recipientAddress = obj.data.recipientAddress;
							orderProductLoad(obj.data.id);
						}
					}
				});
			}
			
			function orderProductLoad(orderId) {
				$("#orderProduct").empty();
				$.ajax({
					url: "orderProductLoad.do",
					data: "orderId=" + orderId,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var orderProduct = obj.data[i];
							arr = productLoad(orderProduct.productId);
							orderDetail.products.push({ number: orderProduct.productNumber,
														image: "/./img/" + arr[0],
														name: arr[1],
														price: arr[2]});
						}
					}
				});
			}
			
			function productLoad(productId) {
				var result;
				$.ajax({
					url: "productLoad.do",
					data: "id=" + productId,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						result = [obj.data.image, obj.data.name, obj.data.price];
					}
				});
				return result;
			}
			
			function orderCancel(tag) {
				$.ajax({
					url: "orderCancel.do",
					data: "id=" + $(tag).val(),
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							$("#cancelButton").attr("disabled", true);
							orderList();
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			function stateMeaning(state) {
				switch (state) {
				case 0:
					return "待付款";
				case 1:
					return  "待出貨";
				case 2:
					return  "待收貨";
				case 3:
					return  "已完成";
				case 4:
					return  "已取消";
				case 5:
					return  "退貨";
				} 
			}
		</script>
	</body>
</html>