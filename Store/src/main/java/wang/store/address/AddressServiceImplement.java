package wang.store.address;

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

	public Integer insert(Address address) {
		Integer result = addressMapper.insert(address);
		return result;
	}

}
