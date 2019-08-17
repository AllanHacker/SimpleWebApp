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

	public String[] countryOption(String city) {
		return addressMapper.countryOption(city);
	}

	public String[] roadOption(String city, String country) {
		return addressMapper.roadOption(city, country);
	}
	
	public Integer postalCode(String city, String country, String road) {
		return addressMapper.postalCode(city, country, road);
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
