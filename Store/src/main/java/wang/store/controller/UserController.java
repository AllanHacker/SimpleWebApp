package wang.store.controller;

import javax.annotation.Resource;

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
	@RequestMapping("/register.do")
	public String showRegister() {
		return "register";
	}
	
	/**
	 * 使用者註冊功能
	 * @param username 帳號
	 * @param password 密碼
	 * @param email 電郵
	 * @param phone 手機
	 * @return 0是失敗，1是成功
	 */
	@RequestMapping(value = "userRegister.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult userRegister(String username, String password, String email, String phone) {
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setPhone(phone);
		int result = userService.userRegister(user);
		ResponseResult responseResult;
		if (result == 0) {
			return responseResult = new ResponseResult(0, "註冊失敗");
		} else {
			return responseResult = new ResponseResult(1, "註冊成功");
		}
	}
	
}
