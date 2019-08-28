package wang.store.recipient;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("recipientServiceImplement")
public class RecipientServiceImplement implements RecipientServiceInterface{
	
	@Resource(name = "recipientMapper")
	private RecipientMapper recipientMapper;
	
	public Integer insert(Recipient recipient) {
		return recipientMapper.insert(recipient);
	}

	public List<Recipient> recipientFindByUserId(Integer userId) {
		return recipientMapper.selectByUserId(userId);
	}
	
	public Recipient recipientFindByUserIdAndId(Integer userId, Integer id) {
		return recipientMapper.selectByUserIdAndId(userId, id);
	}

	public Integer recipientDelete(Integer id) {
		return recipientMapper.delete(id);
	}

	public Integer recipientDefaultClear(Integer userId) {
		return recipientMapper.defaultClear(userId);
	}

	public Integer recipientDefaultSet(Integer userId, Integer id) {
		return recipientMapper.defaultSet(userId, id);
	}

	public Integer recipientUpdate(Recipient recipient) {
		return recipientMapper.update(recipient);
	}

}
