package wang.store.order;

import java.util.List;

public interface OrderMapper {
	
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
	
	/**
	 * 以會員id查詢訂單資料，並以時間排序
	 * @param userId 會員id
	 * @return 訂單資料
	 */
	List<OrderInformation> orderInformationsFindByUserId(Integer userId);
}
