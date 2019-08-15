package wang.store.address;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

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
		String[] cities = addressService.cityOption();
		return new ResponseResult<String[]>(cities);
	}
}
