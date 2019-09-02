/*
 * 彈跳視窗的函式
 * 
 * 有三個參數 : 訊息、樣式、時間。需搭配alertAPI.css
 * 
 * message: 彈跳視窗中顯示的內容。
 * style  : 彈跳視窗的顏色，有綠色alertSuccess、紅色alertFailure、藍色alertInfo。若不設置預設為綠色。
 * time   : 彈跳視窗停留時間，若不設置預設為1.2秒。
 * 
 */
var alertAPI = function (message, style, time) {
	style = (style === undefined) ? 'alertSuccess' : style;
	time = (time === undefined) ? 1200 : time;
		$('<div>')
		.appendTo('body')
		.addClass('alertAPI ' + style)
		.html(message)
		.show()
		.delay(time)
		.fadeOut();
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
			alertAPI(obj.message, "alertFailure");
		}
	});
});
