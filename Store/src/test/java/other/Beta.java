package other;

import java.util.List;
import java.util.ResourceBundle;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import wang.store.order.OrderInformation;
import wang.store.order.OrderMapper;
import wang.store.recipient.RecipientServiceImplement;

public class Beta {
	
	@Test
	public void testMapper() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		OrderMapper mapper = ctx.getBean("orderMapper", OrderMapper.class);
		List<OrderInformation> orderInformations = mapper.orderInformationsFindByUserId(29);
		for (OrderInformation orderInformation : orderInformations) {
			System.out.println(orderInformation.getRecipientId());
			System.out.println(orderInformation.getTotal());
		}
	}
	
	@Test
	public void testService() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("spring-dao.xml","spring-mvc.xml");
		RecipientServiceImplement service = ctx.getBean("recipientServiceImplement", RecipientServiceImplement.class);
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
