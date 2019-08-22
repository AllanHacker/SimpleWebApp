package wang.store.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("commonController")
public class CommonController {
	
	/**
	 * 顯示首頁
	 * @return 首頁
	 */
	@RequestMapping("/indexPage.do")
	public String indexPage() {
		return "index";
	}
	
	/**
	 * 顯示註冊頁面
	 * @return 註冊頁面
	 */
	@RequestMapping("/registerPage.do")
	public String registerPage() {
		return "register";
	}
	
	/**
	 * 顯示登入頁面
	 * @return 登入頁面
	 */
	@RequestMapping("/loginPage.do")
	public String loginPage() {
		return "login";
	}
	
}
