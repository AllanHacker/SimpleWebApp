package wang.store.order.orderproduct;

import java.io.Serializable;

public class OrderProduct implements Serializable{
	
	private static final long serialVersionUID = 2376768230494977144L;
	private Integer id;
	private Integer orderId;
	private Integer productId;
	private Integer productNumber;
	
	public OrderProduct() {
		super();
	}
	public OrderProduct(Integer id, Integer orderId, Integer productId, Integer productNumber) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.productId = productId;
		this.productNumber = productNumber;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(Integer productNumber) {
		this.productNumber = productNumber;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((orderId == null) ? 0 : orderId.hashCode());
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
		result = prime * result + ((productNumber == null) ? 0 : productNumber.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderProduct other = (OrderProduct) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (orderId == null) {
			if (other.orderId != null)
				return false;
		} else if (!orderId.equals(other.orderId))
			return false;
		if (productId == null) {
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		if (productNumber == null) {
			if (other.productNumber != null)
				return false;
		} else if (!productNumber.equals(other.productNumber))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OrderProduct [id=" + id + ", orderId=" + orderId + ", productId=" + productId + ", productNumber="
				+ productNumber + "]";
	}
	
}
