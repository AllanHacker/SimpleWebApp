package wang.store.cart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("cartServiceImplement")
public class CartServiceImplement implements CartServiceInterface{
	
	@Resource(name = "cartMapper")
	CartMapper cartMapper;
	
	public Integer insert(Cart cart) {
		Integer result = cartMapper.insert(cart);
		return result;
	}
	
	public List<Cart> findCartByUserId(Integer userId) {
		List<Cart> carts = cartMapper.selectByUserId(userId);
		return carts;
	}
	
	public Cart findCartByUserIdAndProductId(Integer userId, Integer productId) {
		Cart cart = cartMapper.selectByUserIdAndProductId(userId, productId);
		return cart;
	}

	public Integer cartDelete(Integer id) {
		Integer result = cartMapper.delete(id);
		return result;
	}

	public Integer cartUpdate(Integer userId, Integer productId, Integer amount, Integer total) {
		Integer result = cartMapper.update(userId, productId, amount, total);
		return result;
	}

}
