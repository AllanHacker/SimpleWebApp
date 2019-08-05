package other;

import java.util.List;
import java.util.ResourceBundle;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import wang.store.bean.Product;
import wang.store.bean.Product_category;
import wang.store.bean.User;
import wang.store.mapper.ProductMapper;
import wang.store.mapper.UserMapper;
import wang.store.service.ProductServiceImplement;
import wang.store.service.ProductServiceInterface;

public class Beta {
	
	@Test
	public void testMapper() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		ProductMapper mapper = ctx.getBean("productMapper", ProductMapper.class);
		
	}
	
	@Test
	public void testService() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		ProductServiceImplement service = ctx.getBean("productServiceImplement", ProductServiceImplement.class);
		
	}
	
	@Test
	public void salt() {
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String a = properties.getString("salt");
		System.out.println(a);
		System.out.println(DigestUtils.md5Hex(a));
	}
	
	@Test
	public void ddddd() {
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String a = properties.getString("salt");

		Integer num = 1;
		System.out.println(num.getClass());
	}
	

}
