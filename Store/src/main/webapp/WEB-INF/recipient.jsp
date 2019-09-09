<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Recipient</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="common.css" rel="stylesheet" />
		<link rel="shortcut icon" href="favicon.ico" />
	</head>
	<body>
		<div id="mask"></div>
		<c:import url="header.jsp"></c:import>
		<header class="p-5 text-center bg-light"><h2 class="font-weight-light">Recipient</h2></header>
		<main class="bg-light pb-5">
			<div class="container text-center">
				<button class="btn btn-outline-secondary btn-sm mb-3" onclick="popup(0)">新增收件人</button>
				<div id="recipientList"></div>
			</div>
			
			<div class="modal fade" id="recipientForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">新增收件人</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form class="text-center">
								<input id="recipientName" type="text" placeholder="姓名" class="form-control mb-2" required>
								<input id="recipientPhone" type="text" placeholder="手機" class="form-control mb-2" required>
								<input id="postalCode" type="text" placeholder="郵遞區號(自動查詢)" class="form-control-plaintext mb-2" required readonly>
								<select id="city" onchange="districtOption()" class="form-control mb-2"></select>
								<select id="district" onchange="roadOption()" class="form-control mb-2"></select>
								<select id="road" onchange="postalCodeFind()" class="form-control mb-2"></select>
								<input id="other" type="text" placeholder="巷弄號樓" class="form-control mb-4" required>
								<input id="recipientId" type="hidden">
							</form>
						</div>
						<div class="modal-footer">
							<button class="btn btn-outline-secondary btn-sm" onclick="recipientSubmit()">確定</button>
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
				recipientList();
			});
			
			function recipientList() {
				$("#recipientList").empty();
				var template = 
					'<div class="row border border-secondary mb-1">' +
						'<div class="col p-3 text-left">' +
							'<p>姓名：%RECIPIENT_NAME%</p>' +
							'<p>手機：%RECIPIENT_PHONE%</p>' +
							'<p>地址：%RECIPIENT_ADDRESS%</p>' +
						'</div>' +
						'<div class="col-3 align-self-center">' +
							'<button class="btn btn-outline-secondary btn-sm mr-1" onclick="recipientDefault(%ID%)">預設</button>' +
							'<button class="btn btn-outline-secondary btn-sm mr-1" onclick="popup(%ID%)">修改</button>' +
							'<button class="btn btn-outline-secondary btn-sm" onclick="recipientDelete(%ID%)">刪除</button>' +
						'</div>' +
					'</div>';
				
				$.ajax({
					url: "recipientList.do",
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 0) {
							$("main").attr("style", "height: 70vh;");
							$("#recipientList").append("<div>" + obj.message + "</div>");
						} else {
							$("main").removeAttr("style");
							var htmlString = "";
							for (var i = 0; i < obj.data.length; i++) {
								htmlString += template;
								var recipient = obj.data[i];
								var address = recipient.postalCode + recipient.city + recipient.district + recipient.road + recipient.other;
								htmlString = htmlString.replace("%RECIPIENT_NAME%", recipient.recipientName);
								htmlString = htmlString.replace("%RECIPIENT_PHONE%", recipient.recipientPhone);
								htmlString = htmlString.replace("%RECIPIENT_ADDRESS%", address);
								htmlString = htmlString.replace(/%ID%/g, recipient.id);
							}
							$("#recipientList").html(htmlString);
							$("#recipientList div:first").attr("class", "row border border-info mb-1");
							$("#recipientList div:first").css("background-color", "#E0FFFF");
							$("#recipientList div:first div button:first").attr("disabled", "disabled");
						}
					}
				});
			}
			
			function popup(id) {
				$('.modal').modal('show');
				$("#recipientId").val(id);
				$("#recipientName").val("");
				$("#recipientPhone").val("");
				if (id == 0) {
					cityOption();
					$("#city").append("<option disabled selected hidden>---縣&nbsp;&nbsp;&nbsp;&nbsp;市---</option>");
					$("#district").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				} else {
					cityOption();
					$.ajax({
						url: "recipientLoad.do",
						data: "id=" + id,
						type: "get",
						dataType: "json",
						success: function(obj){
							var recipient = obj.data;
							$("#recipientName").val(recipient.recipientName);
							$("#recipientPhone").val(recipient.recipientPhone);
							$("#city option:contains(" + recipient.city + ")").attr("selected", true);
							districtOption(recipient.city);
							$("#district option:contains(" + recipient.district + ")").attr("selected", true);
							roadOption(recipient.city, recipient.district);
							$("#road option:contains(" + recipient.road + ")").attr("selected", true);
							$("#postalCode").val(recipient.postalCode);
							$("#other").val(recipient.other);
						}
					});
				}
			}
			
			function cityOption() {
				$("#postalCode").val("");
				$("#city").empty();
				$("#district").empty();
				$("#road").empty();
				$("#other").val("");
				$.ajax({
					url: "cityOption.do",
					type: "get",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var city = obj.data[i];
							$("#city").append("<option>" + city + "</option>");
						}
					}
				});
			}
			
			function districtOption(city) {
				$("#postalCode").val("");
				$("#district").empty();
				$("#road").empty();
				if (city === undefined) {
					city = $("#city option:selected").val();
					$("#district").append("<option disabled selected hidden>---鄉鎮區---</option>");
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
				}
				$.ajax({
					url: "districtOption.do",
					data: "city=" + city,
					type: "post",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var district = obj.data[i];
							$("#district").append("<option>" + district + "</option>");
						}
					}
				});
			}
			
			function roadOption(city, district) {
				$("#postalCode").val("");
				$("#road").empty();
				if (city === undefined || district === undefined) {
					$("#road").append("<option disabled selected hidden>---路&nbsp;&nbsp;&nbsp;&nbsp;名---</option>");
					city = $("#city option:selected").val();
					district = $("#district option:selected").val();
				}
				$.ajax({
					url: "roadOption.do",
					data: "city=" + city + 
						  "&district=" + district,
					type: "post",
					dataType: "json",
					async: false,
					success: function(obj){
						for (var i = 0; i < obj.data.length; i++) {
							var road = obj.data[i];
							$("#road").append("<option>" + road + "</option>");
						}
					}
				});
			}
			
			function postalCodeFind(){
				$.ajax({
					url: "postalCode.do",
					data: "city=" + $("#city option:selected").val() + 
						  "&district=" + $("#district option:selected").val() + 
						  "&road=" + $("#road option:selected").val(),
					type: "post",
					dataType: "json",
					success: function(obj){
						$("#postalCode").val(obj.data);
					}
				});
			}
			
			function recipientSubmit() {
				var id = $("#recipientId").val();
				if (id == 0) {
					var url = "recipientAdd.do"
				} else {
					var url = "recipientChange.do"
				}
				$.ajax({
					url: url,
					data:"recipientName=" + $("#recipientName").val() +
						 "&recipientPhone=" + $("#recipientPhone").val() +
						 "&postalCode=" + $("#postalCode").val() + 
						 "&city=" + $("#city option:selected").text() + 
						 "&district=" + $("#district option:selected").text() + 
						 "&road=" + $("#road option:selected").text() + 
						 "&other=" + $("#other").val() +
						 "&id=" + id,
					type: "post",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
							if (id == 0) {
								popup(0);
							} else {
								$('.modal').modal('hide');
							}
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			function recipientDelete(id) {
				$.ajax({
					url: "recipientDelete.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
			
			function recipientDefault(id) {
				$.ajax({
					url: "recipientDefault.do",
					data: "id=" + id,
					type: "get",
					dataType: "json",
					success: function(obj){
						if (obj.state == 1) {
							alertAPI(obj.message);
							recipientList();
						} else {
							alertAPI(obj.message, "alert-danger");
						}
					}
				});
			}
		</script>
	</body>
</html>