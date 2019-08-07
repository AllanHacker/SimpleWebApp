package wang.store.cart;

import java.util.List;

public interface CartServiceInterface {
	
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
	List<Cart> findCartByUserId(Integer userId);
}
