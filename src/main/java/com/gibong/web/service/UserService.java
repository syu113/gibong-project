package com.gibong.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.controller.UserController;
import com.gibong.web.dao.UserDao;
import com.gibong.web.model.User;

@Service("userService")
public class UserService 
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	//회원정보
	public User userSelect(String userId)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception ", e);
		}
		
		
		return user; 
	}
	
	public User userFindId(String userEmail)
	{
		User user = null;
		
		try
		{
			user = userDao.userFindId(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userFindId Exception ", e);
		}
		
		
		return user; 
	}
	
	//회원가입
	public int userInsert(User user)
	{
		int count= 0;
		
		try
		{
			count = userDao.userInsert(user);
		}
		catch(Exception e)
		{
			logger.error("[userService] userInsert Exception" , e);
		}
		
		return count;
	}
	
	//회원정보수정
	public int userUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[userService] userUpdate Exception" , e);
		}
		
		return count;
	}
	
	//임시비밀번호
	public int pwdUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.pwdUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[userService] pwdUpdate Exception" , e);
		}
		
		
		return count;
	}
	
	//회원탈퇴
	public int userDelete(String userId)
	{
		int count = 0;
		
		try
		{
			count = userDao.userDelete(userId);
		}
		catch(Exception e)
		{
			logger.error("[userService] userDelete Exception" , e);
		}
		
		return count;
	}
}
