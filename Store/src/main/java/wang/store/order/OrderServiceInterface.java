package wang.store.order;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import wang.store.order.orderinformation.OrderInformation;
import wang.store.order.orderproduct.OrderProduct;

public interface OrderServiceInterface {
	
	/**
	 * 新增訂單資料，同時寫入兩張表
	 * @param total 訂單金額
	 * @param recipientId 收件人id
	 * @param productId 商品id
	 * @param productNumber 商品數量
	 * @param userId 訂購會員的id
	 * @return 受影響的行數
	 */
	Integer orderAdd(Integer total, Integer recipientId, Integer[] productId, Integer[] productNumber, Integer userId);
	
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
	
	/**
	 * 修改訂單的狀態
	 * @param id 訂單id
	 * @param userId 會員id
	 * @param state 訂單的狀態
	 * @return 受影響的行數
	 */
	Integer orderStateChange(@Param("id")Integer id, @Param("userId")Integer userId, @Param("state")Integer state);
}
