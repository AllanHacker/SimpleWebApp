package wang.store.user;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import wang.store.common.ResponseResult;
/**
 * 驗證碼的控制器
 * @author wbx
 *
 */
@Controller
public class VerificationController {
	
	/**
	 * 比對使用者輸入的驗證碼與系統儲存的驗證碼是否正確
	 * @param verificationA 使用者輸入的驗證碼字串
	 * @param session 系統儲存的位置
	 * @return 正確返回1，錯誤返回0
	 */
	@RequestMapping(value = "/verificationCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseResult<Void> verificationCheck(String verification, HttpSession session) {
		ResponseResult<Void> responseResult;
		String verificationQ = (String) session.getAttribute("verification");
		if (verificationQ.equals(verification.toUpperCase())) {
			responseResult = new ResponseResult<Void>(1, "驗證成功");
		} else {
			responseResult = new ResponseResult<Void>(0, "請再看清楚一點");
		}
		return responseResult;
	}
	
	/**
	 * 將驗證碼字串畫成圖片
	 * @param session 系統產生的驗證碼字串所儲存的位置
	 * @return 驗證碼圖片
	 * @throws IOException
	 */
	@RequestMapping(value="/verification.do", produces="image/png")
	@ResponseBody
	public byte[] getVerificationCode(HttpSession session) throws IOException {
		int length = 5;
		String words = getWords(length);
		session.setAttribute("verification", words);
		
		BufferedImage image = new BufferedImage(100,25,BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		Random r = new Random();
		g.setColor(new Color(255,255,255));
		g.fillRect(0, 0, 100, 25);
		g.setColor(new Color(r.nextInt(255), r.nextInt(255),r.nextInt(255)));
		g.setFont(new Font(null,Font.BOLD,24));
		g.drawString(words, 0, 25);
		
		for(int i = 0; i < 7; i ++){
			g.setColor(new Color(r.nextInt(255), r.nextInt(255),r.nextInt(255)));
			g.drawLine(r.nextInt(image.getWidth()), r.nextInt(image.getHeight()), r.nextInt(image.getWidth()), r.nextInt(image.getHeight()));
		}

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		ImageIO.write(image, "png", out);
		out.close();
		byte[] bytes = out.toByteArray();
		return bytes;
	}
	
	/**
	 * 產生驗證碼字串
	 * @param length 指定要產生幾個字
	 * @return 驗證碼字串
	 */
	private String getWords(int length) {
		String words = "";
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789";
		Random r = new Random();
		for(int i = 0; i < length; i ++){
			words += chars.charAt(r.nextInt(chars.length()));
		}
		return words;
	}
}
