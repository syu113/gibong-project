package com.gibong.web.model;

import java.io.Serializable;

public class Volun implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long volunSeq;
	private String userId;
	private String volunTitle;
	private String volunContent;
	private String volunFlag;
	private String regdate;
	private String volunTarget;
	private String volunPlace;
	private String volunType;
	private int volunPeople;
	private String endDate;
	private int volunTime;
	private String userName;
	private String userEmail;
	private String userPhone;
	
	private long startRow;				//시작 rownum
	private long endRow;				//끝 rownum
	
	public Volun() 
	{
		volunSeq = 0;
		userId = "";
		volunTitle = "";
		volunContent = "";
		volunFlag = "";
		regdate = "";
		volunTarget = "";
		volunPlace = "";
		volunType = "";
		volunPeople = 0;
		endDate = "";
		volunTime = 0;
		userName = "";
		userEmail = "";
		userPhone = "";
		
		startRow = 0;
		endRow = 0;
	}

	public long getVolunSeq() {
		return volunSeq;
	}

	public void setVolunSeq(long volunSeq) {
		this.volunSeq = volunSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getVolunTitle() {
		return volunTitle;
	}

	public void setVolunTitle(String volunTitle) {
		this.volunTitle = volunTitle;
	}

	public String getVolunContent() {
		return volunContent;
	}

	public void setVolunContent(String volunContent) {
		this.volunContent = volunContent;
	}

	public String getVolunFlag() {
		return volunFlag;
	}

	public void setVolunFlag(String volunFlag) {
		this.volunFlag = volunFlag;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getVolunTarget() {
		return volunTarget;
	}

	public void setVolunTarget(String volunTarget) {
		this.volunTarget = volunTarget;
	}

	public String getVolunPlace() {
		return volunPlace;
	}

	public void setVolunPlace(String volunPlace) {
		this.volunPlace = volunPlace;
	}

	public String getVolunType() {
		return volunType;
	}

	public void setVolunType(String volunType) {
		this.volunType = volunType;
	}

	public int getVolunPeople() {
		return volunPeople;
	}

	public void setVolunPeople(int volunPeople) {
		this.volunPeople = volunPeople;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getVolunTime() {
		return volunTime;
	}

	public void setVolunTime(int volunTime) {
		this.volunTime = volunTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	
	
}
