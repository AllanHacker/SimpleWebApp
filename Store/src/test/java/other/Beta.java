package other;

import java.util.ResourceBundle;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import wang.store.recipient.RecipientServiceImplement;
import wang.store.user.UserMapper;

public class Beta {
	
	@Test
	public void testMapper() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		UserMapper mapper = ctx.getBean("userMapper", UserMapper.class);
		
	}
	
	@Test
	public void testService() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		RecipientServiceImplement service = ctx.getBean("recipientServiceImplement", RecipientServiceImplement.class);
		
	}
	
	@Test
	public void salt() {
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String a = properties.getString("salt");
		System.out.println(a);
		System.out.println(DigestUtils.md5Hex(a));
	}
	
	@Test
	public void uuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println(uuid);
	}
	
}
