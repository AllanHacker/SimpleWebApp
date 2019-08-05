package wang.store.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
	 * @param image 商品圖片位址
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "imageCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> imageCheck(String image) {
		String regex = "\\w{1,30}";
		if (!image.matches(regex)) {
			return new ResponseResult<Void>(0, "error");
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
	public ResponseResult<Void> productPost(String productName, String categoryId, String price, String number, String image, MultipartFile file, HttpServletRequest request) throws IllegalStateException, IOException {
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
		responseResult = imageCheck(image);
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
		image = "/img/" + image + ".png";
		product.setImage(image);
		productService.productPost(product);
		
		//上傳圖片
		image = request.getServletContext().getRealPath(image);
		file.transferTo(new File(image));
		return responseResult = new ResponseResult<Void>(1, "商品新增成功");
	}
	
}
