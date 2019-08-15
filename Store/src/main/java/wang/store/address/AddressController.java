package wang.store.address;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

@Controller("addressController")
public class AddressController {
	
	@Resource(name = "addressServiceImplement")
	private AddressServiceInterface addressService;
	
	/**
	 * 顯示地址管理頁面
	 * @return 地址管理頁面
	 */
	@RequestMapping("/addressPage.do")
	public String addressPage() {
		return "address";
	}
	
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
	
	/**
	 * 根據縣市查詢鄉鎮區選項
	 * @param city 縣市
	 * @return 鄉鎮區選項
	 */
	@RequestMapping("/countryOption.do")
	@ResponseBody
	public ResponseResult<String[]> countryOption(String city) {
		String[] countries = addressService.countryOption(city);
		return new ResponseResult<String[]>(countries);
	}
	
	/**
	 * 根據縣市及鄉鎮區查詢路名選項
	 * @param city 縣市
	 * @param country 鄉鎮區
	 * @return 路名選項
	 */
	@RequestMapping("/roadOption.do")
	@ResponseBody
	public ResponseResult<String[]> roadOption(String city, String country) {
		String[] roads = addressService.roadOption(city, country);
		return new ResponseResult<String[]>(roads);
	}
	
	/**
	 * 新增收貨地址
	 * @param addr 地址
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressAdd.do")
	@ResponseBody
	public ResponseResult<Void> addressAdd(String addr, String addr2, HttpSession session) {
		if (addr.contains("-")) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		if ("".equals(addr2)) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		Integer userId = (Integer) session.getAttribute("userId");
		Address address = new Address();
		address.setAddress(addr + addr2);
		address.setUserId(userId);
		Integer result = addressService.insert(address);
		if (result == 1) {
			return new ResponseResult<Void>(1, "地址新增成功");
		} else {
			return new ResponseResult<Void>(0, "地址新增失敗");
		}
	}
	
	/**
	 * 地址列表
	 * @param session 會員id儲存位置
	 * @return 有資料返回1，沒資料返回0
	 */
	@RequestMapping("/addressList.do")
	@ResponseBody
	public ResponseResult<List<Address>> addressList(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		List<Address> addresses = addressService.addressFindByUserId(userId);
		if (addresses.size() < 1) {
			return new ResponseResult<List<Address>>(0, "趕快新增第一個地址");
		}
		return new ResponseResult<List<Address>>(1, addresses);
	}
	
	/**
	 * 刪除地址
	 * @param id 地址id
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressDelete.do")
	@ResponseBody
	public ResponseResult<Void> addressDelete(Integer id) {
		Integer result = addressService.addressDelete(id);
		if (result == 1) {
			return new ResponseResult<Void>(1, "地址刪除成功");
		}
		return new ResponseResult<Void>(0, "地址刪除失敗");
	}
}
