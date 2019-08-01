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
							<input id="username" name="username" type="text" placeholder="6-20位英數字或底線" onblur="dataCheck(this)">
							<div id="usernameAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼：</td>
						<td>
							<input id="password" name="password" type="password" placeholder="8-30位英數字或底線"onblur="dataCheck(this)">
							<div id="passwordAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼驗證：</td>
						<td>
							<input id="password2" name="password2" type="password" placeholder="請再次輸入密碼"onblur="dataCheck(this)">
							<div id="password2Alert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">電子信箱：</td>
						<td>
							<input id="email" name="email" type="text" onblur="dataCheck(this)">
							<div id="emailAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">手機號碼：</td>
						<td>
							<input id="phone" name="phone" type="text" onblur="dataCheck(this)">
							<div id="phoneAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">驗證碼：</td>
						<td>
							<input id="verification" name="verification" type="text" onblur="dataCheck(this)">
							<img id="verificationImg" src="verification.do" />
							<a href="#" onclick="codeRefresh()">刷新</a></br>
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
			function dataCheck(tag) {
				var name = $(tag).attr("name");
				$.ajax({
					url: name + "Check.do",
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
			
			function codeRefresh() {
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
			
		</script>
	</body>
</html>