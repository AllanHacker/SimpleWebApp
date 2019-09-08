package wang.store.order;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import wang.store.order.orderinformation.OrderInformation;
import wang.store.order.orderinformation.OrderInformationMapper;
import wang.store.order.orderproduct.OrderProduct;
import wang.store.order.orderproduct.OrderProductMapper;

@Service("orderServiceImplement")
public class OrderServiceImplement implements OrderServiceInterface{
	
	@Resource(name = "orderInformationMapper")
	private OrderInformationMapper orderInformationMapper;
	
	@Resource(name = "orderProductMapper")
	private OrderProductMapper orderProductMapper;
	
	public Integer add(Integer total, String recipientName, String recipientPhone, String recipientAddress, 
			Integer[] productId, Integer[] productNumber, Integer userId) {
		
		OrderInformation orderInformation = new OrderInformation();
		orderInformation.setTotal(total);
		orderInformation.setUserId(userId);
		orderInformation.setRecipientName(recipientName);
		orderInformation.setRecipientPhone(recipientPhone);
		orderInformation.setRecipientAddress(recipientAddress);
		Integer result = orderInformationMapper.insert(orderInformation);
		
		OrderProduct orderProduct;
		for (int i = 0; i < productNumber.length; i++) {
			int pid = productId[i];
			int pnum = productNumber[i];
			orderProduct = new OrderProduct(null, orderInformation.getId(), pid, pnum);
			result = orderProductMapper.insert(orderProduct);
		}
		return result;
	}
	
	public List<OrderInformation> orderInformationsFindByUserId(Integer userId) {
		return orderInformationMapper.selectByUserId(userId);
	}

	public OrderInformation orderInformationFindByUserIdAndId(Integer userId, Integer id) {
		return orderInformationMapper.selectByUserIdAndId(userId, id);
	}

	public List<OrderProduct> orderProductFindById(Integer orderId) {
		return orderProductMapper.selectById(orderId);
	}

	public Integer orderStateChange(Integer id, Integer userId, Integer state) {
		return orderInformationMapper.update(id, userId, state);
	}
	
}
