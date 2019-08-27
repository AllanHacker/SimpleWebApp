package wang.store.address;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.common.ResponseResult;

@Controller("addressController")
public class AddressController {
	
	@Resource(name = "addressServiceImplement")
	private AddressServiceInterface addressService;
	
	/**
	 * 查詢縣市選項
	 * @return 縣市選項
	 */
	@RequestMapping("/cityOption.do")
	@ResponseBody
	public ResponseResult<String[]> cityOption() {
		String[] cities = addressService.findCity();
		return new ResponseResult<String[]>(cities);
	}
	
	/**
	 * 根據縣市查詢鄉鎮區選項
	 * @param city 縣市
	 * @return 鄉鎮區選項
	 */
	@RequestMapping("/districtOption.do")
	@ResponseBody
	public ResponseResult<String[]> districtOption(String city) {
		String[] districts = addressService.findDistrict(city);
		return new ResponseResult<String[]>(districts);
	}
	
	/**
	 * 根據縣市及鄉鎮區查詢路名選項
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @return 路名選項
	 */
	@RequestMapping("/roadOption.do")
	@ResponseBody
	public ResponseResult<String[]> roadOption(String city, String district) {
		String[] roads = addressService.findRoad(city, district);
		return new ResponseResult<String[]>(roads);
	}
	
	/**
	 * 根據縣市及鄉鎮區查詢郵遞區號
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @param road 路名
	 * @return 郵遞區號
	 */
	@RequestMapping("/postalCode.do")
	@ResponseBody
	public ResponseResult<Integer> postalCode(String city, String district, String road) {
		Integer postalCode = addressService.findPostalCode(city, district, road);
		return new ResponseResult<Integer>(1, postalCode);
	}
	
}
