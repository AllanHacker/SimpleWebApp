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
	public ResponseResult categoryListShow(Integer parentId) {
		List<Product_category> category = productService.findCategoryByParentId(parentId);
		ResponseResult responseResult = new ResponseResult(category);
		return responseResult;
	}
	
	/**
	 * 顯示某分類的所有商品
	 * @param categoryId 分類id
	 * @return 商品列表
	 */
	@RequestMapping("/productListShow.do")
	@ResponseBody
	public ResponseResult productListShow(Integer categoryId) {
		List<Product> products = productService.findProductByCategoryId(categoryId);
		ResponseResult responseResult = new ResponseResult(products);
		return responseResult;
	}
	
	/**
	 * 資料驗證
	 * @param productName 商品名稱
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "productNameCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult productNameCheck(String productName) {
		ResponseResult responseResult;
		if ("".equals(productName)) {
			return responseResult = new ResponseResult(0, "欄位空缺!");
		}
		return responseResult = new ResponseResult(1, "OK");
	}
	
	/**
	 * 資料驗證
	 * @param categoryId 商品id
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "categoryIdCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult categoryIdCheck(String categoryId) {
		ResponseResult responseResult;
		if (categoryId == null) {
			return responseResult = new ResponseResult(0, "欄位空缺!");
		}
		Integer in;
		try {
			in = Integer.valueOf(categoryId);
		} catch (NumberFormatException e) {
			return responseResult = new ResponseResult(0, "請填入數字");
		}
		if (in < 1) {
			return responseResult = new ResponseResult(0, "至少是1");
		}
		return responseResult = new ResponseResult(1, "OK");
	}
	
	/**
	 * 資料驗證
	 * @param price 商品價格
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "priceCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult priceCheck(String price) {
		ResponseResult responseResult;
		if (price == null) {
			return responseResult = new ResponseResult(0, "欄位空缺!");
		}
		Integer in;
		try {
			in = Integer.valueOf(price);
		} catch (NumberFormatException e) {
			return responseResult = new ResponseResult(0, "請填入數字");
		}
		if (in < 1) {
			return responseResult = new ResponseResult(0, "至少是1");
		}
		return responseResult = new ResponseResult(1, "OK");
	}
	
	/**
	 * 資料驗證
	 * @param number 商品數量
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "numberCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult numberCheck(String number) {
		ResponseResult responseResult;
		if (number == null) {
			return responseResult = new ResponseResult(0, "欄位空缺!");
		}
		Integer in;
		try {
			in = Integer.valueOf(number);
		} catch (NumberFormatException e) {
			return responseResult = new ResponseResult(0, "請填入數字");
		}
		if (in < 1) {
			return responseResult = new ResponseResult(0, "至少是1");
		}
		return responseResult = new ResponseResult(1, "OK");
	}
	
	/**
	 * 資料驗證
	 * @param image 商品圖片位址
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "imageCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult imageCheck(String image) {
		ResponseResult responseResult;
		if ("".equals(image)) {
			return responseResult = new ResponseResult(0, "欄位空缺!");
		}
		String regex = "\\w{1,30}";
		if (image.matches(regex)) {
			return responseResult = new ResponseResult(1, "OK");
		} else {
			return responseResult = new ResponseResult(0, "格式錯誤");
		}
	}
	
	/**
	 * 刊登新商品，資料驗證無誤才能提交
	 * @param productName 商品名稱
	 * @param categoryId 商品分類
	 * @param price 商品價格
	 * @param number 商品數量
	 * @param image 商品圖片位置
	 * @return 成功
	 */
	@RequestMapping("/productPost.do")
	@ResponseBody
	public ResponseResult productPost(String productName, String categoryId, String price, String number, String image) {
		ResponseResult responseResult;
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
		if (flag) {
			Product product = new Product();
			product.setName(productName);
			product.setCategoryId(Integer.valueOf(categoryId));
			product.setPrice(Integer.valueOf(price));
			product.setNumber(Integer.valueOf(number));
			image = "/img/" + image + ".png";
			product.setImage(image);
			productService.productPost(product);
			return responseResult = new ResponseResult(1, "商品新增成功");
		}
		return responseResult = new ResponseResult(0, "商品資料有誤");
	}
	
	/**
	 * 圖片上傳功能
	 * @param image 圖片檔案
	 * @param name 圖片名稱
	 * @param request 讀取路徑
	 * @return 成功返回1，失敗返回0
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/imageUpload.do")
	@ResponseBody
	public ResponseResult<Void> imageUpload(MultipartFile image, String name, HttpServletRequest request) throws IllegalStateException, IOException {
		if (image == null) {
			return new ResponseResult<Void>(0, "找不到檔案");
		}
		String path = "/img/" + name + ".png";
		path = request.getServletContext().getRealPath(path);
		image.transferTo(new File(path));
		return new ResponseResult<Void>(1, "上傳成功");
	}
	
}
