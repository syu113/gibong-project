package com.gibong.web.dao;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.User;

@Repository
public interface UserDao 
{
	//회원정보
	public User userSelect(String userId);
	//회원아이디찾기
	public User userFindId(String userEmail);
	
	//회원가입
	public int userInsert(User user);
	
	//회원정보수정
	public int userUpdate(User user);
	
	//임시비밀번호
	public int pwdUpdate(User user);
	
	//회원탈퇴
	public int userDelete(String userId);
}
