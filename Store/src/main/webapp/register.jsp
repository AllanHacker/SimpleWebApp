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
			<a href="register.do">註冊</a>
			<a href="#">登入</a>
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
							<input id="submitButton" type="button" value="確定" onclick="submitInfo()">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			function submitInfo() {
				$.ajax({
					url: "userRegister.do",
					data: $("#registerInformation").serialize(),
					type: "post",
					dataType: "json",
					success: function(obj){
						alert(obj.message);
					}
				});
			}
			
			function usernameCheck() {
				var reg = /\w{6,20}/;
				var username = $("#username").val();
				if (reg.test(username)) {
					$("#usernameAlert").html("正確");
					$("#usernameAlert").css("color","green");
					$("#username").css("border-color","initial");
					$("#username").css("border-width","2px");
					$("#username").css("border-style","inset");
				} else {
					$("#usernameAlert").html("帳號不符規定");
					$("#usernameAlert").css("color","red");
					$("#username").css("border","red 2px solid");
				}
			}
			
			function passwordCheck() {
				var reg = /\w{8,30}/;
				var password = $("#password").val();
				if (reg.test(password)) {
					$("#passwordAlert").html("正確");
					$("#passwordAlert").css("color","green");
					$("#password").css("border-color","initial");
					$("#password").css("border-width","2px");
					$("#password").css("border-style","inset");
				} else {
					$("#passwordAlert").html("密碼不符規定");
					$("#passwordAlert").css("color","red");
					$("#password").css("border","red 2px solid");
				}
			}
			
			function password2Check() {
				var password = $("#password").val();
				var password2 = $("#password2").val();
				if (password == password2) {
					$("#password2Alert").html("正確");
					$("#password2Alert").css("color","green");
					$("#password2").css("border-color","initial");
					$("#password2").css("border-width","2px");
					$("#password2").css("border-style","inset");
				} else {
					$("#password2Alert").html("密碼不一致");
					$("#password2Alert").css("color","red");
					$("#password2").css("border","red 2px solid");
				}
			}
			
			function emailCheck() {
				var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
				var email = $("#email").val();
				if (reg.test(email)) {
					$("#emailAlert").html("正確");
					$("#emailAlert").css("color","green");
					$("#email").css("border-color","initial");
					$("#email").css("border-width","2px");
					$("#email").css("border-style","inset");
				} else {
					$("#emailAlert").html("這不是一個信箱");
					$("#emailAlert").css("color","red");
					$("#email").css("border","red 2px solid");
				}
			}
			
			function phoneCheck() {
				var phone = $("#phone").val();
				if (/^09\d{8}$/.test(phone)) {
					$("#phoneAlert").html("正確");
					$("#phoneAlert").css("color","green");
					$("#phone").css("border-color","initial");
					$("#phone").css("border-width","2px");
					$("#phone").css("border-style","inset");
				} else {
					$("#phoneAlert").html("手機格式錯誤");
					$("#phoneAlert").css("color","red");
					$("#phone").css("border","red 2px solid");
				}
			}
			
			function verificationCheck() {
				var verification = $("#verification").val();
				$.ajax({
					url: "checkVerification.do?verificationA=" + verification,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							$("#verificationAlert").html("正確");
							$("#verificationAlert").css("color","green");
							$("#verification").css("border-color","initial");
							$("#verification").css("border-width","2px");
							$("#verification").css("border-style","inset");
						} else {
							$("#verificationAlert").html("驗證碼錯誤");
							$("#verificationAlert").css("color","red");
							$("#verification").css("border","red 2px solid");
						}
					}
				});
			}
			
			function refreshCode() {
				$("#verificationImg")[0].src="verification.do?"+new Date();
			}
			
		</script>
	</body>
</html>