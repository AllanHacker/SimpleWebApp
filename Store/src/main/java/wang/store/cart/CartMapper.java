package wang.store.cart;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface CartMapper {
	
	/**
	 * 新增購物車
	 * @param cart 購物車數據
	 * @return 受影響的行數
	 */
	Integer insert(Cart cart);
	
	/**
	 * 以會員id查詢購物車
	 * @param userId 會員id
	 * @return 購物車列表
	 */
	List<Cart> selectByUserId(Integer userId);
	
	/**
	 * 以會員id及商品id查詢購物車
	 * @param userId 會員id
	 * @param productId 商品id
	 * @return 購物車
	 */
	Cart selectByUserIdAndProductId(@Param("userId")Integer userId, @Param("productId")Integer productId);
	
	/**
	 * 刪除購物車
	 * @param id 購物車id
	 * @return 受影響的行數
	 */
	Integer delete(Integer id);
	
	/**
	 * 修改購物車
	 * @param id 購物車id
	 * @param amount 購物車商品總額
	 * @param total 購物車商品總數
	 * @return 受影響的行數
	 */
	Integer update(@Param("userId")Integer userId, @Param("productId")Integer productId, @Param("amount")Integer amount, @Param("total")Integer total);
}
