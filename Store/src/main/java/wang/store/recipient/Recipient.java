package wang.store.recipient;

import java.io.Serializable;

public class Recipient implements Serializable{
	
	private static final long serialVersionUID = 3727612922043944924L;
	private Integer id;
	private Integer userId;
	private Integer recipientDefault;
	private Integer postalCode;
	private String city;
	private String district;
	private String road;
	private String other;
	private String recipientName;
	private String recipientPhone;
	
	public Recipient() {
		super();
	}

	public Recipient(Integer id, Integer userId, Integer recipientDefault, Integer postalCode, String city,
			String district, String road, String other, String recipientName, String recipientPhone) {
		super();
		this.id = id;
		this.userId = userId;
		this.recipientDefault = recipientDefault;
		this.postalCode = postalCode;
		this.city = city;
		this.district = district;
		this.road = road;
		this.other = other;
		this.recipientName = recipientName;
		this.recipientPhone = recipientPhone;
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

	public Integer getRecipientDefault() {
		return recipientDefault;
	}

	public void setRecipientDefault(Integer recipientDefault) {
		this.recipientDefault = recipientDefault;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result + ((district == null) ? 0 : district.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((other == null) ? 0 : other.hashCode());
		result = prime * result + ((postalCode == null) ? 0 : postalCode.hashCode());
		result = prime * result + ((recipientDefault == null) ? 0 : recipientDefault.hashCode());
		result = prime * result + ((recipientName == null) ? 0 : recipientName.hashCode());
		result = prime * result + ((recipientPhone == null) ? 0 : recipientPhone.hashCode());
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
		Recipient other = (Recipient) obj;
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
		if (recipientDefault == null) {
			if (other.recipientDefault != null)
				return false;
		} else if (!recipientDefault.equals(other.recipientDefault))
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
		return "Recipient [id=" + id + ", userId=" + userId + ", recipientDefault=" + recipientDefault + ", postalCode="
				+ postalCode + ", city=" + city + ", district=" + district + ", road=" + road + ", other=" + other
				+ ", recipientName=" + recipientName + ", recipientPhone=" + recipientPhone + "]";
	}
	
}
