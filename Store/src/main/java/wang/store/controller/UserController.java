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

@Controller("userController")
public class UserController {
	
	@Resource(name="userServiceImplement")
	private UserServiceInterface userService;
	
	/**
	 * 顯示註冊頁面
	 * @return 註冊頁面
	 */
	@RequestMapping("/registerPage.do")
	public String registerPage() {
		return "register";
	}
	
	/**
	 * 根據會員id判斷，顯示登入頁面或已登入頁面
	 * @param session 會員id儲存的位置
	 * @return 登入頁面或已登入頁面
	 */
	@RequestMapping("/loginPage.do")
	public String loginPage(HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "login";
		} else {
			return "loginAlready";
		}
	}
	
	/**
	 * 顯示會員中心頁面
	 * @return 會員中心頁面
	 */
	@RequestMapping("/profilePage.do")
	public String profilePage() {
		return "profile";
	}
	
	/**
	 * 登出功能
	 * @param session 會員id
	 * @return 回到登入頁面
	 */
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		return "login";
	}
	
	/**
	 * 驗證用戶提交的帳號資料
	 * @param username 用戶提交的帳號資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "usernameCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult usernameCheck(String username) {
		ResponseResult responseResult;
		String regex = "\\w{6,20}";
		if (username.matches(regex)) {
			return responseResult = new ResponseResult(1, "格式正確");
		} else {
			return responseResult = new ResponseResult(0, "格式錯誤");
		}
	}
	
	/**
	 * 驗證用戶提交的密碼資料
	 * @param password 用戶提交的密碼資料
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "passwordCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult passwordCheck(String password) {
		ResponseResult responseResult;
		String regex = "\\w{8,30}";
		if (password.matches(regex)) {
			return responseResult = new ResponseResult(1, "格式正確");
		} else {
			return responseResult = new ResponseResult(0, "格式錯誤");
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
		if (password.equals(password2)) {
			return responseResult = new ResponseResult(1, "正確");
		} else {
			return responseResult = new ResponseResult(0, "密碼不一致");
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
		String regex = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z]+$";
		if (email.matches(regex)) {
			return responseResult = new ResponseResult(1, "正確");
		} else {
			return responseResult = new ResponseResult(0, "這不是信箱");
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
		String regex = "^09\\d{8}$";
		if (phone.matches(regex)) {
			return responseResult = new ResponseResult(1, "正確");
		} else {
			return responseResult = new ResponseResult(0, "手機號碼有誤");
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
	public ResponseResult userRegister(String username, String password, String password2, 
			String email, String phone, String verification, HttpSession session) {
		ResponseResult responseResult;
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
			//String salt = "愛的是非對錯已太多";
			ResourceBundle properties = ResourceBundle.getBundle("db");
			String salt = properties.getString("salt");
			password = password + salt;
			
			User user = new User();
			user.setUsername(username);
			user.setPassword(DigestUtils.md5Hex(password));
			user.setEmail(email);
			user.setPhone(phone);
			int result = userService.userRegister(user);
			if (result == 1) {
				return responseResult = new ResponseResult(1, "註冊成功");
			} else {
				return responseResult = new ResponseResult(0, "註冊失敗");
			}
		}
		return responseResult = new ResponseResult(0, "資料有誤，請先核對再註冊");
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
	public ResponseResult userLogin(String username, String password, String verification, 
			HttpSession session) {
		ResponseResult responseResult;
		String verificationQ = (String) session.getAttribute("verification");
		if (!verificationQ.equals(verification.toUpperCase())) {
			return responseResult = new ResponseResult(2, "驗證碼錯誤");
		} else {
			User user = userService.findUserByUsername(username);
			if (user == null) {
				return responseResult = new ResponseResult(0, "無此帳號");
			} else {
				ResourceBundle properties = ResourceBundle.getBundle("db");
				String salt = properties.getString("salt");
				password = password + salt;
				if (!user.getPassword().equals(DigestUtils.md5Hex(password))) {
					return responseResult = new ResponseResult(0, "密碼錯誤");
				}
			}
			session.setAttribute("userId", user.getId());
			return responseResult = new ResponseResult(1, "登入成功");
		}
	}

}
