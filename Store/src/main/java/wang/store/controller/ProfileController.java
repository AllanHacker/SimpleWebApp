package wang.store.controller;

import java.util.ResourceBundle;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.jdbc.core.metadata.Db2CallMetaDataProvider;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.bean.ResponseResult;
import wang.store.bean.User;
import wang.store.service.UserServiceInterface;

@Controller("profileController")
@RequestMapping("/profile")
public class ProfileController {
	
	@Resource(name="userServiceImplement")
	private UserServiceInterface userService;
	
	/**
	 * 驗證用戶提交的密碼資料
	 * @param password 用戶提交的密碼資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "passwordCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult passwordCheck(String password) {
		ResponseResult responseResult;
		if (password == "") {
			return responseResult = new ResponseResult(1, "");
		} else {
			String regex = "\\w{8,30}";
			if (password.matches(regex)) {
				return responseResult = new ResponseResult(1, "格式正確");
			} else {
				return responseResult = new ResponseResult(0, "格式錯誤");
			}
		}
	}
	
	/**
	 * 驗證用戶提交的密碼確認資料
	 * @param password 密碼
	 * @param password2 密碼確認
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "password2Check.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult password2Check(String password, String password2) {
		ResponseResult responseResult;
		if (password2 == "") {
			return responseResult = new ResponseResult(1, "");
		} else {
			if (password.equals(password2)) {
				return responseResult = new ResponseResult(1, "正確");
			} else {
				return responseResult = new ResponseResult(0, "密碼不一致");
			}
		}
	}
	
	/**
	 * 驗證用戶提交的信箱資料
	 * @param email 用戶提交的信箱資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "emailCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult emailCheck(String email) {
		ResponseResult responseResult;
		if (email == "") {
			return responseResult = new ResponseResult(1, "");
		} else {
			String regex = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z]+$";
			if (email.matches(regex)) {
				return responseResult = new ResponseResult(1, "正確");
			} else {
				return responseResult = new ResponseResult(0, "這不是信箱");
			}
		}
	}
	
	/**
	 * 驗證用戶提交的手機資料
	 * @param phone 用戶提交的手機資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "phoneCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult phoneCheck(String phone) {
		ResponseResult responseResult;
		if (phone == "") {
			return responseResult = new ResponseResult(1, "");
		} else {
			String regex = "^09\\d{8}$";
			if (phone.matches(regex)) {
				return responseResult = new ResponseResult(1, "正確");
			} else {
				return responseResult = new ResponseResult(0, "手機號碼有誤");
			}
		}
	}
	
	
	/**
	 * 將會員的資料載入到會員中心頁面中
	 * @param session 會員資料儲存的位置
	 * @return 帳號、信箱、手機
	 */
	@RequestMapping(value = "loadData.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult loadData(HttpSession session) {
		ResponseResult responseResult;
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userService.findUserByUserId(userId);
		String username = user.getUsername();
		String email = user.getEmail();
		String phone = user.getPhone();
		String[] data = {username, email, phone};
		return responseResult = new ResponseResult(1, data);
	}
	
	/**
	 * 會員資料修改功能
	 * @param oldPassword 會員密碼
	 * @param password 新密碼
	 * @param password2 新密碼確認
	 * @param email 新信箱
	 * @param phone 新手機
	 * @param session 會員id儲存的位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "userUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult userUpdate(String oldPassword, String password, String password2,
			String email, String phone, HttpSession session) {
		ResponseResult responseResult;
		boolean flag = true;
		responseResult = passwordCheck(password);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = password2Check(password, password2);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = emailCheck(email);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		responseResult = phoneCheck(phone);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		if (flag) {
			Integer userId = (Integer) session.getAttribute("userId");
			User user = userService.findUserByUserId(userId);
			ResourceBundle properties = ResourceBundle.getBundle("db");
			String salt = properties.getString("salt");
			oldPassword = oldPassword + salt;
			if (user.getPassword().equals(DigestUtils.md5Hex(oldPassword))) {
				if (!"".equals(password)) {
					password = password + salt;
					user.setPassword(DigestUtils.md5Hex(password));
				}
				if (!"".equals(email)) {
					user.setEmail(email);		
				}
				if (!"".equals(phone)) {
					user.setPhone(phone);
				}
				userService.userUpdate(user);
				return responseResult = new ResponseResult(1, "修改成功");
			} else {
				return responseResult = new ResponseResult(0, "密碼錯誤");
			}
		} else {
			return responseResult = new ResponseResult(0, "資料有誤，無法修改");
		}
	}
}
