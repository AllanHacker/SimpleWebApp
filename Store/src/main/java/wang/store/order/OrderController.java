package wang.store.order;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

@Controller("orderController")
public class OrderController {
	
	@Resource(name = "orderServiceImplement")
	private OrderServiceInterface orderService;
	
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
	
	/**
	 * 創建訂單
	 * @param total 訂單金額
	 * @param recipientId 收件人
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/orderAdd.do")
	@ResponseBody
	public ResponseResult<Integer> orderAdd(Integer total, Integer recipientId, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		OrderInformation orderInformation = new OrderInformation();
		orderInformation.setTotal(total);
		orderInformation.setUserId(userId);
		orderInformation.setRecipientId(recipientId);
		Integer result = orderService.insert(orderInformation);
		if (result == 1) {
			return new ResponseResult<Integer>(1, "訂單成立", orderInformation.getId());
		}
		return new ResponseResult<Integer>(0, "訂單出錯");
	}
}
