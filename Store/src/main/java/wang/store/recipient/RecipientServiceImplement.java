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
		return recipientMapper.recipientFindByUserId(userId);
	}
	
	public Recipient recipientFindByUserIdAndId(Integer userId, Integer id) {
		return recipientMapper.recipientFindByUserIdAndId(userId, id);
	}

	public Integer recipientDelete(Integer id) {
		return recipientMapper.recipientDelete(id);
	}

	public Integer recipientDefaultClear(Integer userId) {
		return recipientMapper.recipientDefaultClear(userId);
	}

	public Integer recipientDefaultSet(Integer userId, Integer id) {
		return recipientMapper.recipientDefaultSet(userId, id);
	}

	public Integer recipientUpdate(Recipient recipient) {
		return recipientMapper.recipientUpdate(recipient);
	}

}
