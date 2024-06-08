package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;

@Repository
public interface DonateDao 
{
	//게시판리스트
	public List<Donate> donateList(Donate donate);
	
	//토탈카운트
	public long donateTotalCount(Donate donate);
	
	//게시판등록
	public int donateInsert(Donate donate);
	
	//첨부파일 등록
	public int donateFileInsert(DonateFile donateFile);
	
	//후원 상세
	public Donate donateViewSelect(long donateSeq);
	
	//카카오페이 결제
	public int donatePayment(Donate donate);
	
}
