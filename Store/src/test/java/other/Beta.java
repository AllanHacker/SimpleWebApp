package other;

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

}
