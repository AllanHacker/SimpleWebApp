package wang.store.cart;

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

}
