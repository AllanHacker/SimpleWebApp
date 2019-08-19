package wang.store.recipient;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;

@Controller("recipientController")
public class RecipientController {
	
	@Resource(name = "recipientServiceImplement")
	private RecipientServiceInterface recipientService;
	
	/**
	 * 顯示收件人頁面
	 * @return 收件人頁面
	 */
	@RequestMapping("/recipientPage.do")
	public String recipientPage() {
		return "recipient";
	}
	
	/**
	 * 查詢縣市選項
	 * @return 縣市選項
	 */
	@RequestMapping("/cityOption.do")
	@ResponseBody
	public ResponseResult<String[]> cityOption() {
		String[] cities = recipientService.cityOption();
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
		String[] districts = recipientService.districtOption(city);
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
		String[] roads = recipientService.roadOption(city, district);
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
		Integer postalCode = recipientService.postalCode(city, district, road);
		return new ResponseResult<Integer>(1, postalCode);
	}
	
	/**
	 * 新增收件人
	 * @param postalCode 郵遞區號
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @param road 路名
	 * @param other 詳細地址
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "/recipientAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> recipientAdd(String recipientName, String recipientPhone, Integer postalCode,
			String city, String district, String road, String other, HttpSession session) {
		
		Integer checkResult = dataCheck(recipientName, recipientPhone, city, district, road, other);
		if (checkResult == 0) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		Integer userId = (Integer) session.getAttribute("userId");
		List<Recipient> recipientes = recipientService.recipientFindByUserId(userId);
		if (recipientes.size() > 9) {
			return new ResponseResult<Void>(0, "只能設定10個收件人");
		}
		Recipient recipient = new Recipient();
		recipient.setRecipientName(recipientName);
		recipient.setRecipientPhone(recipientPhone);
		recipient.setUserId(userId);
		recipient.setPostalCode(postalCode);
		recipient.setCity(city);
		recipient.setDistrict(district);
		recipient.setRoad(road);
		recipient.setOther(other);
		Integer result = recipientService.insert(recipient);
		if (result == 1) {
			return new ResponseResult<Void>(1, "收件人新增成功");
		} else {
			return new ResponseResult<Void>(0, "收件人新增失敗");
		}
	}
	
	/**
	 * 收件人列表
	 * @param session 會員id儲存位置
	 * @return 有資料返回1，沒資料返回0
	 */
	@RequestMapping("/recipientList.do")
	@ResponseBody
	public ResponseResult<List<Recipient>> recipientList(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		List<Recipient> recipientes = recipientService.recipientFindByUserId(userId);
		if (recipientes.size() < 1) {
			return new ResponseResult<List<Recipient>>(0, "趕快新增收件人");
		}
		return new ResponseResult<List<Recipient>>(1, recipientes);
	}
	
	/**
	 * 刪除收件人
	 * @param id 收件人id
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/recipientDelete.do")
	@ResponseBody
	public ResponseResult<Void> recipientDelete(Integer id) {
		Integer result = recipientService.recipientDelete(id);
		if (result == 1) {
			return new ResponseResult<Void>(1, "收件人刪除成功");
		}
		return new ResponseResult<Void>(0, "收件人刪除失敗");
	}
	
	/**
	 * 將收件人設為預設
	 * @param id 收件人id
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/recipientDefault.do")
	@ResponseBody
	public ResponseResult<Void> recipientDefault(Integer id, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		Integer result = recipientService.recipientDefaultClear(userId);
		result = recipientService.recipientDefaultSet(userId, id);
		if (result == 1) {
			return new ResponseResult<Void>(1, "設置完畢");
		}
		return new ResponseResult<Void>(0, "設置失敗");
	}
	
	/**
	 * 查詢收件人資料並返回
	 * @param id 收件人id
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping("/recipientLoad.do")
	@ResponseBody
	public ResponseResult<Recipient> recipientLoad(Integer id, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		Recipient recipient = recipientService.recipientFindByUserIdAndId(userId, id);
		if (recipient != null) {
			return new ResponseResult<Recipient>(1, recipient);
		}
		return new ResponseResult<Recipient>(0, "收件人不存在");
	}
	
	/**
	 * 修改收件人。查詢出該筆收件人，並將新的資料寫入
	 * @param id 收件人id
	 * @param postalCode 新的郵遞區號
	 * @param city 新的縣市
	 * @param district 新的鄉鎮區
	 * @param road 新的路名
	 * @param other 新的詳細地址
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "/recipientChange.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> recipientChange(String recipientName, String recipientPhone, Integer postalCode, 
			String city, String district, String road, String other, Integer id, HttpSession session) {
		
		Integer checkResult = dataCheck(recipientName, recipientPhone, city, district, road, other);
		if (checkResult == 0) {
			return new ResponseResult<Void>(0, "資料有誤");
		}
		Integer userId = (Integer) session.getAttribute("userId");
		Recipient recipient = recipientService.recipientFindByUserIdAndId(userId, id);
		if (recipient != null) {
			recipient.setRecipientName(recipientName);
			recipient.setRecipientPhone(recipientPhone);
			recipient.setPostalCode(postalCode);
			recipient.setCity(city);
			recipient.setDistrict(district);
			recipient.setRoad(road);
			recipient.setOther(other);
			recipientService.recipientUpdate(recipient);
			return new ResponseResult<Void>(1, "已更新收件人");
		}
		return new ResponseResult<Void>(0, "收件人不存在");
	}
	
	private Integer dataCheck(String recipientName, String recipientPhone,
			String city, String district, String road, String other) {
		
		//台灣法律規定，姓名並無字數限制
		if (!recipientName.matches("^[\\u4E00-\\u9fcc]{1,15}$")) {
			return 0;
		}
		if (!recipientPhone.matches("^09\\d{8}$")) {
			return 0;
		}
		if ((city+district+road).contains("-")) {
			return 0;
		}
		if (!other.matches("[0-9\\u4e00-\\u9fcc]+")) {
			return 0;
		}
		return 1;
	}
}
