<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Register</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link href="register.css" rel="stylesheet" />
	</head>
	<body>
		<section class="d-flex flex-column justify-content-center align-items-center">
			<c:import url="header.jsp"></c:import>
			<div id="content" class="container text-center">
				<h2 id="title">Register</h2>
				<form id="registerInformation" class="needs-validation" novalidate>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="username">帳號：</label>
						</div>
						<div class="col-6">
							<input id="username" name="username" type="text"  onblur="dataCheck(this)"
							class="form-control" placeholder="6-20位英數字或底線" required autofocus>
							<div id="usernameAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="password">密碼：</label>
						</div>
						<div class="col-6">
							<input id="password" name="password" type="password"  onblur="dataCheck(this)"
							class="form-control" placeholder="8-30位英數字或底線" required>
							<div id="passwordAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="password2">密碼驗證：</label>
						</div>
						<div class="col-6">
							<input id="password2" name="password2" type="password"  onblur="dataCheck(this)"
							class="form-control" placeholder="請再次輸入密碼" required>
							<div id="password2Alert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="email">電子信箱：</label>
						</div>
						<div class="col-6">
							<input id="email" name="email" type="email"  onblur="dataCheck(this)"
							class="form-control" placeholder="xxx@mail.com" required>
							<div id="emailAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="phone">手機號碼：</label>
						</div>
						<div class="col-6">
							<input id="phone" name="phone" type="text"  onblur="dataCheck(this)"
							class="form-control" placeholder="09XXXXXXXX" required>
							<div id="phoneAlert" class=""></div>
						</div>
						<div class="col-3"></div>
					</div>
					<div class="form-row">
						<div class="col-3 text-right">
							<label for="verification">驗證碼：</label>
						</div>
						<div class="col-6">
							<input id="verification" name="verification" type="text"  onblur="dataCheck(this)"
							class="form-control" placeholder="請看右圖" required>
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
						<button class="btn btn-primary btn-block" onclick="userRegister()">註冊</button>
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
							$("#" + name + "Alert").attr("class", "valid-feedback");
							$("#" + name).attr("class", "form-control is-valid");
						} else {
							$("#" + name + "Alert").attr("class", "invalid-feedback");
							$("#" + name).attr("class", "form-control is-invalid");
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
						if (obj.state == 1) {
							location.href = "logout.do";
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
		</script>
	</body>
</html>