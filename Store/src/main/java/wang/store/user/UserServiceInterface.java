package wang.store.user;

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
	 * @return 未被刪除的會員資料
	 */
	User findUserByUserId(Integer userId);
	
	/**
	 * 根據會員帳號名稱查找會員資料
	 * @param username 會員帳號名稱
	 * @return 未被刪除的會員資料
	 */
	User findUserByUsername(String username);
	
	/**
	 * 修改會員的資料
	 * @param user 新的會員資料
	 * @return 受影響的行數
	 */
	Integer userUpdate(User user);
}
