<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Login</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link href="login.css" rel="stylesheet" />
	</head>
	<body>
		<section class="d-flex flex-column justify-content-center align-items-center">
			<c:import url="header.jsp"></c:import>
			<div id="content" class="container text-center">
				<h2 id="title">Login</h2>
			 	<form id="registerInformation" class="needs-validation" novalidate>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="username">帳號：</label>
						</div>
						<div class="col-6">
							<input id="username" name="username" type="text"  onblur="alertClear(this)"
							class="form-control" placeholder="account" required autofocus>
							<div id="usernameAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="password">密碼：</label>
						</div>
						<div class="col-6">
							<input id="password" name="password" type="password"  onblur="alertClear(this)"
							class="form-control" placeholder="password" required>
							<div id="passwordAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="verification">驗證碼：</label>
						</div>
						<div class="col-6">
							<input id="verification" name="verification" type="text"  onblur="alertClear(this)"
							class="form-control" placeholder="verification" required>
							<div id="verificationAlert" class=""></div>
						</div>
						<div class="col-3 text-left">
							<img id="verificationImg" src="verification.do" />
							<a href="#" class="text-decoration-none" onclick="codeRefresh()">刷新</a>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col"></div>
					<div class="col">
						<button class="btn btn-primary btn-block" onclick="userLogin()">登入</button>
					</div>
					<div class="col"></div>
				</div>
			</div>
		</section>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			
			function alertClear(tag) {
				var name = $(tag).attr("name");
				$("#" + name + "Alert").html("");
				$("#" + name + "Alert").attr("class", "");
				$(tag).attr("class", "form-control");
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
							if (obj.state == 3) {
								alertShow("verification", obj.message);
							}
							if (obj.state == 0) {
								alertShow("username", obj.message);
							}
							if (obj.state == 2) {
								alertShow("password", obj.message);
							}
							if (obj.state == 1) {
								location.href = "profilePage.do";
							}
						}
					});
				}
				
				function alertShow(tag, string) {
					$("#" + tag + "Alert").html(string);
					$("#" + tag + "Alert").attr("class", "invalid-feedback");
					$("#" + tag).attr("class", "form-control is-invalid");
				}
				
			}
		</script>
	</body>
</html>