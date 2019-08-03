package wang.store.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import wang.store.bean.Product;
import wang.store.bean.Product_category;
import wang.store.mapper.ProductMapper;

@Service("productServiceImplement")
public class ProductServiceImplement implements ProductServiceInterface{
	
	@Resource(name = "productMapper")
	ProductMapper productMapper;

	public List<Product_category> findCategoryByParentId(Integer parentId) {
		List<Product_category> category = productMapper.findCategoryByParentId(parentId);
		return category;
	}

	public List<Product> findProductByCategoryId(Integer categoryId) {
		List<Product> product = productMapper.findProductByCategoryId(categoryId);
		return product;
	}

}
