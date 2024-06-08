package com.gibong.web.model;

import java.io.Serializable;

public class User implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	public String userId;
	public String userPwd;
	public String userPhone;
	public String userEmail;
	public String userEmailFlag;
	public String userName;
	public String userStatus;
	public String userFlag;
	public String userRegdate;
	public String userZipcode;
	public String userAddr1;
	public String userAddr2;
	
	public User()
	{
		userId = "";
		userPwd = "";
		userPhone = "";
		userEmail = "";
		userEmailFlag = "";
		userName = "";
		userStatus = "";
		userFlag = "";
		userRegdate = "";
		userZipcode = "";
		userAddr1 = "";
		userAddr2 = "";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserEmailFlag() {
		return userEmailFlag;
	}

	public void setUserEmailFlag(String userEmailFlag) {
		this.userEmailFlag = userEmailFlag;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}

	public String getUserRegdate() {
		return userRegdate;
	}

	public void setUserRegdate(String userRegdate) {
		this.userRegdate = userRegdate;
	}

	public String getUserZipcode() {
		return userZipcode;
	}

	public void setUserZipcode(String userZipcode) {
		this.userZipcode = userZipcode;
	}

	public String getUserAddr1() {
		return userAddr1;
	}

	public void setUserAddr1(String userAddr1) {
		this.userAddr1 = userAddr1;
	}

	public String getUserAddr2() {
		return userAddr2;
	}

	public void setUserAddr2(String userAddr2) {
		this.userAddr2 = userAddr2;
	}

	
}
