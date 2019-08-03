package wang.store.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.Product;
import wang.store.bean.Product_category;
import wang.store.bean.ResponseResult;
import wang.store.service.ProductServiceInterface;

@Controller("productController")
public class ProductController {
	
	@Resource(name = "productServiceImplement")
	private ProductServiceInterface productService;
	
	@RequestMapping("/productDetailPage.do")
	public String productDetailPage(Integer id, ModelMap modelMap) {
		Product product = productService.findProductById(id);
		modelMap.addAttribute("product", product);
		return "productDetail";
	}
	
	@RequestMapping("/categoryListShow.do")
	@ResponseBody
	public ResponseResult categoryListShow(Integer parentId) {
		List<Product_category> category = productService.findCategoryByParentId(parentId);
		ResponseResult responseResult = new ResponseResult(category);
		return responseResult;
	}
	
	@RequestMapping("/productListShow.do")
	@ResponseBody
	public ResponseResult productListShow(Integer categoryId) {
		List<Product> products = productService.findProductByCategoryId(categoryId);
		ResponseResult responseResult = new ResponseResult(products);
		return responseResult;
	}
}
