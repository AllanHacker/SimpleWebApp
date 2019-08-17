package wang.store.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("orderController")
public class OrderController {
	
	/**
	 * 顯示我的訂單頁面
	 * @return 我的訂單頁面
	 */
	@RequestMapping("/orderPage.do")
	public String orderPage() {
		return "order";
	}
	
	/**
	 * 顯示訂單內容頁面
	 * @return 訂單內容頁面
	 */
	@RequestMapping("/orderDetailPage.do")
	public String orderDetailPage() {
		return "orderDetail";
	}
}
