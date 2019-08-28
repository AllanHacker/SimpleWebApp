package wang.store.recipient;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("recipientServiceImplement")
public class RecipientServiceImplement implements RecipientServiceInterface{
	
	@Resource(name = "recipientMapper")
	private RecipientMapper recipientMapper;
	
	public Integer add(Recipient recipient) {
		return recipientMapper.insert(recipient);
	}

	public List<Recipient> findByUserId(Integer userId) {
		return recipientMapper.selectByUserId(userId);
	}
	
	public Recipient findByUserIdAndId(Integer userId, Integer id) {
		return recipientMapper.selectByUserIdAndId(userId, id);
	}

	public Integer delete(Integer id) {
		return recipientMapper.delete(id);
	}

	public Integer defaultClear(Integer userId) {
		return recipientMapper.defaultClear(userId);
	}

	public Integer defaultSet(Integer userId, Integer id) {
		return recipientMapper.defaultSet(userId, id);
	}

	public Integer change(Recipient recipient) {
		return recipientMapper.update(recipient);
	}

}
