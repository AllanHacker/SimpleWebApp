<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Order</title>
		<link href="common.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/vue-resource@1.5.1"></script>
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>我的訂單</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<div id="mask"></div>
				<div id="orderDetail">
					<p>下單時間：{{createdTime}}</p>
					<p>狀態：{{state}}</p>
					<p>金額：{{total}}</p>
					<p>收件人姓名：{{recipientName}}</p>
					<p>收件人電話：{{recipientPhone}}</p>
					<p>收件人地址：{{recipientAddress}}</p>
					<div id="orderProduct">
						<div v-for="product in products" class="cart">
							<div class="wrap">
								<img :src="product.image">
							</div>
							<div class="wrap">
								<div class="wrap2">
									<p>商品名稱：{{product.name}}</p>
									<p>商品價格：{{product.price}}</p>
								</div>
							</div>
							<div class="wrap">
								購買數量：{{product.number}}
							</div>
						</div>
					</div>
					<button onclick="popupClose()">關閉</button>
					<button onclick="orderCancel(this)" v-bind:value="orderId" id="cancelButton">取消訂單</button>
				</div>
				<div id="orderListSection"></div>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			var orderListTemplate = ''+
			'<div class="orderList">' +
				'<p>%CREATED_TIME%</p>' +
				'<p>%STATE%</p>' +
				'<button onclick="popup(%ORDER_ID%)">訂單內容</button>' +
			'</div>';
			
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
							var html = "";
							for (var i = 0; i < obj.data.length; i++) {
								var order = obj.data[i];
								html += orderListTemplate;
								html = html.replace("%CREATED_TIME%", order.createdTime);
								html = html.replace("%STATE%", stateMeaning(order.state));
								html = html.replace("%ORDER_ID%", order.id);
							}
							$("#orderListSection").append(html);
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function popup(id) {
				$("#mask").show();
				$("#orderDetail").show();
				$("#cancelButton").attr("disabled", false);
				$.ajax({
					url: "orderLoad.do",
					data: "id=" + id,
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
							recipientLoad(obj.data.recipientId);
							orderProductLoad(obj.data.id);
						}
					}
				});
			}
			
			function recipientLoad(recipientId) {
				$.ajax({
					url: "recipientLoad.do",
					data: "id=" + recipientId,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						orderDetail.recipientName = obj.data.recipientName;
						orderDetail.recipientPhone = obj.data.recipientPhone;
						orderDetail.recipientAddress = obj.data.postalCode + obj.data.city + obj.data.district + obj.data.road + obj.data.other;
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
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function popupClose() {
				$("#mask").hide();
				$("#orderDetail").hide();
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