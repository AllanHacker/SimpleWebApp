package wang.store.order;

import java.util.List;

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

	public List<OrderInformation> orderInformationsFindByUserId(Integer userId) {
		return orderMapper.orderInformationsFindByUserId(userId);
	}

	public OrderInformation orderInformationFindByUserIdAndId(Integer userId, Integer id) {
		return orderMapper.orderInformationFindByUserIdAndId(userId, id);
	}

	public List<OrderProduct> orderProductFindById(Integer orderId) {
		return orderMapper.orderProductFindById(orderId);
	}

}
