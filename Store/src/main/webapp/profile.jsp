<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Profile</title>
		<link href="register.css" rel="stylesheet" />
		<link href="alertAPI.css" rel="stylesheet" />
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>帳號修改</h2></div>
			<c:import url="userLeftBar.jsp"></c:import>
			<div id="rightWrap">
				<form id="registerInformation">
					<table>
						<tr>
							<td class="words">密碼：</td>
							<td>
								<div id=""></div>
								<input id="oldPassword" name="oldPassword" type="password" placeholder="請輸入原本的密碼">
								<div id="oldPasswordAlert"></div>
							</td>
						</tr>
						<tr>
							<td class="words">新密碼：</td>
							<td>
								<div id=""></div>
								<input id="password" name="password" type="password" placeholder="請輸入新密碼" onblur="dataCheck(this)">
								<div id="passwordAlert"></div>
							</td>
						</tr>
						<tr>
							<td class="words">密碼驗證：</td>
							<td>
								<div id=""></div>
								<input id="password2" name="password2" type="password" placeholder="請再次輸入新密碼" onblur="dataCheck(this)">
								<div id="password2Alert"></div>
							</td>
						</tr>
						<tr>
							<td class="words">電子信箱：</td>
							<td>
								<div id="emailShow">${user.email}</div>
								<input id="email" name="email" type="text" onblur="dataCheck(this)">
								<div id="emailAlert"></div>
							</td>
						</tr>
						<tr>
							<td class="words">手機號碼：</td>
							<td>
								<div id="phoneShow">${user.phone}</div>
								<input id="phone" name="phone" type="text" onblur="dataCheck(this)">
								<div id="phoneAlert"></div>
							</td>
						</tr>
						
						<tr>
							<td></td>
							<td>
								<input id="submitButton" type="button" value="確定" onclick="userUpdate()">
							</td>
						</tr>
						<tr>
							<td class="words">刪除帳號：</td>
							<td>
								<input id="deleteButton" type="button" value="確定" onclick="userDelete()">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="alertAPI.js"></script>
		<script type="text/javascript">
			function dataCheck(tag) {
				var name = $(tag).attr("name");
				$.ajax({
					url: "profile/" + name + "Check.do",
					data: $("#registerInformation").serialize(),
					type: "post",
					dataType: "json",
					success: function(obj){
						$("#" + name + "Alert").html(obj.message);
						if (obj.state == 1) {
							$("#" + name + "Alert").css("color", "green");
							$("#" + name).css("border-color", "initial");
							$("#" + name).css("border-width", "2px");
							$("#" + name).css("border-style", "inset");
						} else {
							$("#" + name + "Alert").css("color", "red");
							$("#" + name).css("border", "red 2px solid");
						}
					}
				});
			}
			
			function userUpdate() {
				if (confirm("確定要修改嗎?")) {
					$.ajax({
						url: "profile/userUpdate.do",
						data: $("#registerInformation").serialize(),
						type: "post",
						dataType: "json",
						success: function(obj){
							if (obj.state == 1) {
								window.location.reload();
							} else {
								alertAPI(obj.message, "alertFailure");
							}
						}
					});
				}
			}
			
			function userDelete() {
				if (confirm("確定要刪除帳號嗎")) {
					$.ajax({
						url: "profile/userDelete.do",
						data: $("#registerInformation").serialize(),
						type: "post",
						dataType: "json",
						success: function(obj){
							if (obj.state == 1) {
								location.href = "logout.do";
							} else {
								alertAPI(obj.message, "alertFailure");
							}
						}
					});
				}
			}
			
		</script>
	</body>
</html>