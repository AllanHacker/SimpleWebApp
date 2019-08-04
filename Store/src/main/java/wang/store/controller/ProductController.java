package wang.store.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
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
	 * 刊登新商品
	 * @param productName 商品名稱
	 * @param categoryId 商品分類
	 * @param price 商品價格
	 * @param number 商品數量
	 * @param image 商品圖片位置
	 * @return 成功
	 */
	@RequestMapping("/productPost.do")
	@ResponseBody
	public ResponseResult productPost(String productName, Integer categoryId, Integer price, Integer number, String image) {
		ResponseResult responseResult;
		Product product = new Product();
		product.setName(productName);
		product.setCategoryId(categoryId);
		product.setPrice(price);
		product.setNumber(number);
		image = "/img/" + image + ".png";
		product.setImage(image);
		productService.productPost(product);
		return responseResult = new ResponseResult(1, "商品新增成功");
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
