package wang.store.address;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("addressServiceImplement")
public class AddressServiceImplement implements AddressServiceInterface{
	
	@Resource(name = "addressMapper")
	private AddressMapper addressMapper;
	
	public String[] cityOption() {
		return addressMapper.cityOption();
	}

	public String[] districtOption(String city) {
		return addressMapper.districtOption(city);
	}

	public String[] roadOption(String city, String district) {
		return addressMapper.roadOption(city, district);
	}
	
	public Integer postalCode(String city, String district, String road) {
		return addressMapper.postalCode(city, district, road);
	}

	public Integer insert(Address address) {
		Integer result = addressMapper.insert(address);
		return result;
	}

	public List<Address> addressFindByUserId(Integer userId) {
		return addressMapper.addressFindByUserId(userId);
	}
	
	public Address addressFindByUserIdAndId(Integer userId, Integer id) {
		return addressMapper.addressFindByUserIdAndId(userId, id);
	}

	public Integer addressDelete(Integer id) {
		return addressMapper.addressDelete(id);
	}

	public Integer addressDefaultClear(Integer userId) {
		return addressMapper.addressDefaultClear(userId);
	}

	public Integer addressDefaultSet(Integer userId, Integer id) {
		return addressMapper.addressDefaultSet(userId, id);
	}

	public Integer addressUpdate(Address address) {
		return addressMapper.addressUpdate(address);
	}

}
