package wang.store.mapper;

import wang.store.bean.User;

public interface UserMapper {
	/**
	 * 向資料庫新增用戶
	 * @param user 新用戶的資料
	 * @return 受影響的行數
	 */
	Integer insert(User user);
}
