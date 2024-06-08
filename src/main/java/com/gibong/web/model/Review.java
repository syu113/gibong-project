package com.gibong.web.model;

import java.io.Serializable;
import java.util.List;

public class Review implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long reviewSeq;
	private String userId;
	private String userName;
	private String reviewTitle;
	private String reviewContent;
	private String reviewDelFlag;
	private int reviewReadCnt;
	private int reviewLikeCnt;
	private String regdate;
	private String fileName;
	private String fileOrgName;
	
	private long replyCount;
	
	private long startRow;
	private long endRow;
	
	private String searchType;
	private String searchValue;
	
	
	
	private ReviewFile reviewFile;
	
	public Review()
	{
		reviewSeq = 0;
		userId = "";
		userName = "";
		reviewTitle = "";
		reviewContent = "";
		reviewDelFlag = "";
		reviewReadCnt = 0;
		reviewLikeCnt = 0;
		regdate = "";
		fileName = "";
		fileOrgName = "";
		
		replyCount = 0;
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
		
		reviewFile = null;
	}


	public long getReviewSeq() {
		return reviewSeq;
	}


	public void setReviewSeq(long reviewSeq) {
		this.reviewSeq = reviewSeq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getReviewTitle() {
		return reviewTitle;
	}


	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}


	public String getReviewContent() {
		return reviewContent;
	}


	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}


	public String getReviewDelFlag() {
		return reviewDelFlag;
	}


	public void setReviewDelFlag(String reviewDelFlag) {
		this.reviewDelFlag = reviewDelFlag;
	}


	public int getReviewReadCnt() {
		return reviewReadCnt;
	}


	public void setReviewReadCnt(int reviewReadCnt) {
		this.reviewReadCnt = reviewReadCnt;
	}


	public int getReviewLikeCnt() {
		return reviewLikeCnt;
	}


	public void setReviewLikeCnt(int reviewLikeCnt) {
		this.reviewLikeCnt = reviewLikeCnt;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
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


	public ReviewFile getReviewFile() {
		return reviewFile;
	}


	public void setReviewFile(ReviewFile reviewFile) {
		this.reviewFile = reviewFile;
	}


	public String getSearchType() {
		return searchType;
	}


	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	public String getSearchValue() {
		return searchValue;
	}


	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
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


	public long getReplyCount() {
		return replyCount;
	}


	public void setReplyCount(long replyCount) {
		this.replyCount = replyCount;
	}

	
	
	
}
