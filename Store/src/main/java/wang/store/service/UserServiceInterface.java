package wang.store.service;

import wang.store.bean.User;

public interface UserServiceInterface {
	
	/**
	 * 新會員註冊
	 * @param user 新會員的資料
	 * @return 受影響的行數
	 */
	Integer userRegister(User user);
	
	/**
	 * 根據會員的id查找會員資料
	 * @param userId 會員id
	 * @return 會員資料
	 */
	User findUserByUserId(Integer userId);
	
	/**
	 * 根據會員帳號名稱查找會員資料
	 * @param username 會員帳號名稱
	 * @return 會員資料
	 */
	User findUserByUsername(String username);
}
