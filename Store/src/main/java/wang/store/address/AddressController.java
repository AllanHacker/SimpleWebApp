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
	@RequestMapping("/districtOption.do")
	@ResponseBody
	public ResponseResult<String[]> districtOption(String city) {
		String[] districts = addressService.districtOption(city);
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
		String[] roads = addressService.roadOption(city, district);
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
		Integer postalCode = addressService.postalCode(city, district, road);
		return new ResponseResult<Integer>(1, postalCode);
	}
	
	/**
	 * 新增收貨地址
	 * @param postalCode 郵遞區號
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @param road 路名
	 * @param other 詳細地址
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressAdd.do")
	@ResponseBody
	public ResponseResult<Void> addressAdd(Integer postalCode, String city, 
			String district, String road, String other, HttpSession session) {
		
		String regex = "[0-9\\u4e00-\\u9fcc]+";
		if (!other.matches(regex) || (city+district+road).contains("-")) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		Integer userId = (Integer) session.getAttribute("userId");
		List<Address> addresses = addressService.addressFindByUserId(userId);
		if (addresses.size() > 9) {
			return new ResponseResult<Void>(0, "只能設定10個地址");
		}
		Address address = new Address();
		address.setUserId(userId);
		address.setPostalCode(postalCode);
		address.setCity(city);
		address.setDistrict(district);
		address.setRoad(road);
		address.setOther(other);
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
	
	/**
	 * 將地址設為預設
	 * @param id 地址id
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressDefault.do")
	@ResponseBody
	public ResponseResult<Void> addressDefault(Integer id, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		Integer result = addressService.addressDefaultClear(userId);
		result = addressService.addressDefaultSet(userId, id);
		if (result == 1) {
			return new ResponseResult<Void>(1, "設置完畢");
		}
		return new ResponseResult<Void>(0, "設置失敗");
	}
	
	/**
	 * 查詢地址資料並返回
	 * @param id 地址id
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressLoad.do")
	@ResponseBody
	public ResponseResult<Address> addressLoad(Integer id, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		Address address = addressService.addressFindByUserIdAndId(userId, id);
		if (address != null) {
			return new ResponseResult<Address>(1, address);
		}
		return new ResponseResult<Address>(0, "地址不存在");
	}
	
	/**
	 * 修改地址。查詢出該筆地址，並將新的資料寫入
	 * @param id 地址id
	 * @param postalCode 新的郵遞區號
	 * @param city 新的縣市
	 * @param district 新的鄉鎮區
	 * @param road 新的路名
	 * @param other 新的詳細地址
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/addressChange.do")
	@ResponseBody
	public ResponseResult<Void> addressChange(Integer id, Integer postalCode, String city, 
			String district, String road, String other, HttpSession session) {
		
		String regex = "[0-9\\u4e00-\\u9fcc]+";
		if (!other.matches(regex) || (city+district+road).contains("-")) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		Integer userId = (Integer) session.getAttribute("userId");
		Address address = addressService.addressFindByUserIdAndId(userId, id);
		if (address != null) {
			address.setPostalCode(postalCode);
			address.setCity(city);
			address.setDistrict(district);
			address.setRoad(road);
			address.setOther(other);
			addressService.addressUpdate(address);
			return new ResponseResult<Void>(1, "已更新地址");
		}
		return new ResponseResult<Void>(0, "地址不存在");
	}
}
