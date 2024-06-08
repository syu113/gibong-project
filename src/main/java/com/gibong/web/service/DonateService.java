package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.web.dao.DonateDao;
import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;
import com.gibong.web.model.ReviewFile;

@Service("donateService")
public class DonateService 
{
	private static Logger logger = LoggerFactory.getLogger(DonateService.class);
	
	@Autowired
	private DonateDao donateDao;
	
	public List<Donate> donateList(Donate donate)
	{
		List<Donate> list = null;
		
		try
		{
			list = donateDao.donateList(donate);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateList Exception", e);
		}
		
		return list;
	}
	
	public long donateTotalCount(Donate donate)
	{
		long count = 0;

		try
		{
			count = donateDao.donateTotalCount(donate);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateTotalCount Exception", e);
		}
		
	
		return count;
	}
	
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int donateInsert(Donate donate)
	{
		int count = 0;
		
		count = donateDao.donateInsert(donate);
		
		if(count > 0 && donate.getDonateFile() != null)
		{
			DonateFile donateFile = donate.getDonateFile();
			
			donateFile.setDonateSeq(donate.getDonateSeq());
			donateFile.setFileSeq((short)1);
			
			donateDao.donateFileInsert(donateFile);
		}
		
		return count;
	}
	
	//후원 상세 게시물 조회
	public Donate donateViewSelect(long donateSeq)
	{
		Donate donate = null;
		
		try
		{
			donate = donateDao.donateViewSelect(donateSeq);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateViewSelect Exception", e);
		}
		
		return donate;
	}
	
	//카카오페이 결제
	public int donatePayment(Donate donate)
	{
		int count = 0;
		
		try
		{
			count = donateDao.donatePayment(donate);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donatePayment Exception", e);
		}
		
		return count;
	}
}
