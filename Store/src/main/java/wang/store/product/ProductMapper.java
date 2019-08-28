package wang.store.product;

import java.util.List;

public interface ProductMapper {
	
	/**
	 * 根據商品分類id找出該類的所有商品
	 * @param categoryId 商品分類id
	 * @return 某商品分類id中的所有商品
	 */
	List<Product> selectByCategoryId(Integer categoryId);
	
	/**
	 * 根據會員id找出他所刊登的所有商品
	 * @param userId 會員id
	 * @return 該會員所刊登的所有商品
	 */
	List<Product> selectByUserId(Integer userId);
	
	/**
	 * 根據商品id找出對應的商品
	 * @param id 商品id
	 * @return 對應的商品
	 */
	Product selectById(Integer id);
	
	/**
	 * 新增商品
	 * @param product 商品資料封裝的實體類
	 * @return 受影響的行數
	 */
	Integer insert(Product product);
	
	/**
	 * 刪除某個商品
	 * @param id 商品id
	 * @return 受影響的行數
	 */
	Integer delete(Integer id);
	
	/**
	 * 修改某個商品
	 * @param product 新的商品資料
	 * @return 受影響的行數
	 */
	Integer update(Product product);
}
