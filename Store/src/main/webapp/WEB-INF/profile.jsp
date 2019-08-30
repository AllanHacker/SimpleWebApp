<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>User Center</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		
	</head>
	<body>
		<header id="header">
			<c:import url="header.jsp"></c:import>
		</header>
		<div id="content">
			<div id="title"><h2>會員中心</h2></div>
			<button onclick="popupUserChange()">修改個人資料</button>
			<button onclick="popupPasswordChange()">修改密碼</button>
			<button onclick="popupUserDelete()">刪除帳號</button>
			<div id="mask"></div>
			
			<div id="userChange">
				<div class="formFather">
					<div class="leftForm">電子信箱：</div>
					<div class="rightForm">
						<input id="email" name="email" type="text" onblur="dataCheck(this)">
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm"></div>
					<div class="rightForm">
						<div id="emailAlert"></div>
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm">手機號碼：</div>
					<div class="rightForm">
						<input id="phone" name="phone" type="text" onblur="dataCheck(this)">
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm"></div>
					<div class="rightForm">
						<div id="phoneAlert"></div>
					</div>
				</div>
				<div class="formFather">
					<button onclick="userChange()">確定</button>
					<button onclick="closepopup()">取消</button>
				</div>
			</div>
			
			<div id="passwordChange">
				<div class="formFather">
					<div class="leftForm">密碼：</div>
					<div class="rightForm">
						<input id="oldPassword" name="oldPassword" type="password" placeholder="請輸入原本的密碼">
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm"></div>
					<div class="rightForm">
						<div id="oldPasswordAlert"></div>
					</div>
				</div class="formFather">
				
				<div class="formFather">
					<div class="leftForm">新密碼：</div>
					<div class="rightForm">
						<input id="password" name="password" type="password" placeholder="請輸入新密碼" onblur="dataCheck(this)">
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm"></div>
					<div class="rightForm">
						<div id="passwordAlert"></div>
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm">密碼驗證：</div>
					<div class="rightForm">
						<input id="password2" name="password2" type="password" placeholder="請再次輸入新密碼" onblur="dataCheck(this)">
					</div>
				</div>
				<div class="formFather">
					<div class="leftForm"></div>
					<div class="rightForm">
						<div id="password2Alert"></div>
					</div>
				</div>
				<div class="formFather">
					<button onclick="passwordChange()">確定</button>
					<button onclick="closepopup()">取消</button>
				</div>
			</div>
			
			<div id="userDelete">
				<div class="formFather">
					<div class="leftForm">請輸入密碼：</div>
					<div class="rightForm">
						<input id="pwd" name="pwd" type="password">
					</div>
				</div>
				<div class="formFather">
					<button onclick="userDelete()">確定</button>
					<button onclick="closepopup()">取消</button>
				</div>
			</div>
			
			<div class="formFather">
				<div class="leftForm">歡迎</div>
				<div class="rightForm" id="nameShow"></div>
			</div>
			<div class="formFather">
				<div class="leftForm">電子信箱：</div>
				<div class="rightForm" id="emailShow"></div>
			</div>
			<div class="formFather">
				<div class="leftForm">手機號碼：</div>
				<div class="rightForm" id="phoneShow"></div>
			</div>
		</div>
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
								alertAPI(obj.message, "alertFailure");
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
							closepopup();
						} else {
							alertAPI(obj.message, "alertFailure");
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
							closepopup();
						} else {
							alertAPI(obj.message, "alertFailure");
						}
					}
				});
			}
			
			function popupUserChange() {
				$("#mask").show();
				$("#userChange").show();
			}
			
			function popupPasswordChange() {
				$("#mask").show();
				$("#passwordChange").show();
			}
			
			function popupUserDelete() {
				$("#mask").show();
				$("#userDelete").show();
			}
			
			function closepopup() {
				$("#oldPassword").val("");
				$("#password").val("");
				$("#password2").val("");
				$("#pwd").val("");
				$("#emailAlert").html("");
				$("#phoneAlert").html("");
				$("#odlPasswordAlert").html("");
				$("#passwordAlert").html("");
				$("#password2Alert").html("");
				
				$("#mask").hide();
				$("#userChange").hide();
				$("#passwordChange").hide();
				$("#userDelete").hide();
			}
		</script>
	</body>
</html>