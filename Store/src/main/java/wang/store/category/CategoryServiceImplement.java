package wang.store.category;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("categoryServiceImplement")
public class CategoryServiceImplement implements CategoryServiceInterface{
	
	@Resource(name = "categoryMapper")
	private CategoryMapper categoryMapper;

	public List<Category> findByParentId(Integer parentId) {
		List<Category> categories = categoryMapper.selectByParentId(parentId);
		return categories;
	}

	public Category findById(Integer id) {
		return categoryMapper.selectById(id);
	}

}
