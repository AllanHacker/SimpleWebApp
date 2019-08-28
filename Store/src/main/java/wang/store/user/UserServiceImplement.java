package wang.store.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("userServiceImplement")
public class UserServiceImplement implements UserServiceInterface{
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	public Integer add(User user) {
		int result = userMapper.insert(user);
		return result;
	}

	public User findByUserId(Integer userId) {
		User user = userMapper.selectByUserId(userId);
		return user;
	}

	public User findByUsername(String username) {
		User user = userMapper.selectByUsername(username);
		return user;
	}

	public Integer change(User user) {
		Integer result = userMapper.update(user);
		return result;
	}

}
