package wang.store.address;

import java.io.Serializable;

public class Address implements Serializable{
	
	private static final long serialVersionUID = 5250512535272753841L;
	private Integer id;
	private Integer userId;
	private String address;
	private Integer aDefault;
	
	public Address() {
		super();
	}
	public Address(Integer id, Integer userId, String address, Integer aDefault) {
		super();
		this.id = id;
		this.userId = userId;
		this.address = address;
		this.aDefault = aDefault;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getaDefault() {
		return aDefault;
	}
	public void setaDefault(Integer aDefault) {
		this.aDefault = aDefault;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((aDefault == null) ? 0 : aDefault.hashCode());
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		Address other = (Address) obj;
		if (aDefault == null) {
			if (other.aDefault != null)
				return false;
		} else if (!aDefault.equals(other.aDefault))
			return false;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
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
		return "Address [id=" + id + ", userId=" + userId + ", address=" + address + ", aDefault=" + aDefault + "]";
	}
	
}
