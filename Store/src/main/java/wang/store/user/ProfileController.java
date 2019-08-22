package wang.store.user;

import java.util.ResourceBundle;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.common.ResponseResult;

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
	public ResponseResult<Void> passwordCheck(String password) {
		if (password == "") {
			return new ResponseResult<Void>(1, "");
		} else {
			String regex = "\\w{8,30}";
			if (password.matches(regex)) {
				return new ResponseResult<Void>(1, "格式正確");
			} else {
				return new ResponseResult<Void>(0, "格式錯誤");
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
	public ResponseResult<Void> password2Check(String password, String password2) {
		if (password2 == "") {
			return new ResponseResult<Void>(1, "");
		} else {
			if (password.equals(password2)) {
				return new ResponseResult<Void>(1, "正確");
			} else {
				return new ResponseResult<Void>(0, "密碼不一致");
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
	public ResponseResult<Void> emailCheck(String email) {
		if (email == "") {
			return new ResponseResult<Void>(1, "");
		} else {
			String regex = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z]+$";
			if (email.matches(regex)) {
				return new ResponseResult<Void>(1, "正確");
			} else {
				return new ResponseResult<Void>(0, "這不是信箱");
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
	public ResponseResult<Void> phoneCheck(String phone) {
		if (phone == "") {
			return new ResponseResult<Void>(1, "");
		} else {
			String regex = "^09\\d{8}$";
			if (phone.matches(regex)) {
				return new ResponseResult<Void>(1, "正確");
			} else {
				return new ResponseResult<Void>(0, "手機號碼有誤");
			}
		}
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
	public ResponseResult<Void> userUpdate(String oldPassword, String password, String password2,
			String email, String phone, HttpSession session) {
		ResponseResult<Void> responseResult;
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
				return responseResult = new ResponseResult<Void>(1, "修改成功");
			} else {
				return responseResult = new ResponseResult<Void>(0, "密碼錯誤");
			}
		} else {
			return responseResult = new ResponseResult<Void>(0, "資料有誤，無法修改");
		}
	}
	
	/**
	 * 刪除帳號功能
	 * @param oldPassword 會員的密碼
	 * @param session 會員id儲存的位置
	 * @return 刪除成功返回1，密碼錯誤返回0
	 */
	@RequestMapping(value = "userDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> userDelete(String oldPassword, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userService.findUserByUserId(userId);
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String salt = properties.getString("salt");
		oldPassword = oldPassword + salt;
		if (user.getPassword().equals(DigestUtils.md5Hex(oldPassword))) {
			Integer state = 0;
			user.setState(state);
			userService.userUpdate(user);
			return new ResponseResult<Void>(1, "帳號已被刪除");
		} else {
			return new ResponseResult<Void>(0, "密碼不正確");
		}
	}
	
}