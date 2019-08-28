package wang.store.cart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("cartServiceImplement")
public class CartServiceImplement implements CartServiceInterface{
	
	@Resource(name = "cartMapper")
	CartMapper cartMapper;
	
	public Integer add(Cart cart) {
		Integer result = cartMapper.insert(cart);
		return result;
	}
	
	public List<Cart> findByUserId(Integer userId) {
		List<Cart> carts = cartMapper.selectByUserId(userId);
		return carts;
	}
	
	public Cart findByUserIdAndProductId(Integer userId, Integer productId) {
		Cart cart = cartMapper.selectByUserIdAndProductId(userId, productId);
		return cart;
	}

	public Integer delete(Integer id) {
		Integer result = cartMapper.delete(id);
		return result;
	}

	public Integer change(Integer userId, Integer productId, Integer amount, Integer total) {
		Integer result = cartMapper.update(userId, productId, amount, total);
		return result;
	}

}
