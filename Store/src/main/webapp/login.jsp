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
							<input id="username" name="username" type="text" onblur="alertClear(this)">
							<div id="usernameAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼：</td>
						<td>
							<input id="password" name="password" type="password" onblur="alertClear(this)">
							<div id="passwordAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">驗證碼：</td>
						<td>
							<input id="verification" name="verification" type="text" onblur="alertClear(this)">
							<img id="verificationImg" src="verification.do" />
							<a href="#" onclick="codeRefresh()">刷新</a>
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
			
			function alertClear(tag) {
				var name = $(tag).attr("name");
				$("#" + name + "Alert").html("");
				$(tag).css("border-color", "initial");
				$(tag).css("border-width", "2px");
				$(tag).css("border-style", "inset");	
			}
			
			function codeRefresh() {
				$("#verificationImg")[0].src="verification.do?"+new Date();
			}
			
			function userLogin() {
				var flag = true;
				if ($("#username").val() == "") {
					alertShow("username", "帳號不得為空");
					flag = false;
				}
				if ($("#password").val() == "") {
					alertShow("password", "密碼不得為空");
					flag = false;
				}
				if ($("#verification").val() == "") {
					alertShow("verification", "請輸入驗證碼");
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
								alertShow("verification", obj.message);
							}
							if (obj.state == 0) {
								alertShow("login", obj.message);
							}
							if (obj.state == 1) {
								location.href = "profilePage.do";
							}
						}
					});
				}
				
				function alertShow(tag, string) {
					$("#" + tag + "Alert").html(string);
					$("#" + tag + "Alert").css("color", "red");
					$("#" + tag).css("border", "red 2px solid");
				}
				
			}
		</script>
	</body>
</html>