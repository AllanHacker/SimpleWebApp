<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Index</title>
		<link href="register.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<h2>首頁</h2>
			<ul id="categoryList"></ul>
			<div id="categoryListChild"></div>
			<div id="productList"></div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url: "categoryListShow.do",
					data: "parentId=0",
					type: "get",
					dataType: "json",
					success: function(obj){
						obj.data.forEach(function(category){
							$("#categoryList").append("<li>" + category.name + "</li>");
							$("li:last").attr("id", category.id);
						});
					}
				});
			});
			
			$(document).on("mouseover", "li", function(event){
				$(this).css("background-color", "yellow");
				var id = $(this).attr("id");
				$.ajax({
					url: "categoryListShow.do",
					data: "parentId=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						$("#categoryListChild").append("<ul></ul>");
						obj.data.forEach(function(category){
							$("#categoryListChild ul").append("<li>" + category.name + "</li>");
						});
					}
				});
			});
			
			$(document).on("mouseout", "li", function(event){
				$(this).css("background-color", "white");
				$("#categoryListChild").empty();
			});
			
			$(document).on("click", "li", function(event){
				$("#productList").empty();
				var id = $(this).attr("id");
				$.ajax({
					url: "productListShow.do",
					data: "categoryId=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						obj.data.forEach(function(product){
							$("#productList").append("<div></div>");
							$("#productList div:last").append("<img src=${pageContext.request.contextPath}" + product.image + "></img></br>");
							$("#productList div:last").append("<span>" + product.name + "</span></br>");
							$("#productList div:last").append("<b>" + product.price + "</b>");
						});
					}
				});
			});
			
		</script>
	</body>
</html>