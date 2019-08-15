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
				<select id="city" onchange="countryOption()">
					<option>---縣市---</option>
				</select>
				<select id="country" onchange="roadOption()">
					<option>---鄉鎮區---</option>
				</select>
				<select id="road">
					<option>---路名---</option>
				</select>
				
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			$(function() {
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
			});
			
			function countryOption() {
				$("#country").empty();
				$("#road").empty();
				$("#country").append("<option>---鄉鎮區---</option>");
				$("#road").append("<option>---路名---</option>");
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
				$("#road").append("<option>---路名---</option>");
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
		</script>
	</body>
</html>