package wang.store.order.orderinformation;

import java.io.Serializable;
import java.sql.Timestamp;

public class OrderInformation implements Serializable{
	
	private static final long serialVersionUID = -4822872451921815351L;
	private Integer id;
	private Integer state; //0=待付款 1=待出貨 2=待收貨 3=已完成 4=已取消 5=退貨
	private Integer total;
	private Timestamp createdTime;
	private Integer userId;
	private String recipientName;
	private String recipientPhone;
	private String recipientAddress;
	
	public OrderInformation() {
		super();
	}
	public OrderInformation(Integer id, Integer state, Integer total, Timestamp createdTime, Integer userId,
			String recipientName, String recipientPhone, String recipientAddress) {
		super();
		this.id = id;
		this.state = state;
		this.total = total;
		this.createdTime = createdTime;
		this.userId = userId;
		this.recipientName = recipientName;
		this.recipientPhone = recipientPhone;
		this.recipientAddress = recipientAddress;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Timestamp getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getRecipientPhone() {
		return recipientPhone;
	}
	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}
	public String getRecipientAddress() {
		return recipientAddress;
	}
	public void setRecipientAddress(String recipientAddress) {
		this.recipientAddress = recipientAddress;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((createdTime == null) ? 0 : createdTime.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((recipientAddress == null) ? 0 : recipientAddress.hashCode());
		result = prime * result + ((recipientName == null) ? 0 : recipientName.hashCode());
		result = prime * result + ((recipientPhone == null) ? 0 : recipientPhone.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((total == null) ? 0 : total.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
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
		OrderInformation other = (OrderInformation) obj;
		if (createdTime == null) {
			if (other.createdTime != null)
				return false;
		} else if (!createdTime.equals(other.createdTime))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (recipientAddress == null) {
			if (other.recipientAddress != null)
				return false;
		} else if (!recipientAddress.equals(other.recipientAddress))
			return false;
		if (recipientName == null) {
			if (other.recipientName != null)
				return false;
		} else if (!recipientName.equals(other.recipientName))
			return false;
		if (recipientPhone == null) {
			if (other.recipientPhone != null)
				return false;
		} else if (!recipientPhone.equals(other.recipientPhone))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (total == null) {
			if (other.total != null)
				return false;
		} else if (!total.equals(other.total))
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OrderInformation [id=" + id + ", state=" + state + ", total=" + total + ", createdTime=" + createdTime
				+ ", userId=" + userId + ", recipientName=" + recipientName + ", recipientPhone=" + recipientPhone
				+ ", recipientAddress=" + recipientAddress + "]";
	}
	
}
