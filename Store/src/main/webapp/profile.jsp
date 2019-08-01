<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Profile</title>
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
			<h2>會員中心</h2>
			歡迎 <span id="showUsername"></span>
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
							<input id="password" name="password" type="password" placeholder="請輸入新密碼" onblur="passwordCheck()">
							<div id="passwordAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">密碼驗證：</td>
						<td>
							<div id=""></div>
							<input id="password2" name="password2" type="password" placeholder="請再次輸入新密碼" onblur="password2Check()">
							<div id="password2Alert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">電子信箱：</td>
						<td>
							<div id="showEmail"></div>
							<input id="email" name="email" type="text" onblur="emailCheck()">
							<div id="emailAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">手機號碼：</td>
						<td>
							<div id="showPhone"></div>
							<input id="phone" name="phone" type="text" onblur="phoneCheck()">
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
							<input id="deleteButton" type="button" value="確定" onclick="deleteUser()">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url: "profile/loadData.do",
					type: "post",
					dataType: "json",
					success: function(obj){
						$("#showUsername").html(obj.data[0]);
						$("#showEmail").html(obj.data[1]);
						$("#showPhone").html(obj.data[2]);
					}
				});
			})
			
			function passwordCheck() {
				$.ajax({
					url: "profile/passwordCheck.do",
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
					url: "profile/password2Check.do",
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
					url: "profile/emailCheck.do",
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
					url: "profile/phoneCheck.do",
					data: "phone=" + $("#phone").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						showMessage("phone", obj);
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
							alert(obj.message);
							if (obj.state == 1) {
								window.location.reload();
							}
						}
					});
				}
			}
			
			function deleteUser() {
				if (confirm("確定要刪除帳號嗎")) {
					$.ajax({
						url: "profile/deleteUser.do",
						data: $("#registerInformation").serialize(),
						type: "post",
						dataType: "json",
						success: function(obj){
							alert(obj.message);
							if (obj.state == 1) {
								location.href = "logout.do";
							}
						}
					});
				}
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