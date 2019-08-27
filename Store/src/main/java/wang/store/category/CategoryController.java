package wang.store.category;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.common.ResponseResult;

@Controller("categoryController")
public class CategoryController {
	
	@Resource(name = "categoryServiceImplement")
	private CategoryServiceInterface categoryService;
	
	/**
	 * 顯示商品目錄列表
	 * @param parentId 父級分類id
	 * @return 商品目錄列表
	 */
	@RequestMapping("/categoryListShow.do")
	@ResponseBody
	public ResponseResult<List<Category>> categoryListShow(Integer parentId) {
		List<Category> categories = categoryService.findByParentId(parentId);
		return new ResponseResult<List<Category>>(categories);
	}
	
}
