<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Login</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		
	</head>
	<body>
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<main role="main">
			<section class="jumbotron text-center">
				<div class="container">
					<div id="content">
						<h2 class="jumbotron-heading">Login</h2>
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
				</div>
			</section>
		</main>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
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