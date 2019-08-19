package wang.store.order;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("orderServiceImplement")
public class OrderServiceImplement implements OrderServiceInterface{
	
	@Resource(name = "orderMapper")
	private OrderMapper orderMapper;
	
	public Integer insertOrderInformation(OrderInformation orderInformation) {
		return orderMapper.insertOrderInformation(orderInformation);
	}

	public Integer insertOrderProduct(OrderProduct orderProduct) {
		return orderMapper.insertOrderProduct(orderProduct);
	}

}
