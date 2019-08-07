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
		List<Cart> carts = cartMapper.findCartByUserId(userId);
		return carts;
	}

}
