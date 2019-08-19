package wang.store.order;

public interface OrderMapper {
	
	/**
	 * 新增訂單資料
	 * @param orderInformation 訂單資料
	 * @return 新訂單
	 */
	Integer insert(OrderInformation orderInformation);
}
