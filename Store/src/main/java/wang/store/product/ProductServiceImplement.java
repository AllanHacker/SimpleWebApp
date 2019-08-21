package wang.store.product;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
	
	public List<Product> findProductByUserId(Integer userId) {
		return productMapper.findProductByUserId(userId);
	}

	public Product findProductById(Integer id) {
		Product product = productMapper.findProductById(id);
		return product;
	}

	public Integer productPost(Product product) {
		Integer result = productMapper.insertProduct(product);
		return result;
	}

	public Integer productDelete(Integer id) {
		Integer result = productMapper.productDelete(id);
		return result;
	}

	public Integer productUpdate(Product product) {
		Integer result = productMapper.productUpdate(product);
		return result;
	}

}
