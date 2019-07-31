package wang.store.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import wang.store.bean.User;
import wang.store.mapper.UserMapper;

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

}
