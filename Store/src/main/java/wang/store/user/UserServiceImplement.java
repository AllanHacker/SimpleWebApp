package wang.store.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("userServiceImplement")
public class UserServiceImplement implements UserServiceInterface{
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	public Integer userRegister(User user) {
		int result = userMapper.insert(user);
		return result;
	}

	public User findUserByUserId(Integer userId) {
		User user = userMapper.findUserByUserId(userId);
		return user;
	}

	public User findUserByUsername(String username) {
		User user = userMapper.findUserByUsername(username);
		return user;
	}

	public Integer userUpdate(User user) {
		Integer result = userMapper.update(user);
		return result;
	}

}
