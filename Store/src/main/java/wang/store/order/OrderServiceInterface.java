package wang.store.order;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	
	/**
	 * 以會員id查詢訂單資料，並以時間排序
	 * @param userId 會員id
	 * @return 訂單資料
	 */
	List<OrderInformation> orderInformationsFindByUserId(Integer userId);
	
	/**
	 * 以會員id和訂單id查詢訂單資料
	 * @param userId 會員id
	 * @param id 訂單id
	 * @return 訂單資料
	 */
	OrderInformation orderInformationFindByUserIdAndId(@Param("userId")Integer userId, @Param("id")Integer id);
	
	/**
	 * 以訂單id查詢訂單的商品資料
	 * @param orderId 訂單id
	 * @return 訂單的商品資料
	 */
	List<OrderProduct> orderProductFindById(Integer orderId);
}
