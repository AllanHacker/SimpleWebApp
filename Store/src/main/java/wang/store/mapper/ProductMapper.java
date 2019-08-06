package wang.store.mapper;

import java.util.List;

import wang.store.bean.Product;
import wang.store.bean.Product_category;

public interface ProductMapper {
	
	/**
	 * 找出同階層的商品目錄
	 * @param parentId 目錄的父級id
	 * @return 同階層的商品目錄
	 */
	List<Product_category> findCategoryByParentId(Integer parentId);
	
	/**
	 * 根據商品分類id找出該類的所有商品
	 * @param categoryId 商品分類id
	 * @return 某商品分類id中的所有商品
	 */
	List<Product> findProductByCategoryId(Integer categoryId);
	
	/**
	 * 根據會員id找出他所刊登的所有商品
	 * @param userId 會員id
	 * @return 該會員所刊登的所有商品
	 */
	List<Product> findProductByUserId(Integer userId);
	
	/**
	 * 根據商品id找出對應的商品
	 * @param id 商品id
	 * @return 對應的商品
	 */
	Product findProductById(Integer id);
	
	/**
	 * 新增商品
	 * @param product 商品資料封裝的實體類
	 * @return 受影響的行數
	 */
	Integer insertProduct(Product product);
	
	/**
	 * 刪除商品
	 * @param id 商品id
	 * @return 受影響的行數
	 */
	Integer productDelete(Integer id);
}
