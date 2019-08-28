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

@Controller("userController")
public class UserController {
	
	@Resource(name="userServiceImplement")
	private UserServiceInterface userService;
	
	/**
	 * 顯示帳號資料頁面
	 * @return 帳號資料頁面
	 */
	@RequestMapping("/profilePage.do")
	public String profilePage() {
		return "profile";
	}
	
	/**
	 * 以id查詢會員資料
	 * @param session 會員id儲存位置
	 * @return 找到的會員資料
	 */
	@RequestMapping(value = "userLoad.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<User> userLoad(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userService.findByUserId(userId);
		return new ResponseResult<User>(1, user);
	}
	
	/**
	 * 檢查是否已經登入
	 * @param session 用戶id儲存位置
	 * @return 未登入返回1，已登入返回0
	 */
	@RequestMapping("/loginCheck.do")
	@ResponseBody
	public ResponseResult<Void> loginCheck(HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return new ResponseResult<Void>(1);
		} else {
			return new ResponseResult<Void>(0, "您已登入，請勿重複登入");
		}
	}
		
	/**
	 * 登出功能
	 * @param session 會員id
	 * @return 回到登入頁面
	 */
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}
	
	/**
	 * 驗證用戶提交的帳號資料
	 * @param username 用戶提交的帳號資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "usernameCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> usernameCheck(String username) {
		String regex = "\\w{6,20}";
		if (username.matches(regex)) {
			return new ResponseResult<Void>(1, "格式正確");
		} else {
			return new ResponseResult<Void>(0, "格式錯誤");
		}
	}
	
	/**
	 * 驗證用戶提交的密碼資料
	 * @param password 用戶提交的密碼資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "passwordCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> passwordCheck(String password) {
		String regex = "\\w{8,30}";
		if (password.matches(regex)) {
			return new ResponseResult<Void>(1, "格式正確");
		} else {
			return new ResponseResult<Void>(0, "格式錯誤");
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
		if (password.equals(password2)) {
			return new ResponseResult<Void>(1, "正確");
		} else {
			return new ResponseResult<Void>(0, "密碼不一致");
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
		String regex = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z]+$";
		if (email.matches(regex)) {
			return new ResponseResult<Void>(1, "正確");
		} else {
			return new ResponseResult<Void>(0, "這不是信箱");
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
		String regex = "^09\\d{8}$";
		if (phone.matches(regex)) {
			return new ResponseResult<Void>(1, "正確");
		} else {
			return new ResponseResult<Void>(0, "手機號碼有誤");
		}
	}
	
	/**
	 * 使用者註冊功能，所有資料驗證通過才能註冊
	 * @param username 帳號
	 * @param password 密碼
	 * @param email 電郵
	 * @param phone 手機
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "userRegister.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> userRegister(String username, String password, String password2, 
			String email, String phone, String verification, HttpSession session) {
		ResponseResult<Void> responseResult;
		VerificationController vc = new VerificationController();
		boolean flag = true;
		
		responseResult = usernameCheck(username);
		if (responseResult.getState() == 0) {
			flag = false;
		}
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
		responseResult = vc.verificationCheck(verification, session);
		if (responseResult.getState() == 0) {
			flag = false;
		}
		if (flag) {
			User userExist = userService.findByUsername(username);
			if (userExist != null) {
				return responseResult = new ResponseResult<Void>(0, "帳號已被註冊");
			}
			//String salt = "愛的是非對錯已太多";
			ResourceBundle properties = ResourceBundle.getBundle("db");
			String salt = properties.getString("salt");
			password = password + salt;
			
			User user = new User();
			user.setUsername(username);
			user.setPassword(DigestUtils.md5Hex(password));
			user.setEmail(email);
			user.setPhone(phone);
			int result = userService.add(user);
			if (result == 1) {
				return responseResult = new ResponseResult<Void>(1, "註冊成功");
			} else {
				return responseResult = new ResponseResult<Void>(0, "註冊失敗");
			}
		}
		return responseResult = new ResponseResult<Void>(0, "資料有誤，請先核對再註冊");
	}
	
	/**
	 * 使用者登入功能
	 * @param username 帳號
	 * @param password 密碼
	 * @param verification 驗證碼
	 * @param session 系統的驗證碼儲存的位置
	 * @return 登入成功返回1，帳號密碼錯誤返回0，驗證碼錯誤返回2
	 */
	@RequestMapping(value = "userLogin.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> userLogin(String username, String password, String verification, 
			HttpSession session) {
		String verificationQ = (String) session.getAttribute("verification");
		if (!verificationQ.equals(verification.toUpperCase())) {
			return new ResponseResult<Void>(2, "驗證碼錯誤");
		} else {
			User user = userService.findByUsername(username);
			if (user == null) {
				return new ResponseResult<Void>(0, "無此帳號");
			} else {
				ResourceBundle properties = ResourceBundle.getBundle("db");
				String salt = properties.getString("salt");
				password = password + salt;
				if (!user.getPassword().equals(DigestUtils.md5Hex(password))) {
					return new ResponseResult<Void>(0, "密碼錯誤");
				}
			}
			session.setAttribute("userId", user.getUserId());
			return new ResponseResult<Void>(1, "登入成功");
		}
	}
	
	/**
	 * 修改會員的帳號資料
	 * @param email 新的信箱
	 * @param phone 新的手機號碼
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "userChange.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> userChange(String email, String phone, HttpSession session) {
		ResponseResult<Void> responseResult;
		boolean flag = true;
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
			User user = userService.findByUserId(userId);
			user.setEmail(email);
			user.setPhone(phone);
			userService.change(user);
			return responseResult = new ResponseResult<Void>(1, "修改成功");
		} else {
			return responseResult = new ResponseResult<Void>(0, "資料有誤，無法修改");
		}
	}
	
	/**
	 * 修改密碼功能
	 * @param oldPassword 原本的密碼
	 * @param password 新的密碼
	 * @param password2 密碼確認
	 * @param session 會員id儲存位置
	 * @return 成功返回1，失敗返回0
	 */
	@RequestMapping(value = "passwordChange.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> passwordChange(String oldPassword, String password, String password2,
			HttpSession session) {
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
		if (flag) {
			Integer userId = (Integer) session.getAttribute("userId");
			User user = userService.findByUserId(userId);
			ResourceBundle properties = ResourceBundle.getBundle("db");
			String salt = properties.getString("salt");
			if (user.getPassword().equals(DigestUtils.md5Hex(oldPassword + salt))) {
				user.setPassword(DigestUtils.md5Hex(password + salt));
				userService.change(user);
				return responseResult = new ResponseResult<Void>(1, "修改成功");
			} else {
				return responseResult = new ResponseResult<Void>(0, "密碼錯誤");
			}
		} else {
			return responseResult = new ResponseResult<Void>(0, "資料有誤，無法修改");
		}
	}
	
	/**
	 * 刪除帳號功能，並沒有實際刪除資料庫，只是修改state
	 * @param password 會員的密碼
	 * @param session 會員id儲存的位置
	 * @return 刪除成功返回1，密碼錯誤返回0
	 */
	@RequestMapping(value = "userDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> userDelete(String password, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userService.findByUserId(userId);
		ResourceBundle properties = ResourceBundle.getBundle("db");
		String salt = properties.getString("salt");
		if (user.getPassword().equals(DigestUtils.md5Hex(password + salt))) {
			user.setState(0);
			userService.change(user);
			return new ResponseResult<Void>(1, "帳號已被刪除");
		} else {
			return new ResponseResult<Void>(0, "密碼不正確");
		}
	}
}
