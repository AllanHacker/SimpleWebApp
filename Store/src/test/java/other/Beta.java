package other;

import java.util.List;
import java.util.ResourceBundle;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import wang.store.address.AddressMapper;
import wang.store.address.AddressServiceImplement;
import wang.store.cart.Cart;
import wang.store.cart.CartMapper;
import wang.store.order.OrderInformation;
import wang.store.order.OrderMapper;
import wang.store.service.ProductServiceImplement;

public class Beta {
	
	@Test
	public void testMapper() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		OrderMapper mapper = ctx.getBean("orderMapper", OrderMapper.class);
		OrderInformation orderInformation = new OrderInformation();
		orderInformation.setTotal(5600);
		orderInformation.setUserId(99);
		orderInformation.setRecipientId(56);
		Integer result = mapper.insert(orderInformation);
		System.out.println(result);
	}
	
	@Test
	public void testService() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		AddressServiceImplement service = ctx.getBean("addressServiceImplement", AddressServiceImplement.class);
		String[] roads = service.roadOption("高雄市", "苓雅區");
		for (String road : roads) {
			System.out.println(road);
		}
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
