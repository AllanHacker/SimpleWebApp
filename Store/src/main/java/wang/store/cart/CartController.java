package wang.store.cart;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

@Controller("cartController")
public class CartController {
	
	@Resource(name = "cartServiceImplement")
	private CartServiceInterface cartService;
	
	/**
	 * 顯示購物車頁面，並將該會員放入的商品皆顯示出來
	 * @param session 會員id儲存位置
	 * @param modelMap 購物車封裝位置
	 * @return 購物車頁面
	 */
	@RequestMapping("/cartPage.do")
	public String cartPage() {
		return "cart";
	}
	
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
	 * 將商品加入購物車
	 * @param productId 商品id
	 * @param productName 商品名稱
	 * @param productCategoryId 商品分類
	 * @param productPrice 商品價格
	 * @param productNumber 商品數量
	 * @param productImage 商品圖片
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "/cartAdd.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> cartAdd(Integer productId, String productName, 
			Integer productCategoryId, Integer productPrice, 
			Integer productNumber, String productImage, HttpSession session) {
		
		Cart cart = new Cart();
		cart.setProductId(productId);
		cart.setProductName(productName);
		cart.setProductCategoryId(productCategoryId);
		cart.setProductPrice(productPrice);
		cart.setProductNumber(productNumber);
		cart.setProductImage(productImage);
		cart.setUserId((Integer)session.getAttribute("userId"));
		Integer result = cartService.insert(cart);
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
