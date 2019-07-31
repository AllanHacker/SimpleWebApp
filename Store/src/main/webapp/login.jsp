<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Login</title>
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
			<h2>登入</h2>
			<form id="registerInformation">
				<table>
					<tr>
						<td class="words">帳號：</td>
						<td>
							<input id="username" name="username" type="text">
							<div id="usernameAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼：</td>
						<td>
							<input id="password" name="password" type="password">
							<div id="passwordAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">驗證碼：</td>
						<td>
							<input id="verification" name="verification" type="text">
							<img id="verificationImg" src="verification.do" />
							<a href="#" onclick="refreshCode()">刷新</a></br>
							<div id="verificationAlert"></div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input id="submitButton" type="button" value="登入" onclick="userLogin()">
							<div id="loginAlert"></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			
			$("#username").blur(function() {
				$("#usernameAlert").html("");
				$("#loginAlert").html("");
				$(this).css("border-color", "initial");
				$(this).css("border-width", "2px");
				$(this).css("border-style", "inset");	
			});
			
			$("#password").blur(function() {
				$("#passwordAlert").html("");
				$("#loginAlert").html("");
				$(this).css("border-color", "initial");
				$(this).css("border-width", "2px");
				$(this).css("border-style", "inset");	
			});
			
			$("#verification").blur(function() {
				$("#verificationAlert").html("");
				$(this).css("border-color", "initial");
				$(this).css("border-width", "2px");
				$(this).css("border-style", "inset");	
			});
			
			function refreshCode() {
				$("#verificationImg")[0].src="verification.do?"+new Date();
			}
			
			function userLogin() {
				var flag = true;
				if ($("#username").val() == "") {
					$("#usernameAlert").html("帳號不得為空");
					$("#usernameAlert").css("color", "red");
					$("#username").css("border", "red 2px solid");
					flag = false;
				}
				if ($("#password").val() == "") {
					$("#passwordAlert").html("密碼不得為空");
					$("#passwordAlert").css("color", "red");
					$("#password").css("border", "red 2px solid");
					flag = false;
				}
				if ($("#verification").val() == "") {
					$("#verificationAlert").html("請輸入驗證碼");
					$("#verificationAlert").css("color", "red");
					$("#verification").css("border", "red 2px solid");
					flag = false;
				}
				
				if (flag) {
					$.ajax({
						url: "userLogin.do",
						data: $("#registerInformation").serialize(),
						type: "post",
						dataType: "json",
						success: function(obj){
							if (obj.state == 2) {
								$("#verificationAlert").html(obj.message);
								$("#verificationAlert").css("color", "red");
								$("#verification").css("border", "red 2px solid");
							}
							if (obj.state == 0) {
								$("#loginAlert").html(obj.message);
								$("#loginAlert").css("color", "red");
								$("#login").css("border", "red 2px solid");
							}
							if (obj.state == 1) {
								location.href = "profilePage.do";
							}
						}
					});
				}
			}
		</script>
	</body>
</html>