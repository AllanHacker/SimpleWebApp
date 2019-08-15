package wang.store.address;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AddressMapper {
	
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
	String[] countryOption(String city);
	
	/**
	 * 查詢出某縣市中的某鄉鎮區中的所有路名
	 * @param city 縣市
	 * @param country 鄉鎮區
	 * @return 某縣市中的某鄉鎮區中的所有路名
	 */
	String[] roadOption(@Param("city") String city, @Param("country") String country);
	
	/**
	 * 新增地址
	 * @param address 地址資料
	 * @return 受影響的行數
	 */
	Integer insert(Address address);
	
	/**
	 * 以會員id查詢地址
	 * @param userId 會員id
	 * @return 地址列表
	 */
	List<Address> addressFindByUserId(Integer userId);
	
	/**
	 * 根據地址id刪除地址資料
	 * @param id 地址id
	 * @return 受影響的行數
	 */
	Integer addressDelete(Integer id);
}
