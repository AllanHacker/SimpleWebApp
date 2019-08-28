package wang.store.product;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("productServiceImplement")
public class ProductServiceImplement implements ProductServiceInterface{
	
	@Resource(name = "productMapper")
	ProductMapper productMapper;

	public List<Product> findByCategoryId(Integer categoryId) {
		List<Product> product = productMapper.selectByCategoryId(categoryId);
		return product;
	}
	
	public List<Product> findByUserId(Integer userId) {
		return productMapper.selectByUserId(userId);
	}

	public Product findById(Integer id) {
		Product product = productMapper.selectById(id);
		return product;
	}

	public Integer add(Product product) {
		Integer result = productMapper.insert(product);
		return result;
	}

	public Integer delete(Integer id) {
		Integer result = productMapper.delete(id);
		return result;
	}

	public Integer change(Product product) {
		Integer result = productMapper.update(product);
		return result;
	}

}
