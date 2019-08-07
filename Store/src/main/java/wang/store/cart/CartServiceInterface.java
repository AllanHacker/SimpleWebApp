package wang.store.cart;

public interface CartServiceInterface {
	
	/**
	 * 新增購物車
	 * @param cart 購物車數據
	 * @return 受影響的行數
	 */
	Integer insert(Cart cart);
	
}
