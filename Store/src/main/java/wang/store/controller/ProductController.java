package wang.store.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import wang.store.bean.Product;
import wang.store.bean.Product_category;
import wang.store.bean.ResponseResult;
import wang.store.service.ProductServiceInterface;

@Controller("productController")
public class ProductController {
	
	@Resource(name = "productServiceImplement")
	private ProductServiceInterface productService;
	
	/**
	 * 顯示拍賣頁面
	 * @return 拍賣頁面
	 */
	@RequestMapping("/sellPage.do")
	public String sellPage() {
		return "sell";
	}
	
	/**
	 * 顯示商場頁面，並將該會員所刊登的商品都顯示出來
	 * @param session 會員id儲存的位置
	 * @param modelMap 商品封裝的位置
	 * @return 商場頁面
	 */
	@RequestMapping("/mallPage.do")
	public String mallPage(HttpSession session, ModelMap modelMap) {
		Integer userId = (Integer) session.getAttribute("userId");
		List<Product> products = productService.findProductByUserId(userId);
		modelMap.addAttribute("products", products);
		return "mall";
	}
	
	@RequestMapping("/productEditPage.do")
	public String productEditPage(Integer id, ModelMap modelMap) {
		Product product = productService.findProductById(id);
		modelMap.addAttribute("product", product);
		return "productEdit";
	}
	
	@RequestMapping("/productEdit.do")
	@ResponseBody
	public ResponseResult<Void> productEdit(Integer id, String productName, String categoryId, String price, String number, String image, MultipartFile file, Integer state, HttpServletRequest request, HttpSession session) {
		ResponseResult<Void> responseResult;
		boolean flag = true;
		responseResult = productNameCheck(productName);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = categoryIdCheck(categoryId);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = priceCheck(price);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = numberCheck(number);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = fileCheck(file);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		if (flag == false) {
			return responseResult = new ResponseResult<Void>(0, "商品資料有誤");
		}
		Product product = new Product();
		product.setId(id);
		product.setName(productName);
		product.setCategoryId(Integer.valueOf(categoryId));
		product.setPrice(Integer.valueOf(price));
		product.setNumber(Integer.valueOf(number));
		product.setImage(image);
		product.setState(state);
		productService.productUpdate(product);
		
		return responseResult = new ResponseResult<Void>(1, "商品更新完成");
	}
	
	/**
	 * 顯示某個商品詳細資料的頁面
	 * @param id 該商品的id
	 * @param modelMap 商品詳細資料
	 * @return 商品詳細資料的頁面
	 */
	@RequestMapping("/productDetailPage.do")
	public String productDetailPage(Integer id, ModelMap modelMap) {
		Product product = productService.findProductById(id);
		modelMap.addAttribute("product", product);
		return "productDetail";
	}
	
	/**
	 * 顯示商品目錄列表
	 * @param parentId 父級分類id
	 * @return 商品目錄列表
	 */
	@RequestMapping("/categoryListShow.do")
	@ResponseBody
	public ResponseResult<List<Product_category>> categoryListShow(Integer parentId) {
		List<Product_category> category = productService.findCategoryByParentId(parentId);
		return new ResponseResult<List<Product_category>>(category);
	}
	
	/**
	 * 顯示某分類的所有商品
	 * @param categoryId 分類id
	 * @return 商品列表
	 */
	@RequestMapping("/productListShow.do")
	@ResponseBody
	public ResponseResult<List<Product>> productListShow(Integer categoryId) {
		List<Product> products = productService.findProductByCategoryId(categoryId);
		return new ResponseResult<List<Product>>(products);
	}
	
	/**
	 * 資料驗證
	 * @param productName 商品名稱
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "productNameCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> productNameCheck(String productName) {
		String regex = "[^`$^&*=|;,?><\\x22]+";
		if (!productName.matches(regex)) {
			return new ResponseResult<Void>(0, "error");
		} 
		return new ResponseResult<Void>(1, "ok");
	}
	
	/**
	 * 資料驗證
	 * @param categoryId 商品id
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "categoryIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> categoryIdCheck(String categoryId) {
		String regex = "\\+?[1-9][0-9]*";
		if (!categoryId.matches(regex)) {
			return new ResponseResult<Void>(0, "請填入至少為1的數");
		}
		return new ResponseResult<Void>(1, "ok");
	}
	
	/**
	 * 資料驗證
	 * @param price 商品價格
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "priceCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> priceCheck(String price) {
		String regex = "\\+?[1-9][0-9]*";
		if (!price.matches(regex)) {
			return new ResponseResult<Void>(0, "請填入至少為1的數");
		}
		return new ResponseResult<Void>(1, "ok");
	}
	
	/**
	 * 資料驗證
	 * @param number 商品數量
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "numberCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> numberCheck(String number) {
		String regex = "\\+?[1-9][0-9]*";
		if (!number.matches(regex)) {
			return new ResponseResult<Void>(0, "請填入至少為1的數");
		}
		return new ResponseResult<Void>(1, "ok");
	}
	
	/**
	 * 資料驗證
	 * @param file 所選擇要上傳的圖片檔案，限定png格式
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "fileCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> fileCheck(MultipartFile file) {
		if (file == null) {
			return new ResponseResult<Void>(0, "找不到檔案");
		}
		if (!file.getOriginalFilename().endsWith(".png")) {
			return new ResponseResult<Void>(0, "請選擇png檔");
		}
		return new ResponseResult<Void>(1, "ok");
	}
	
	/**
	 * 刊登新商品並上傳圖片，資料必須先驗證無誤後才能進行
	 * @param productName 商品名稱
	 * @param categoryId 商品id
	 * @param price 商品價格
	 * @param number 商品數量
	 * @param image 商品圖片路徑
	 * @param file 商品圖
	 * @param request 
	 * @return 成功返回1，失敗返回0
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/productPost.do")
	@ResponseBody
	public ResponseResult<Void> productPost(String productName, String categoryId, String price, String number, MultipartFile file, HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
		ResponseResult<Void> responseResult;
		boolean flag = true;
		responseResult = productNameCheck(productName);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = categoryIdCheck(categoryId);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = priceCheck(price);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = numberCheck(number);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = fileCheck(file);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		if (flag == false) {
			return responseResult = new ResponseResult<Void>(0, "商品資料有誤");
		}
		Product product = new Product();
		product.setName(productName);
		product.setCategoryId(Integer.valueOf(categoryId));
		product.setPrice(Integer.valueOf(price));
		product.setNumber(Integer.valueOf(number));
		String fileName = UUID.randomUUID().toString() + ".png";
		product.setImage(fileName);
		//上傳圖片
		//path = request.getServletContext().getRealPath(image);
		String path = "C:\\Users\\TEDU.TW\\Downloads\\img\\" + fileName;
		file.transferTo(new File(path));
		product.setUserId((Integer)session.getAttribute("userId"));
		productService.productPost(product);
		return responseResult = new ResponseResult<Void>(1, "商品新增成功");
	}
	
	@RequestMapping("/productDelete.do")
	@ResponseBody
	public ResponseResult<Void> productDelete(Integer id) {
		Integer result = productService.productDelete(id);
		return new ResponseResult<Void>(result, "您的商品已刪除");
	}
}
