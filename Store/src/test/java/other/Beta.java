package other;

import java.util.ResourceBundle;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import wang.store.bean.User;
import wang.store.mapper.UserMapper;

public class Beta {
	
	@Test
	public void testMapper() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		UserMapper mapper = ctx.getBean("userMapper", UserMapper.class);
		
		User user = mapper.findUserByUserId(27);
		System.out.println(user);
		user = mapper.findUserByUsername("aaa");
		System.out.println(user);
		
	}
	@Test
	public void salt() {
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String a = properties.getString("salt");
		System.out.println(a);
		System.out.println(DigestUtils.md5Hex(a));
	}

}
