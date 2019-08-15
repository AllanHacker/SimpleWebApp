<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Address</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>地址管理</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<button onclick="popup()">新增地址</button>
				<div id="mask"></div>
				<div id="addressForm">
					<div id="wrap">
						<select id="city" onchange="countryOption()"></select>
						<select id="country" onchange="roadOption()"></select>
						<select id="road"></select>
						<input id="address" type="text" placeholder="巷弄號樓">
						<div>
							<button onclick="addressAdd()">確定</button>
							<button onclick="closepopup()">取消</button>
						</div>
					</div>
				</div>
				<div id="addressList"></div>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			$(function(){
				addressList();
			});
			
			function addressList() {
				$("#addressList").empty();
				var template = 
					'<div class="wrap">' +
						'<div class="left">%ADDRESS%</div>' +
						'<div class="right">' +
							'<button id="%ID%" onclick="">預設</button>' +
							'<button id="%ID%" onclick="">修改</button>' +
							'<button onclick="addressDelete(%ID%)">刪除</button>' +
						'</div>' +
					'</div>';
				
				$.ajax({
					url: "addressList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#addressList").append("<div>" + obj.message + "</div>");
						} else {
							var htmlString = "";
							for (var i = 0; i < obj.data.length; i++) {
								htmlString += template;
								var address = obj.data[i];
								htmlString = htmlString.replace("%ADDRESS%", address.address);
								htmlString = htmlString.replace(/%ID%/g, address.id);
							}
							$("#addressList").html(htmlString);
						}
					}
				});
			}
			
			function popup() {
				$("#city").empty();
				$("#city").append("<option disabled selected hidden>---縣&nbsp;&nbsp;&nbsp;&nbsp;市---</option>");
				$("#country").empty();
				$("#country").append("<option disabled selected hidden>---鄉鎮區---</option>");
				$("#road").empty();
				$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				$("#address").val("");
				$.ajax({
					url: "cityOption.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var city = obj.data[i];
							$("#city").append("<option>" + city + "</option>");
						}
					}
				});
				$("#mask").show();
				$("#addressForm").show();
			}
			
			function closepopup() {
				$("#mask").hide();
				$("#addressForm").hide();
			}
			
			function countryOption() {
				$("#country").empty();
				$("#country").append("<option disabled selected hidden>---鄉鎮區---</option>");
				$("#road").empty();
				$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				$.ajax({
					url: "countryOption.do",
					data: "city=" + $("#city option:selected").text(),
					type: "get",
					dataType: "json",
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var country = obj.data[i];
							$("#country").append("<option>" + country + "</option>");
						}
					}
				});
			}
			
			function roadOption() {
				$("#road").empty();
				$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				$.ajax({
					url: "roadOption.do",
					data: "city=" + $("#city option:selected").text() + 
						  "&country=" + $("#country option:selected").text(),
					type: "get",
					dataType: "json",
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var road = obj.data[i];
							$("#road").append("<option>" + road + "</option>");
						}
					}
				});
			}
			
			function addressAdd() {
				$.ajax({
					url: "addressAdd.do",
					data: "addr=" + $("#city option:selected").text() + 
						  $("#country option:selected").text() + 
						  $("#road option:selected").text() + 
						  "&addr2=" + $("#address").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							addressList();
							popup();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function addressDelete(id) {
				$.ajax({
					url: "addressDelete.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							addressList();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
		</script>
	</body>
</html>