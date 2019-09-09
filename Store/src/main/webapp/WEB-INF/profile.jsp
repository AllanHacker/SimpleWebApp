<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Profile</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
	</head>
	<body>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Profile</h2></header>
		<main class="bg-light pb-5 d-flex justify-content-center align-items-center" style="height: 70vh;">
			<div class="container text-center h-75">
				<button class="btn btn-outline-secondary" data-toggle="modal" data-target="#userChange">修改個人資料</button>
				<button class="btn btn-outline-secondary" data-toggle="modal" data-target="#passwordChange">修改密碼</button>
				<button class="btn btn-outline-secondary" data-toggle="modal" data-target="#userDelete">刪除帳號</button>
				<div class="container mt-5">
					<div class="row justify-content-center mb-1">
						<div class="col-3 text-right">歡迎回來！</div>
						<div class="col-4" id="nameShow"></div>
					</div>
					<div class="row justify-content-center mb-1">
						<div class="col-3 text-right">電子信箱：</div>
						<div class="col-4" id="emailShow"></div>
					</div>
					<div class="row justify-content-center mb-1">
						<div class="col-3 text-right">手機號碼：</div>
						<div class="col-4" id="phoneShow"></div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="userChange" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">修改個人資料</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<label for="email">電子信箱：</label>
									<input class="form-control" id="email" name="email" type="text" onblur="dataCheck(this)">
									<div id="emailAlert" class=""></div>
								</div>
								<div class="form-group">
									<label for="phone">手機號碼：</label>
									<input class="form-control" id="phone" name="phone" type="text" onblur="dataCheck(this)">
									<div id="phoneAlert" class=""></div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button class="btn btn-outline-secondary btn-sm" onclick="userChange()">確定</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="passwordChange" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">修改密碼</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<label for="oldPassword">密碼：</label>
									<input class="form-control" id="oldPassword" name="oldPassword" type="password" placeholder="請輸入原本的密碼">
									<div id="oldPasswordAlert" class=""></div>
								</div>
								<div class="form-group">
									<label for="password">新密碼：</label>
									<input class="form-control" id="password" name="password" type="password" placeholder="請輸入新密碼" onblur="dataCheck(this)">
									<div id="passwordAlert" class=""></div>
								</div>
								<div class="form-group">
									<label for="password2">密碼驗證：</label>
									<input class="form-control" id="password2" name="password2" type="password" placeholder="請再次輸入新密碼" onblur="dataCheck(this)">
									<div id="password2Alert" class=""></div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button class="btn btn-outline-secondary btn-sm" onclick="passwordChange()">確定</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="userDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">刪除帳號</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<label for="oldPassword">請輸入密碼：</label>
									<input class="form-control" id="pwd" name="pwd" type="password">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button class="btn btn-outline-secondary btn-sm" onclick="userDelete()">確定</button>
						</div>
					</div>
				</div>
			</div>
			
		</main>
		<c:import url="footer.jsp"></c:import>
		
		<script src="jquery-3.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script src="common.js"></script>
		<script type="text/javascript">
			$(function(){
				userLoad();
			});
			
			function userLoad() {
				$.ajax({
					url: "userLoad.do",
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							
						} else {
							$("#email").val(obj.data.email);
							$("#phone").val(obj.data.phone);
							$("#nameShow").text(obj.data.username);
							$("#emailShow").text(obj.data.email);
							$("#phoneShow").text(obj.data.phone);
						}
					}
				});
			}
			
			function dataCheck(tag) {
				var name = $(tag).attr("name");
				$.ajax({
					url: name + "Check.do",
					data: "email=" + $("#email").val() + 
						  "&phone=" + $("#phone").val() + 
						  "&oldPassword=" + $("#oldPassword").val() + 
						  "&password=" + $("#password").val() + 
						  "&password2=" + $("#password2").val(),
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
			
			function userDelete() {
				if (confirm("確定要刪除帳號嗎")) {
					$.ajax({
						url: "userDelete.do",
						data: $("#pwd").val(),
						type: "post",
						dataType: "json",
						success: function(obj){
							if (obj.state == 1) {
								location.href = "logout.do";
							} else {
								alertAPI(obj.message, "alert-danger");
							}
						}
					});
				}
			}
			
			function userChange() {
				$.ajax({
					url: "userChange.do",
					data: "email=" + $("#email").val() + 
						  "&phone=" + $("#phone").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							userLoad();
							$('.modal').modal('hide');
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			function passwordChange() {
				$.ajax({
					url: "passwordChange.do",
					data: "oldPassword=" + $("#oldPassword").val() + 
						  "&password=" + $("#password").val() + 
						  "&password2=" + $("#password2").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							$('.modal').modal('hide');
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			$('.modal').on('hidden.bs.modal', function (e) {
				$("#oldPassword").val("");
				$("#password").val("");
				$("#password2").val("");
				$("#pwd").val("");
				
				$("#email").attr("class", "form-control");
				$("#phone").attr("class", "form-control");
				$("#oldPassword").attr("class", "form-control");
				$("#password").attr("class", "form-control");
				$("#password2").attr("class", "form-control");
				$("#pwd").attr("class", "form-control");
				
				$("#emailAlert").html("");
				$("#phoneAlert").html("");
				$("#passwordAlert").html("");
				$("#password2Alert").html("");
				
			})
			
		</script>
	</body>
</html>