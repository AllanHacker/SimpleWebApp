package wang.store.address;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("addressServiceImplement")
public class AddressServiceImplement implements AddressServiceInterface{
	
	@Resource(name = "addressMapper")
	private AddressMapper addressMapper;
	
	public String[] findCity() {
		return addressMapper.selectCity();
	}

	public String[] findDistrict(String city) {
		return addressMapper.selectDistrict(city);
	}

	public String[] findRoad(String city, String district) {
		return addressMapper.selectRoad(city, district);
	}
	
	public Integer findPostalCode(String city, String district, String road) {
		return addressMapper.selectPostalCode(city, district, road);
	}

}
