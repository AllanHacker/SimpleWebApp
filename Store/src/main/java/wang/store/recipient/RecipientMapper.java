package wang.store.recipient;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RecipientMapper {
	
	/**
	 * 查詢出全台灣的縣市
	 * @return 全台灣的縣市
	 */
	String[] cityOption();
	
	/**
	 * 查詢出某個縣市的鄉鎮區
	 * @param city 縣市
	 * @return 該縣市的鄉鎮區
	 */
	String[] districtOption(String city);
	
	/**
	 * 查詢出某縣市中的某鄉鎮區中的所有路名
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @return 某縣市中的某鄉鎮區中的所有路名
	 */
	String[] roadOption(@Param("city") String city, @Param("district") String district);
	
	/**
	 * 查詢出某個區域的郵遞區號
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @param road 道路
	 * @return 郵遞區號
	 */
	Integer postalCode(@Param("city") String city, @Param("district") String district, @Param("road") String road);
	
	/**
	 * 新增收件人
	 * @param recipient 收件人資料
	 * @return 受影響的行數
	 */
	Integer insert(Recipient recipient);
	
	/**
	 * 以會員id查詢收件人
	 * @param userId 會員id
	 * @return 收件人列表
	 */
	List<Recipient> recipientFindByUserId(Integer userId);

	/**
	 * 以會員id及收件人id查詢收件人
	 * @param userId 會員id
	 * @param id 收件人id
	 * @return 符合的該項收件人資料
	 */
	Recipient recipientFindByUserIdAndId(@Param("userId") Integer userId, @Param("id") Integer id);

	/**
	 * 根據收件人id刪除收件人資料
	 * @param id 收件人id
	 * @return 受影響的行數
	 */
	Integer recipientDelete(Integer id);
	
	/**
	 * 將所有收件人的預設清除
	 * @param userId 會員id
	 * @return 受影響的行數
	 */
	Integer recipientDefaultClear(Integer userId);
	
	/**
	 * 設定預設收件人
	 * @param userId 會員id
	 * @param id 收件人id
	 * @return 受影響的行數
	 */
	Integer recipientDefaultSet(@Param("userId") Integer userId, @Param("id") Integer id);
	
	/**
	 * 修改收件人
	 * @param recipient 新的收件人資料
	 * @return 受影響的行數
	 */
	Integer recipientUpdate(Recipient recipient);
	
}
