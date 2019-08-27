package wang.store.address;

import org.apache.ibatis.annotations.Param;

public interface AddressMapper {
	
	/**
	 * 查詢出全台灣的縣市
	 * @return 全台灣的縣市
	 */
	String[] selectCity();
	
	/**
	 * 查詢出某個縣市的鄉鎮區
	 * @param city 縣市
	 * @return 該縣市的鄉鎮區
	 */
	String[] selectDistrict(String city);
	
	/**
	 * 查詢出某縣市中的某鄉鎮區中的所有路名
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @return 某縣市中的某鄉鎮區中的所有路名
	 */
	String[] selectRoad(@Param("city") String city, @Param("district") String district);
	
	/**
	 * 查詢出某個區域的郵遞區號
	 * @param city 縣市
	 * @param district 鄉鎮區
	 * @param road 道路
	 * @return 郵遞區號
	 */
	Integer selectPostalCode(@Param("city") String city, @Param("district") String district, @Param("road") String road);
	
}
