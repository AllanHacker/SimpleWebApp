package wang.store.service;

import java.util.List;

import wang.store.bean.Product_category;

public interface ProductServiceInterface {
	
	/**
	 * 找出同階層的商品目錄
	 * @param parentId 目錄的父級id
	 * @return 同階層的商品目錄
	 */
	List<Product_category> findCategoryByParentId(Integer parentId);
}
