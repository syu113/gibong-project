package com.gibong.web.model;

import java.io.Serializable;

public class ReviewFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long reviewSeq;			//후기글번호
	private short fileSeq;			//파일번호(HIBBS_SEQ MAX+1)
	private String fileOrgName;		//원본 파일명
	private String fileName;		//파일명
	private String fileExt;			//파일 확장자
	private long fileSize;			//파일 크기
	private String regdate;			//등록일
	
	public ReviewFile()
	{
		reviewSeq = 0;
		fileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regdate = "";
	}

	public long getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(long reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public short getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(short fileSeq) {
		this.fileSeq = fileSeq;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}