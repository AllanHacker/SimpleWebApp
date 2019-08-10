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