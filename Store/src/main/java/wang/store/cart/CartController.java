package wang.store.cart;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

@Controller("cartController")
public class CartController {
	
	@Resource(name = "cartServiceImplement")
	private CartServiceInterface cartService;
	
	/**
	 * 顯示購物車頁面
	 * @return 購物車頁面
	 */
	@RequestMapping("/cartPage.do")
	public String cartPage() {
		return "cart";
	}
	
	/**
	 * 顯示購物車中的商品列表
	 * @param session 會員id儲存位置
	 * @return 沒有商品返回提示字樣，有商品返回商品列表
	 */
	@RequestMapping("/cartList.do")
	@ResponseBody
	public ResponseResult<List<Cart>> cartList(HttpSession session) {
		List<Cart> carts = cartService.findCartByUserId((Integer)session.getAttribute("userId"));
		if (carts.isEmpty()) {
			return new ResponseResult<List<Cart>>(0, "空空如也，趕快去購物吧");
		}
		return new ResponseResult<List<Cart>>(1, carts);
	}
	
	/**
	 * 將商品加入購物車，如果已經存在該種商品，則增加數量
	 * @param productId 商品id
	 * @param amount 商品數量
	 * @param productPrice 商品價格
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "/cartAdd.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> cartAdd(Integer productId, Integer amount, Integer productPrice,HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		Integer total = productPrice * amount;
		Cart cart = cartService.findCartByUserIdAndProductId(userId, productId);
		if (cart == null) {
			cart = new Cart();
			cart.setUserId(userId);
			cart.setProductId(productId);
			cart.setAmount(amount);
			cart.setTotal(total);
			Integer result = cartService.insert(cart);
			if (result == 0) {
				return new ResponseResult<Void>(0, "加入購物車失敗");
			}
			return new ResponseResult<Void>(1, "已將商品加入購物車");
		}
		
		Integer result = cartService.cartUpdate(userId, productId, cart.getAmount()+amount, cart.getTotal()+total);
		if (result == 0) {
			return new ResponseResult<Void>(0, "加入購物車失敗");
		}
		return new ResponseResult<Void>(1, "已將商品加入購物車");
	}
	
	/**
	 * 將商品從購物車中刪除
	 * @param id 商品id
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/cartDelete.do")
	@ResponseBody
	public ResponseResult<Void> cartDelete(Integer id) {
		Integer result = cartService.cartDelete(id);
		if (result == 0) {
			return new ResponseResult<Void>(0, "刪除失敗");
		}
		return new ResponseResult<Void>(1, "刪除成功");
	}
}
