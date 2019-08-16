package wang.store.address;

import java.io.Serializable;

public class Address implements Serializable{
	
	private static final long serialVersionUID = 4764731669170725702L;
	private Integer id;
	private Integer userId;
	private Integer aDefault;
	private Integer postalCode;
	private String city;
	private String district;
	private String road;
	private String other;
	
	public Address() {
		super();
	}
	public Address(Integer id, Integer userId, Integer aDefault, Integer postalCode, String city, String district,
			String road, String other) {
		super();
		this.id = id;
		this.userId = userId;
		this.aDefault = aDefault;
		this.postalCode = postalCode;
		this.city = city;
		this.district = district;
		this.road = road;
		this.other = other;
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
	public Integer getaDefault() {
		return aDefault;
	}
	public void setaDefault(Integer aDefault) {
		this.aDefault = aDefault;
	}
	public Integer getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(Integer postalCode) {
		this.postalCode = postalCode;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getRoad() {
		return road;
	}
	public void setRoad(String road) {
		this.road = road;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((aDefault == null) ? 0 : aDefault.hashCode());
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result + ((district == null) ? 0 : district.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((other == null) ? 0 : other.hashCode());
		result = prime * result + ((postalCode == null) ? 0 : postalCode.hashCode());
		result = prime * result + ((road == null) ? 0 : road.hashCode());
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
		if (city == null) {
			if (other.city != null)
				return false;
		} else if (!city.equals(other.city))
			return false;
		if (district == null) {
			if (other.district != null)
				return false;
		} else if (!district.equals(other.district))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (this.other == null) {
			if (other.other != null)
				return false;
		} else if (!this.other.equals(other.other))
			return false;
		if (postalCode == null) {
			if (other.postalCode != null)
				return false;
		} else if (!postalCode.equals(other.postalCode))
			return false;
		if (road == null) {
			if (other.road != null)
				return false;
		} else if (!road.equals(other.road))
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
		return "Address [id=" + id + ", userId=" + userId + ", aDefault=" + aDefault + ", postalCode=" + postalCode
				+ ", city=" + city + ", district=" + district + ", road=" + road + ", other=" + other + "]";
	}
	
}
