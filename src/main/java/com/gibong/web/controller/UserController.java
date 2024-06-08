package com.gibong.web.controller;

import java.security.SecureRandom;
import java.util.Date;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gibong.common.util.StringUtil;
import com.gibong.web.model.Response;
import com.gibong.web.model.User;
import com.gibong.web.service.UserService;
import com.gibong.web.util.HttpUtil;
import com.gibong.web.util.JsonUtil;
import com.gibong.web.util.CookieUtil;

@Controller("userController")
public class UserController 
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	
	@RequestMapping(value="/user/login")
	public String userLogin(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/login";
	}
	
	@RequestMapping(value="/user/loginProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				if(StringUtil.equals(userPwd, user.getUserPwd()))
				{
					if(StringUtil.equals(user.getUserStatus(), "Y"))
					{
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME , CookieUtil.stringToHex(userId));
						ajaxResponse.setResponse(0, "Success Request");
					}
					else
					{
						ajaxResponse.setResponse(-99, "fail");
					}
				}
				else
				{
					ajaxResponse.setResponse(-1, "password error");
				}
			}
			else
			{
				ajaxResponse.setResponse(-1, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/user/loginOut")
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "redirect:/";
	}
	
	
	@RequestMapping(value="/user/join")
	public String userJoin(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			return "redirect:/";		//재접속하라는 명령
		}
		else
		{
			return "/user/join";
		}
		
	}
	
	//아이디 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		
		
		if(!StringUtil.isEmpty(userId))
		{
			
			if(userService.userSelect(userId) == null)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				ajaxResponse.setResponse(100, "fail");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "error");
		}
		
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/idCheck reponse\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	
	
	//이메일 인증
	@RequestMapping(value = "/emailAuth", method = RequestMethod.POST)
	@ResponseBody
	public String emailAuth(String email) 
	{		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		
		/* 이메일 보내기 */
        String setFrom = "syu113@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try 
        {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
        }
        catch(Exception e) 
        {
            logger.error("[UserController] emailAuth Exception ", e);
        }
        
        logger.debug("111111111111111111111111111");
        logger.debug("checkNum : " + checkNum);
        
        return Integer.toString(checkNum);
 
	}
	
	
	@RequestMapping(value="/user/regProc")
	@ResponseBody
	public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userFlag = HttpUtil.get(request, "userFlag");
		String userId = HttpUtil.get(request, "userId", "");
		String userPwd = HttpUtil.get(request, "userPwd", "");
		String userName = HttpUtil.get(request, "userName", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");
		String userPhone = HttpUtil.get(request, "userPhone", "");
		String userZipcode = HttpUtil.get(request, "zipcode", "");
		String addr1 = HttpUtil.get(request, "addr1", "");
		String addr2 = HttpUtil.get(request, "addr2", "");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)
				&& !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPhone)
				&& !StringUtil.isEmpty(addr1) && !StringUtil.isEmpty(addr2))
		{
			logger.debug("====================");
			logger.debug("userFlag : " + userFlag );
			logger.debug("====================");
			
			if(userService.userSelect(userId) == null)
			{
				User user = new User();
				
				user.setUserFlag(userFlag);
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserStatus("Y");
				user.setUserEmail(userEmail);
				user.setUserEmailFlag("O");
				user.setUserPhone(userPhone);
				user.setUserZipcode(userZipcode);
				user.setUserAddr1(addr1);
				user.setUserAddr2(addr2);
				
				if(userService.userInsert(user) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(500, "success");
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "fail");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/regProc reponse\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	
	
	//아이디 비밀번호 찾기
	
	@RequestMapping(value = "/user/findId", method=RequestMethod.GET)
	public String findId(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/findId";
	}
	
	
	@RequestMapping(value = "/user/findIdProc")
	public String findIdProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");
		
		
		if(!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
		{
			logger.debug("========================");
			logger.debug("userId : " + userName);
			logger.debug("userEmail : " + userEmail);
			logger.debug("========================");
			
			User user = userService.userFindId(userEmail);
			
			if(user != null && StringUtil.equals(userEmail, user.getUserEmail())
					&& StringUtil.equals(userName, user.getUserName()))
			{
				model.addAttribute("user", user);
			}
			
		}
		
		return "/user/findIdProc";
	}
	
	
	@RequestMapping(value = "/user/findPwd", method=RequestMethod.GET)
	public String findPwd(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/findPwd";
	}
	
	
	@RequestMapping(value = "/user/findPwdProc", method = RequestMethod.POST)
	@ResponseBody
	public String findPwdProc(String email) 
	{		
		Random random = new Random();
		//int checkNum = random.nextInt(888888) + 111111;
		
		String checkNum = getRamdomPassword(10);
		
		/* 이메일 보내기 */
        String setFrom = "syu113@naver.com";
        String toMail = email;
        String title = "임시비밀번호 입니다.";
        String content = 
                "임시비밀번호 발급" +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        User user = userService.userFindId(email);
        
        if(user != null)
        {
        	if(StringUtil.equals(email, user.getUserEmail()))
        	{
        		user.setUserPwd(checkNum);
        		
        		if(userService.userUpdate(user) > 0)
        		{
			        try 
			        {
			            MimeMessage message = mailSender.createMimeMessage();
			            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			            helper.setFrom(setFrom);
			            helper.setTo(toMail);
			            helper.setSubject(title);
			            helper.setText(content,true);
			            mailSender.send(message);
			        }
			        catch(Exception e) 
			        {
			            logger.error("[UserController] emailAuth Exception ", e);
			        }
        		}
        	}
        }
        
        return checkNum;
	}
	
	//임시비밀번호 발급
	public String getRamdomPassword(int size) {        
		char[] charSet = new char[] 
		{               
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',                
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
				'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',                
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
				'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',                
				'!', '@', '#', '$', '%', '^', '&' 
		};         
		StringBuffer sb = new StringBuffer();        
		SecureRandom sr = new SecureRandom();        
		sr.setSeed(new Date().getTime());         
		
		int idx = 0;        
		int len = charSet.length;        
		for (int i=0; i<size; i++) 
		{            
			// idx = (int) (len * Math.random());            
			idx = sr.nextInt(len);    
			// 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.            
			sb.append(charSet[idx]);        
		}         
	
		
		return sb.toString();    
	}
	
		
	////////////////////////////////////////
	//마이페이지
	
	@RequestMapping(value = "/user/mypage", method=RequestMethod.GET)
	public String mypage(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/mypage";
	}
	
	@RequestMapping(value = "/user/info", method=RequestMethod.GET)
	public String infoList(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/infoList";
	}
	
	
	//회원정보수정
	@RequestMapping(value = "/user/infoUpdate", method=RequestMethod.GET)
	public String infoUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		
		if(userId != null)
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				model.addAttribute("user", user);
				
				logger.debug("===========================");
				logger.debug("userName : " + user.getUserName());
				logger.debug("userEmail : " + user.getUserEmail());
				logger.debug("userPhone : " + user.getUserPhone());
				logger.debug("===========================");
			}
		}
		
		
		return "/user/infoUpdate";
	}
	
	@RequestMapping(value = "/user/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String userId = HttpUtil.get(request, "userId", "");
		String userPwd = HttpUtil.get(request, "userPwd", "");
		String userName = HttpUtil.get(request, "userName", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");
		String userPhone = HttpUtil.get(request, "userPhone", "");
		String userZipcode = HttpUtil.get(request, "zipcode", "");
		String userAddr1 = HttpUtil.get(request, "addr1", "");
		String userAddr2 = HttpUtil.get(request, "addr2", "");
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			logger.debug("===========================");
			logger.debug("userId : " + userId);
			logger.debug("userPwd : " + userPwd);
			logger.debug("userName : " + userName);
			logger.debug("userEmail : " + userEmail);
			logger.debug("userPhone : " + userPhone);
			logger.debug("userZipcode : " + userZipcode);
			logger.debug("userAddr1 : " + userAddr1);
			logger.debug("userAddr2 : " + userAddr2);
			logger.debug("===========================");
			
			if(!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)
					&& !StringUtil.isEmpty(userPhone) && !StringUtil.isEmpty(userZipcode) &&
					!StringUtil.isEmpty(userAddr1) && !StringUtil.isEmpty(userAddr2))
			{
				if(StringUtil.equals(cookieUserId, userId))
				{
					User user = userService.userSelect(userId);
					
					if(user != null)
					{
						user.setUserPwd(userPwd);
						user.setUserName(userName);
						user.setUserEmail(userEmail);
						user.setUserPhone(userPhone);
						user.setUserZipcode(userZipcode);
						user.setUserAddr1(userAddr1);
						user.setUserAddr2(userAddr2);
						
						if(userService.userUpdate(user) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "server error");
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "error");
					}
				}
				else
				{
					ajaxResponse.setResponse(430, "fail");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "bad request");
			}
		}
		else
		{
			ajaxResponse.setResponse(410, "no login");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/myVolun")
	public String myVolun(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/myVolun";
	}
	
	@RequestMapping(value="/user/deleteProc")
	@ResponseBody
	public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(cookieUserId))
		{
			if(StringUtil.equals(userId, cookieUserId))
			{
				if(userService.userDelete(cookieUserId) > 0)
				{
					ajaxResponse.setResponse(0, "success");
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				}
				else
				{
					ajaxResponse.setResponse(405, "error2");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad Request");
		}
		
		return ajaxResponse;
	}
}
