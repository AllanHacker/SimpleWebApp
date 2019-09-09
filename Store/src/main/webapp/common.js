/*
 * 於螢幕中間彈出alert視窗，1.2秒後移除。
 * message: 彈跳視窗中顯示的內容。
 * style  : 彈跳視窗的樣式，預設為alert-success。bootstrap可設置8種不同的樣式。
 */
function alertAPI(message, style) {
	style = (style === undefined) ? 'alert-success' : style;
	$('<div class="alert alertAPI fade show" role="alert">').appendTo('body').addClass(style).html(message);
	setTimeout(function() {$('.alert:first').alert('close');}, 1200);
};

/*
 * 檢查是否已經登入
 * 已登入: 顯示警告
 * 未登入: 跳轉至登入頁面
 */
$("#loginCheck").click(function(){
	$.ajax({
		url: "loginCheck.do",
		type: "get",
		dataType: "json",
		success: function(obj) {
			if (obj.state == 1) {
				location.href = "loginPage.do";
			} 
			alertAPI(obj.message, "alert-danger");
		}
	});
});
