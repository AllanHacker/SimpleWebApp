package wang.store.service;

import wang.store.bean.User;

public interface UserServiceInterface {
	
	/**
	 * 新用戶註冊
	 * @param user 新用戶的資料
	 * @return 受影響的行數
	 */
	Integer userRegister(User user);
	
}
