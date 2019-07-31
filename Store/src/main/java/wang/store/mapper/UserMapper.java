package wang.store.mapper;

import wang.store.bean.User;

public interface UserMapper {
	/**
	 * 向資料庫新增會員
	 * @param user 新會員的資料
	 * @return 受影響的行數
	 */
	Integer insert(User user);
	
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
