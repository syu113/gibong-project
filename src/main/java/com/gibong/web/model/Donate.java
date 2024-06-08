package com.gibong.web.model;

import java.io.Serializable;

public class Donate implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long donateSeq;
	private String userId;
	private String donateFlag;
	private String donateTitle;
	private String donateContent;
	private String regdate;
	private long donateNowAmt;
	private long donateGoalAmt;
	private String finishFlag;
	private String closeDate;
	private long progress;
	
	private String fileName;
	private String fileOrgName;
	
	private DonateFile donateFile;
	
	private long startRow;
	private long endRow;
	
	public Donate()
	{
		donateSeq = 0;
		userId = "";
		donateFlag = "";
		donateTitle = "";
		donateContent = "";
		regdate = "";
		donateNowAmt = 0;
		donateGoalAmt = 0;
		finishFlag = "";
		closeDate = "";
		progress = 0;
		
		fileName = "";
		fileOrgName = "";
		
		donateFile = null;
		
		startRow = 0;
		endRow = 0;
	}

	public long getDonateSeq() {
		return donateSeq;
	}

	public void setDonateSeq(long donateSeq) {
		this.donateSeq = donateSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDonateFlag() {
		return donateFlag;
	}

	public void setDonateFlag(String donateFlag) {
		this.donateFlag = donateFlag;
	}

	public String getDonateTitle() {
		return donateTitle;
	}

	public void setDonateTitle(String donateTitle) {
		this.donateTitle = donateTitle;
	}

	public String getDonateContent() {
		return donateContent;
	}

	public void setDonateContent(String donateContent) {
		this.donateContent = donateContent;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public long getDonateNowAmt() {
		return donateNowAmt;
	}

	public void setDonateNowAmt(long donateNowAmt) {
		this.donateNowAmt = donateNowAmt;
	}

	public long getDonateGoalAmt() {
		return donateGoalAmt;
	}

	public void setDonateGoalAmt(long donateGoalAmt) {
		this.donateGoalAmt = donateGoalAmt;
	}

	public String getFinishFlag() {
		return finishFlag;
	}

	public void setFinishFlag(String finishFlag) {
		this.finishFlag = finishFlag;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
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

	public long getProgress() {
		return progress;
	}

	public void setProgress(long progress) {
		this.progress = progress;
	}

	public DonateFile getDonateFile() {
		return donateFile;
	}

	public void setDonateFile(DonateFile donateFile) {
		this.donateFile = donateFile;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}
	
	
	
}
