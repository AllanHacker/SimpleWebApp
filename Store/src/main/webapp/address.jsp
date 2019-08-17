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
				<button onclick="popup(0)">新增地址</button>
				<div id="mask"></div>
				<div id="addressForm">
					<div id="wrap">
						<div id="postalCode"></div>
						<select id="city" onchange="countryOption()"></select>
						<select id="country" onchange="roadOption()"></select>
						<select id="road" onchange="postalCode()"></select>
						<input id="other" type="text" placeholder="巷弄號樓">
						<input id="addressId" type="hidden">
						<div>
							<button onclick="addressSubmit()">確定</button>
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
							'<button onclick="addressDefault(%ID%)">預設</button>' +
							'<button onclick="popup(%ID%)">修改</button>' +
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
								var addrStr = address.postalCode + address.city + address.district + address.road + address.other;
								htmlString = htmlString.replace("%ADDRESS%", addrStr);
								htmlString = htmlString.replace(/%ID%/g, address.id);
							}
							$("#addressList").html(htmlString);
							$("#addressList div:first").css("border", "#48D1CC 3px solid");
							$("#addressList div:first").css("background-color", "#E0FFFF");
							$("#addressList div:first div button:first").attr("disabled", "disabled");
						}
					}
				});
			}
			
			function popup(id) {
				$("#mask").show();
				$("#addressForm").show();
				$("#addressId").val(id);
				if (id == 0) {
					cityOption();
					$("#city").append("<option disabled selected hidden>---縣&nbsp;&nbsp;&nbsp;&nbsp;市---</option>");
					$("#country").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				} else {
					cityOption();
					$.ajax({
						url: "addressLoad.do",
						data: "id=" + id,
						type: "get",
						dataType: "json",
						success: function(obj){
							var address = obj.data;
							$("#city option:contains(" + address.city + ")").attr("selected", true);
							countryOption(address.city);
							$("#country option:contains(" + address.district + ")").attr("selected", true);
							roadOption(address.city, address.district);
							$("#road option:contains(" + address.road + ")").attr("selected", true);
							$("#postalCode").text(address.postalCode);
							$("#other").val(address.other);
						}
					});
				}
			}
			
			function closepopup() {
				$("#mask").hide();
				$("#addressForm").hide();
			}
			
			function cityOption() {
				$("#postalCode").empty();
				$("#city").empty();
				$("#country").empty();
				$("#road").empty();
				$("#other").val("");
				$.ajax({
					url: "cityOption.do",
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var city = obj.data[i];
							$("#city").append("<option>" + city + "</option>");
						}
					}
				});
			}
			
			function countryOption(city) {
				$("#postalCode").empty();
				$("#country").empty();
				$("#road").empty();
				if (city === undefined) {
					city = $("#city option:selected").text();
					$("#country").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				}
				$.ajax({
					url: "countryOption.do",
					data: "city=" + city,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var country = obj.data[i];
							$("#country").append("<option>" + country + "</option>");
						}
					}
				});
			}
			
			function roadOption(city, country) {
				$("#postalCode").empty();
				$("#road").empty();
				if (city === undefined || country === undefined) {
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
					city = $("#city option:selected").text();
					country = $("#country option:selected").text();
				}
				$.ajax({
					url: "roadOption.do",
					data: "city=" + city + 
						  "&country=" + country,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var road = obj.data[i];
							$("#road").append("<option>" + road + "</option>");
						}
					}
				});
			}
			
			function postalCode(){
				$.ajax({
					url: "postalCode.do",
					data: "city=" + $("#city option:selected").text() + 
						  "&country=" + $("#country option:selected").text() + 
						  "&road=" + $("#road option:selected").text(),
					type: "get",
					dataType: "json",
					success: function(obj){
						$("#postalCode").text(obj.data);
					}
				});
			}
			
			function addressSubmit() {
				var id = $("#addressId").val();
				if (id == 0) {
					var url = "addressAdd.do"
				} else {
					var url = "addressChange.do"
				}
				$.ajax({
					url: url,
					data: "id=" + id + 
						  "&postalCode=" + $("#postalCode").text() + 
						  "&city=" + $("#city option:selected").text() + 
						  "&district=" + $("#country option:selected").text() + 
						  "&road=" + $("#road option:selected").text() + 
						  "&other=" + $("#other").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							addressList();
							if (id == 0) {
								popup(0);
							} else {
								closepopup();
							}
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
			
			function addressDefault(id) {
				$.ajax({
					url: "addressDefault.do",
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