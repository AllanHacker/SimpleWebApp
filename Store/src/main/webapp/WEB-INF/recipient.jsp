<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Recipient</title>
		<link href="common.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>收件人管理</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<button onclick="popup(0)">新增收件人</button>
				<div id="mask"></div>
				<div id="recipientForm">
					<div id="wrap">
						<input id="recipientName" type="text" placeholder="姓名">
						<input id="recipientPhone" type="text" placeholder="手機">
						<input id="postalCode" type="text" placeholder="郵遞區號" readonly="readonly">
						<select id="city" onchange="districtOption()"></select>
						<select id="district" onchange="roadOption()"></select>
						<select id="road" onchange="postalCode()"></select>
						<input id="other" type="text" placeholder="巷弄號樓">
						<input id="recipientId" type="hidden">
						<div>
							<button onclick="recipientSubmit()">確定</button>
							<button onclick="closepopup()">取消</button>
						</div>
					</div>
				</div>
				<div id="recipientList"></div>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			$(function(){
				recipientList();
			});
			
			function recipientList() {
				$("#recipientList").empty();
				var template = 
					'<div class="wrap">' +
						'<div class="left">' +
							'<p>姓名：%RECIPIENT_NAME%</p>' +
							'<p>手機：%RECIPIENT_PHONE%</p>' +
							'<p>地址：%RECIPIENT_ADDRESS%</p>' +
						'</div>' +
						'<div class="right">' +
							'<button onclick="recipientDefault(%ID%)">預設</button>' +
							'<button onclick="popup(%ID%)">修改</button>' +
							'<button onclick="recipientDelete(%ID%)">刪除</button>' +
						'</div>' +
					'</div>';
				
				$.ajax({
					url: "recipientList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("#recipientList").append("<div>" + obj.message + "</div>");
						} else {
							var htmlString = "";
							for (var i = 0; i < obj.data.length; i++) {
								htmlString += template;
								var recipient = obj.data[i];
								var address = recipient.postalCode + recipient.city + recipient.district + recipient.road + recipient.other;
								htmlString = htmlString.replace("%RECIPIENT_NAME%", recipient.recipientName);
								htmlString = htmlString.replace("%RECIPIENT_PHONE%", recipient.recipientPhone);
								htmlString = htmlString.replace("%RECIPIENT_ADDRESS%", address);
								htmlString = htmlString.replace(/%ID%/g, recipient.id);
							}
							$("#recipientList").html(htmlString);
							$("#recipientList div:first").css("border", "#48D1CC 3px solid");
							$("#recipientList div:first").css("background-color", "#E0FFFF");
							$("#recipientList div:first div button:first").attr("disabled", "disabled");
						}
					}
				});
			}
			
			function popup(id) {
				$("#mask").show();
				//$("#recipientForm").css("display", "flex");
				$("#recipientForm").show();
				$("#recipientId").val(id);
				$("#recipientName").val("");
				$("#recipientPhone").val("");
				if (id == 0) {
					cityOption();
					$("#city").append("<option disabled selected hidden>---縣&nbsp;&nbsp;&nbsp;&nbsp;市---</option>");
					$("#district").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				} else {
					cityOption();
					$.ajax({
						url: "recipientLoad.do",
						data: "id=" + id,
						type: "get",
						dataType: "json",
						success: function(obj){
							var recipient = obj.data;
							$("#recipientName").val(recipient.recipientName);
							$("#recipientPhone").val(recipient.recipientPhone);
							$("#city option:contains(" + recipient.city + ")").attr("selected", true);
							districtOption(recipient.city);
							$("#district option:contains(" + recipient.district + ")").attr("selected", true);
							roadOption(recipient.city, recipient.district);
							$("#road option:contains(" + recipient.road + ")").attr("selected", true);
							$("#postalCode").val(recipient.postalCode);
							$("#other").val(recipient.other);
						}
					});
				}
			}
			
			function closepopup() {
				$("#mask").hide();
				$("#recipientForm").hide();
			}
			
			function cityOption() {
				$("#postalCode").val("");
				$("#city").empty();
				$("#district").empty();
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
			
			function districtOption(city) {
				$("#postalCode").val("");
				$("#district").empty();
				$("#road").empty();
				if (city === undefined) {
					city = $("#city option:selected").val();
					$("#district").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				}
				$.ajax({
					url: "districtOption.do",
					data: "city=" + city,
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var district = obj.data[i];
							$("#district").append("<option>" + district + "</option>");
						}
					}
				});
			}
			
			function roadOption(city, district) {
				$("#postalCode").val("");
				$("#road").empty();
				if (city === undefined || district === undefined) {
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
					city = $("#city option:selected").val();
					district = $("#district option:selected").val();
				}
				$.ajax({
					url: "roadOption.do",
					data: "city=" + city + 
						  "&district=" + district,
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
					data: "city=" + $("#city option:selected").val() + 
						  "&district=" + $("#district option:selected").val() + 
						  "&road=" + $("#road option:selected").val(),
					type: "get",
					dataType: "json",
					success: function(obj){
						$("#postalCode").val(obj.data);
					}
				});
			}
			
			function recipientSubmit() {
				var id = $("#recipientId").val();
				if (id == 0) {
					var url = "recipientAdd.do"
				} else {
					var url = "recipientChange.do"
				}
				$.ajax({
					url: url,
					data:"recipientName=" + $("#recipientName").val() +
						 "&recipientPhone=" + $("#recipientPhone").val() +
						 "&postalCode=" + $("#postalCode").val() + 
						 "&city=" + $("#city option:selected").text() + 
						 "&district=" + $("#district option:selected").text() + 
						 "&road=" + $("#road option:selected").text() + 
						 "&other=" + $("#other").val() +
						 "&id=" + id,
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
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
			
			function recipientDelete(id) {
				$.ajax({
					url: "recipientDelete.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function recipientDefault(id) {
				$.ajax({
					url: "recipientDefault.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
		</script>
	</body>
</html>