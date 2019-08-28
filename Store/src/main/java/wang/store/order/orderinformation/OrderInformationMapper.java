package wang.store.order.orderinformation;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface OrderInformationMapper {
	
	/**
	 * 新增訂單資料
	 * @param orderInformation 訂單資料
	 * @return 新訂單
	 */
	Integer insert(OrderInformation orderInformation);
	
	/**
	 * 以會員id查詢訂單資料，並以時間排序
	 * @param userId 會員id
	 * @return 訂單資料
	 */
	List<OrderInformation> selectByUserId(Integer userId);
	
	/**
	 * 以會員id和訂單id查詢訂單資料
	 * @param userId 會員id
	 * @param id 訂單id
	 * @return 訂單資料
	 */
	OrderInformation selectByUserIdAndId(@Param("userId")Integer userId, @Param("id")Integer id);
	
	/**
	 * 修改訂單的狀態
	 * @param id 訂單id
	 * @param userId 會員id
	 * @param state 訂單的狀態
	 * @return 受影響的行數
	 */
	Integer update(@Param("id")Integer id, @Param("userId")Integer userId, @Param("state")Integer state);
}
