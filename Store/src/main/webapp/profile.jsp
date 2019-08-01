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
			歡迎 <span id="usernameShow"></span>
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
							<div id="emailShow"></div>
							<input id="email" name="email" type="text" onblur="dataCheck(this)">
							<div id="emailAlert"></div>
						</td>
					</tr>
					<tr>
						<td class="words">手機號碼：</td>
						<td>
							<div id="phoneShow"></div>
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
		<footer id="footer"></footer>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url: "profile/dataLoad.do",
					type: "post",
					dataType: "json",
					success: function(obj){
						$("#usernameShow").html(obj.data[0]);
						$("#emailShow").html(obj.data[1]);
						$("#phoneShow").html(obj.data[2]);
					}
				});
			})
			
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
							alert(obj.message);
							if (obj.state == 1) {
								window.location.reload();
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
							alert(obj.message);
							if (obj.state == 1) {
								location.href = "logout.do";
							}
						}
					});
				}
			}
			
		</script>
	</body>
</html>