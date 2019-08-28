package wang.store.order.orderproduct;

import java.util.List;

public interface OrderProductMapper {
	
	/**
	 * 新增訂單的商品資料
	 * @param orderProduct 訂單的商品資料
	 * @return 受影響的行數
	 */
	Integer insert(OrderProduct orderProduct);
	
	/**
	 * 以訂單id查詢訂單的商品資料
	 * @param orderId 訂單id
	 * @return 訂單的商品資料
	 */
	List<OrderProduct> selectById(Integer orderId);
	
}
