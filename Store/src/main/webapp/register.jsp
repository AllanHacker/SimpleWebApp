<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Register</title>
		<link href="register.css" rel="stylesheet" />
		
	</head>
	<body style="font-size:30px;">
		<header id="header">
			<a href="#">首頁</a>
			<a href="#">購物車</a>
			<a href="registerPage.do">註冊</a>
			<a href="loginPage.do">登入</a>
			<a href="logout.do">登出</a>
			<a href="profilePage.do">會員中心</a>
		</header>
		<div id="content">
			<h2>註冊</h2>
			<form id="registerInformation">
				<table>
					<tr>
						<td class="words">帳號：</td>
						<td>
							<input id="username" name="username" type="text" placeholder="6-20位英數字或底線" onblur="usernameCheck()">
							<div id="usernameAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼：</td>
						<td>
							<input id="password" name="password" type="password" placeholder="8-30位英數字或底線"onblur="passwordCheck()">
							<div id="passwordAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼驗證：</td>
						<td>
							<input id="password2" name="password2" type="password" placeholder="請再次輸入密碼"onblur="password2Check()">
							<div id="password2Alert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">電子信箱：</td>
						<td>
							<input id="email" name="email" type="text" onblur="emailCheck()">
							<div id="emailAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">手機號碼：</td>
						<td>
							<input id="phone" name="phone" type="text" onblur="phoneCheck()">
							<div id="phoneAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">驗證碼：</td>
						<td>
							<input id="verification" name="verification" type="text" onblur="verificationCheck()">
							<img id="verificationImg" src="verification.do" />
							<a href="#" onclick="refreshCode()">刷新</a></br>
							<div id="verificationAlert"></div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input id="submitButton" type="button" value="確定" onclick="userRegister()">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			function usernameCheck() {
				$.ajax({
					url: "usernameCheck.do",
					data: "username=" + $("#username").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("username", obj);
					}
				});
			}
			
			function passwordCheck() {
				$.ajax({
					url: "passwordCheck.do",
					data: "password=" + $("#password").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("password", obj);
					}
				});
			}
			
			function password2Check() {
				$.ajax({
					url: "password2Check.do",
					data: "password=" + $("#password").val() + "&password2=" + $("#password2").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("password2", obj);
					}
				});
			}
			
			function emailCheck() {
				$.ajax({
					url: "emailCheck.do",
					data: "email=" + $("#email").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("email", obj);
					}
				});
			}
			
			function phoneCheck() {
				$.ajax({
					url: "phoneCheck.do",
					data: "phone=" + $("#phone").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("phone", obj);
					}
				});
			}
			
			function verificationCheck() {
				$.ajax({
					url: "verificationCheck.do",
					data: "verificationA=" + $("#verification").val(),
					type: "get",
					dataType: "json",
					success: function(obj){
						showMessage("verification", obj);
					}
				});
			}
			
			function refreshCode() {
				$("#verificationImg")[0].src="verification.do?"+new Date();
			}
			
			function userRegister() {
				$.ajax({
					url: "userRegister.do",
					data: $("#registerInformation").serialize(),
					type: "post",
					dataType: "json",
					success: function(obj){
						alert(obj.message);
						if (obj.state == 1) {
							location.href = "loginPage.do";
						}
					}
				});
			}
			
			function showMessage(tag, obj) {
				$("#" + tag + "Alert").html(obj.message);
				if (obj.state == 1) {
					$("#" + tag + "Alert").css("color", "green");
					$("#" + tag).css("border-color", "initial");
					$("#" + tag).css("border-width", "2px");
					$("#" + tag).css("border-style", "inset");
				} else {
					$("#" + tag + "Alert").css("color", "red");
					$("#" + tag).css("border", "red 2px solid");
				}
			}
		</script>
	</body>
</html>