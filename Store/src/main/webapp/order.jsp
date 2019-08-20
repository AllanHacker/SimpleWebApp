<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Order</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>我的訂單</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
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
				'<button onclick="popup(%RECIPIENT_ID%)">訂單內容</button>' +
			'</div>';
			
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
								var text;
								switch (order.state) {
								case 0:
									text = "待付款";
									break;
								case 1:
									text = "待出貨";
									break;
								case 2:
									text = "待收貨";
									break;
								case 3:
									text = "已完成";
									break;
								case 4:
									text = "已取消";
									break;
								case 5:
									text = "退貨";
									break;
								} 
								html += orderListTemplate;
								html = html.replace("%CREATED_TIME%", order.createdTime);
								html = html.replace("%STATE%", text);
								html = html.replace("%RECIPIENT_ID%", order.recipientId);
							}
							$("#orderListSection").append(html);
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
		</script>
	</body>
</html>