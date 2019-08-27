package wang.store.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import wang.store.common.ResponseResult;

@Controller("productController")
public class ProductController {
	
	@Resource(name = "productServiceImplement")
	private ProductServiceInterface productService;
	
	private String path = "C:\\Users\\TEDU.TW\\Downloads\\img\\";
	//private String path = "//home//bxunwang//img//";
	
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
	
	/**
	 * 以商品id查詢商品後，顯示商品修改頁面及商品資料
	 * @param id 商品id
	 * @param modelMap 商品封裝的位置
	 * @return 商品修改頁面
	 */
	@RequestMapping("/productEditPage.do")
	public String productEditPage(Integer id, ModelMap modelMap) {
		Product product = productService.findProductById(id);
		modelMap.addAttribute("product", product);
		return "productEdit";
	}
	
	/**
	 * 以商品id查詢商品
	 * @param id 商品id
	 * @return 所查詢的商品
	 */
	@RequestMapping("/productLoad.do")
	@ResponseBody
	public ResponseResult<Product> productLoad(Integer id) {
		Product product = productService.findProductById(id);
		return new ResponseResult<Product>(1, product);
	}
	
	/**
	 * 商品修改功能。根據id查詢出該商品，並以新的資料重新對屬性賦值。
	 * @param id 商品id
	 * @param productName 新的商品名稱
	 * @param categoryId 新的商品分類
	 * @param price 新的商品價格
	 * @param number 新的商品數量
	 * @param file 新的圖片檔案
	 * @param state 新的狀態，上架或下架
	 * @return 成功返回1，失敗返回0
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value = "/productEdit.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> productEdit(Integer id, String productName, String categoryId, String price, String number, MultipartFile file, Integer state) throws IllegalStateException, IOException {
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
		if (flag == false) {
			return responseResult = new ResponseResult<Void>(0, "商品資料有誤");
		}
		Product product = productService.findProductById(id);
		product.setName(productName);
		product.setCategoryId(Integer.valueOf(categoryId));
		product.setPrice(Integer.valueOf(price));
		product.setNumber(Integer.valueOf(number));
		
		if (!file.isEmpty()) {
			if (!file.getOriginalFilename().endsWith(".png")) {
				return responseResult = new ResponseResult<Void>(0, "圖片檔案有誤");
			}
			//若有選擇新圖片，且格式正確，刪除舊圖片
			String path = this.path + product.getImage();
			new File(path).delete();
			//上傳新圖片
			String fileName = UUID.randomUUID().toString() + ".png";
			product.setImage(fileName);
			path = this.path + fileName;
			file.transferTo(new File(path));
		}
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
	 * @return 商品列表，若查無返回提示字樣
	 */
	@RequestMapping("/productListShow.do")
	@ResponseBody
	public ResponseResult<List<Product>> productListShow(Integer categoryId) {
		List<Product> products = productService.findProductByCategoryId(categoryId);
		if (products.size() == 0) {
			return new ResponseResult<List<Product>>(0, "此分類暫無商品", products);
		}
		return new ResponseResult<List<Product>>(1, products);
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
		if ("".equals(categoryId)) {
			return new ResponseResult<Void>(0, "請選擇分類");
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
		if (file.isEmpty()) {
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
	 * @param file 圖片檔案
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/productPost.do")
	@ResponseBody
	public ResponseResult<Void> productPost(String productName, String categoryId, String price, String number, MultipartFile file, HttpSession session) throws IllegalStateException, IOException {
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
		String path = this.path + fileName;
		file.transferTo(new File(path));
		product.setUserId((Integer)session.getAttribute("userId"));
		productService.productPost(product);
		return responseResult = new ResponseResult<Void>(1, "商品新增成功");
	}
	
	/**
	 * 商品刪除功能。根據商品id將指定的商品刪除
	 * @param id 商品id
	 * @return 提示字樣
	 */
	@RequestMapping("/productDelete.do")
	@ResponseBody
	public ResponseResult<Void> productDelete(Integer id) {
		Product product = productService.findProductById(id);
		String path = this.path + product.getImage();
		new File(path).delete();
		Integer result = productService.productDelete(id);
		return new ResponseResult<Void>(result, "您的商品已刪除");
	}
}
