package wang.store.product;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("productServiceImplement")
public class ProductServiceImplement implements ProductServiceInterface{
	
	@Resource(name = "productMapper")
	ProductMapper productMapper;

	public List<Product> findProductByCategoryId(Integer categoryId) {
		List<Product> product = productMapper.selectByCategoryId(categoryId);
		return product;
	}
	
	public List<Product> findProductByUserId(Integer userId) {
		return productMapper.selectByUserId(userId);
	}

	public Product findProductById(Integer id) {
		Product product = productMapper.selectById(id);
		return product;
	}

	public Integer productPost(Product product) {
		Integer result = productMapper.insert(product);
		return result;
	}

	public Integer productDelete(Integer id) {
		Integer result = productMapper.delete(id);
		return result;
	}

	public Integer productUpdate(Product product) {
		Integer result = productMapper.update(product);
		return result;
	}

}
