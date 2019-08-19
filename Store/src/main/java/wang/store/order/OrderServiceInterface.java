package wang.store.order;

public interface OrderServiceInterface {
	
	/**
	 * 新增訂單資料
	 * @param orderInformation 訂單資料
	 * @return 新訂單
	 */
	Integer insertOrderInformation(OrderInformation orderInformation);
	
	/**
	 * 新增訂單的商品資料
	 * @param orderProduct 訂單的商品資料
	 * @return 受影響的行數
	 */
	Integer insertOrderProduct(OrderProduct orderProduct);
}
